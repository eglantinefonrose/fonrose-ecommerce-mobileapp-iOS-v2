//
//  MapViewModel.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/03/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    //CLLocationManagerDelegate permet d'accéder à la localisation de l'utlisateur etc
    
    //Alert
    @Published var permissionDenied = false
    @Published var mapView = MKMapView()
    @Published var region: MKCoordinateRegion!
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //Regarde les permissions
        
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .denied:
                permissionDenied.toggle()
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            default:
                ()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
