//
//  LocationTest.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 15/10/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import CoreLocation

@available(iOS 14.0, *)
struct LocationTest: View {
    
    @available(iOS 14.0, *)
    @State var countryText: String = ""
    @State var locationManager = CLLocationManager()
    @available(iOS 14.0, *)
    @StateObject var mapData = LocationViewModel()
    
    @available(iOS 14.0, *)
    var body: some View {
        
        VStack {
            VStack {
                
                HStack {
                    
                    TextField("Search your delivery location", text: $mapData.searchTxt)
                    
                }.padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(20)
                .frame(width: UIScreen.main.bounds.width-20, height: 50)
                
            }
            
            //&& renvoie la scrollView que si mapData.places et mapData.searchTxt n'est pas vide
            // rappel : "places" est un tableau d'objets de type "Place" (placemark avec UUID)
            // place est de type "Place"
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(mapData.places) { place in
                            Text(place.placemark.country ?? "")
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    mapData
                                        .selectPlace(place: place)
                                }
                            Divider()
                        }
                    }
                }.background(Color.white)
        
        }/*.onChange(of: mapData.searchTxt, perform: { value in
            
            let delay = 0.3
            
            // On se sert de DispatchQueue pour ne pas faire freezer le reste de l'appli
            // je ne comprends pas pourquoi mais value a la valeur de mapData.searchTxt donc quand on tape qqch dans le TextField, la recherche se met en route instantanement (utilisation de la fonction self.mapData.searchQuery() )
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value == mapData.searchTxt {
                    self.mapData.searchQuery()
                }
            }
        })*/
        
    }
}

struct LocationTest_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            LocationTest()
        } else {
            // Fallback on earlier versions
        }
    }
}
