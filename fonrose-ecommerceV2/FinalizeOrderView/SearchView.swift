//
//  SearchView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 25/07/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit

struct SearchView: View {
    
    @State var result: [SearchData] = []
    @Binding var show: Bool
    @Binding var map: MKMapView
    @Binding var source: CLLocationCoordinate2D!
    @Binding var destination: CLLocationCoordinate2D!
    @Binding var name: String
    @State var txt = ""
    @State var isBold: Bool = false
    
    var body: some View {
        
        //GeometryReader{_ in
            
        VStack {
            
            Spacer()
                .frame(height: 50)
            
                VStack {
                    
                    SearchBar(map: self.$map, source: self.$source, destination: self.$source, result: self.$result, name: self.$name, txt: self.$txt)
                    
                    Spacer()
                                    
                    if self.txt != "" {
                        
                        VStack {
                            
                            List(self.result) {i in
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(i.name)
                                        .fontWeight(self.isBold ? .bold : .none)
                                        .listRowBackground(Color.green)
                                    Text(i.address)
                                        .font(.caption)
                                    
                                }
                                    
                                .onTapGesture {
                                    self.destination = i.coordinate
                                    self.UpdateMap()
                                    self.show.toggle()
                                    self.isBold.toggle()
                                }
                            }
                            
                        }
                    }
                    
                Spacer()
                                    
            }
            
        }
        
    }
    func UpdateMap() {
        
        let point = MKPointAnnotation()
        point.subtitle = "Destination"
        point.coordinate = destination
        
        
        let decoder = CLGeocoder()
        decoder.reverseGeocodeLocation(CLLocation(latitude: destination.latitude, longitude: destination.longitude)) { (places, err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            self.name = places?.first?.name ?? ""
            point.title = places?.first?.name ?? ""
            
        }
        
        let req = MKDirections.Request()
        req.source = MKMapItem(placemark: MKPlacemark(coordinate: self.source))
        
        req.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        
        let directions = MKDirections(request: req)
        
        directions.calculate { (dir, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
        
            let polyline = dir?.routes[0].polyline
            
            self.map.removeOverlays(self.map.overlays)
            
            self.map.addOverlay(polyline!)
            
            self.map.setRegion(MKCoordinateRegion(polyline! .boundingMapRect), animated: true)
        }
        //self.map.removeAnnotation(self.map.annotations)
        self.map.addAnnotation(point)
    }
}

struct SearchBar: UIViewRepresentable {
    
    @Binding var map: MKMapView
    @Binding var source: CLLocationCoordinate2D!
    @Binding var destination: CLLocationCoordinate2D!
    @Binding var result : [SearchData]
    @Binding var name: String
    @Binding var txt: String
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return SearchBar.Coordinator(parent1: self)
    }
    
    
    func makeUIView(context: Context) -> UISearchBar {
        let view = UISearchBar()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        
    }
    
    class Coordinator : NSObject, UISearchBarDelegate {
        
        var parent : SearchBar
        
        init(parent1 : SearchBar) {
            
            parent = parent1
            
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            self.parent.txt = searchText
            
            let req = MKLocalSearch.Request()
            req.naturalLanguageQuery = searchText
            req.region = self.parent.map.region
            
            let search = MKLocalSearch(request: req)
            
            DispatchQueue.main.async {
                self.parent.result.removeAll()
            }
            
            search.start { (res, err) in
                
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                
                for i in 0..<res!.mapItems.count{
                    
                    let temp = SearchData(id: i, name: res!.mapItems[i].name!, address: res!.mapItems[i].placemark.title!, coordinate: res!.mapItems[i].placemark.coordinate)
                    
                    self.parent.result.append(temp)
                                        
                }
                
            }
        }
        
    }
    
}

struct SearchData: Identifiable {
    
    var id: Int
    var name: String
    var address: String
    var coordinate: CLLocationCoordinate2D
    
    
}

