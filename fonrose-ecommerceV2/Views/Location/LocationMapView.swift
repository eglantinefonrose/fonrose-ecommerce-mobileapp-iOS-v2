//
//  LocationMapView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/03/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import MapKit

@available(iOS 14.0, *)
struct LocationMapView: UIViewRepresentable {
    
    @available(iOS 14.0, *)
    @EnvironmentObject var mapData: LocationViewModel
    
    func makeCoordinator() -> Coordinator {
        return LocationMapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        //delegate = objet qui répond à des événements qui se produisent ailleurs
        //coordinator sont comme des delegates pour les view controllers
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation.isKind(of: MKUserLocation.self) {return nil}
            else {
                let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
                pinAnnotation.tintColor = .red
                pinAnnotation.animatesDrop = true
                pinAnnotation.canShowCallout = true
             
                return pinAnnotation
            }
            
        }
        
    }
    
}

@available(iOS 14.0, *)
struct LocationMapView_Previews: PreviewProvider {
    @available(iOS 14.0, *)
    static var previews: some View {
        LocationMapView()
    }
}
