//
//  LocationHome.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/03/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import CoreLocation

struct LocationHome: View {
    
    @StateObject var mapData = MapViewModel()
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        
        ZStack {
                LocationMapView()
                    .environmentObject(mapData)
                    .edgesIgnoringSafeArea(.all)

        }
        .onAppear(perform: {
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
        
    }
}

struct LocationHome_Previews: PreviewProvider {
    static var previews: some View {
            LocationHome()
    }
}
