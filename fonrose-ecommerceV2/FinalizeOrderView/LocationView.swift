//
//  LocationView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 25/07/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//
 
import SwiftUI
import MapKit
import CoreLocation

struct LocationView: View {
    var body: some View {
        
        Caca()
        
    }
}

struct Caca : View {
    
    @EnvironmentObject var bigModel: BigModel
    
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var source: CLLocationCoordinate2D!
    @State var destination: CLLocationCoordinate2D!
    @State var data: Data = .init(count: 0)
    @State var name = ""
    @State var search = false
    
    var body: some View {
        
        ZStack {
            
            ZStack {
                VStack(spacing: 0) {
                    
                    VStack {
                        
                        if search == false {
                                
                                Button(action: {
                                    self.search.toggle()
                                }) {
                                    
                                    HStack {
                                        
                                        VStack(alignment: .leading, spacing: 15) {
                                            Text(self.destination != nil ? "Destination" : "Pick a Location")
                                                .font(.title)
                                                .foregroundColor(.black)
                                            
                                            if self.destination != nil {
                                                Text(self.name)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "magnifyingglass")
                                                .foregroundColor(.blue)
                                        
                                    }.padding()
                                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                                     .background(Color.white)

                                }
                            
                        }
                        
                        else {
                            
                            SearchView(show: self.$search, map: self.$map, source: self.$source, destination: self.$destination, name: self.$name)
                            
                        }
                        
                    }
                    
                    ZStack {
                        MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$source, destination: self.$destination)
                        .onAppear {
                            self.manager.requestAlwaysAuthorization() }
                        
                            VStack {
                                Spacer()
                                Button(action: {
                                    self.bigModel.currentview = .FinalizeOrderViews_PaymentScreen
                                }) {
                                    ZStack {
                                        
                                        Rectangle()
                                            .background(Color.white)
                                            .cornerRadius(10)
                                            .frame(width: 100, height: 30)
                                        
                                        Text("Payment")
                                            .foregroundColor(.white)
                                            .fontWeight(.regular)
                                        
                                    }
                                }
                                Spacer()
                                .frame(height: 30)
                            }
                        }
                    
                }
            }
            
            if self.search {
                SearchView(show: self.$search, map: self.$map, source: self.$source, destination: self.$destination, name: self.$name) }
            
        }.edgesIgnoringSafeArea(.all)
        .alert(isPresented: self.$alert) { () -> Alert in
            Alert(title: Text("Error"), message: Text("Please Enable Location In Settings !!!"), dismissButton: .destructive(Text("ta gueule"))) }
    }
}


struct MapView: UIViewRepresentable {
    
    func makeCoordinator() -> MapView.Coordinator {
        return MapView.Coordinator(parent1: self)
    }
    
    
    @Binding var map : MKMapView
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    @Binding var source: CLLocationCoordinate2D!
    @Binding var destination: CLLocationCoordinate2D!
    
    func makeUIView(context: Context) -> MKMapView {
        
        map.delegate = context.coordinator
        manager.delegate = context.coordinator
        map.showsUserLocation = true
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator : NSObject, MKMapViewDelegate, CLLocationManagerDelegate{
        
        var parent : MapView
        init(parent1: MapView) {
            
            parent = parent1
        
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .denied{
                self.parent.alert.toggle()
            }
            else {
                self.parent.manager.startUpdatingLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let region = MKCoordinateRegion(center: locations.last!.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            self.parent.source = locations.last!.coordinate
            
            self.parent.map.region = region
        }
        
    }
    
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
