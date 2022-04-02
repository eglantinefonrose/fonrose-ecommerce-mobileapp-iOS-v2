//
//  LocationMapView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/03/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import MapKit

struct LocationMapView: UIViewRepresentable {
    
    @EnvironmentObject var mapData: MapViewModel
        
    func makeCoordinator() -> Coordinator {
        return LocationMapView.Coordinator()
    }
        
    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapView
        
        view.showsUserLocation = true
        //quand qqch se passe dans la vue, elle informe le controller pour pouvoir communiquer les infos
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator: NSObject,MKMapViewDelegate {
        
    }
    
}
