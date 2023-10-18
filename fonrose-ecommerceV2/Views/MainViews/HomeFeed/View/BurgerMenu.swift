//
//  BurgerMenu.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 29/10/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import MapKit

@available(iOS 14.0, *)
struct BurgerMenu: View {
    
    @EnvironmentObject var bigModel: BigModel
    @StateObject var mapData = LocationViewModel()
    var db = Firestore.firestore()
    var proxy: ScrollViewProxy
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(Color.gray)
                .frame(width: UIScreen.main.bounds.width/2)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 20) {
                
                ForEach(bigModel.productMainArrayInfos.indices, id: \.self) { index in
                    Text(bigModel.productMainArrayInfos[index].productName)
                        .foregroundColor(.white)
                        .font(.headline)
                        .onTapGesture {
                            proxy.scrollTo(index)
                            self.bigModel.showMenu = false
                        }
                }
                
                ForEach(bigModel.mainArrayInfos.indices, id: \.self) { index in
                    Text(LocalizedStringKey(bigModel.mainArrayInfos[index].text))
                        .foregroundColor(.white)
                        .font(.headline)
                        .onTapGesture {
                            bigModel.currentview = bigModel.mainArrayInfos[index].nextScreen
                            self.bigModel.showMenu = false
                        }
                }
                
                Text("All products")
                    .foregroundColor(.white)
                    .font(.headline)
                    .onTapGesture {
                        bigModel.currentview = ViewEnum.ProductsView
                        bigModel.lastViews.append(.Home_homeFeed0)
                        self.bigModel.showMenu = false
                    }
                
                Text("Measurement")
                    .foregroundColor(.white)
                    .font(.headline)
                    .onTapGesture {
                        
                        if bigModel.currentPersonIndex == nil {
                            bigModel.currentview = ViewEnum.Measurement_MeasurementsTut
                        } else {
                            bigModel.currentview = ViewEnum.Measurement_Mensurations
                        }
                        
                        bigModel.lastViews.append(.Home_homeFeed0)
                        bigModel.needToSeeEveryMeasurements = true
                        self.bigModel.showMenu = false
                    }
                
                Text("Location")
                    .foregroundColor(.white)
                    .font(.headline)
                    .onTapGesture {
                        Task {
                            
                            await bigModel.fetchLocation()
                            
                            if bigModel.currentPersonIndex != nil {
                                if bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location == nil {
                                    
                                    await bigModel.initializeLocation()
                                    await bigModel.fetchLocation()
                                    
                                } else {
                                    bigModel.currentview = ViewEnum.LivraisonViews_Livraison
                                    bigModel.lastViews.append(.Home_homeFeed0)
                                    self.bigModel.showMenu = false
                                }
                            } else {
                                bigModel.currentview = ViewEnum.LivraisonViews_Livraison
                                bigModel.lastViews.append(.Home_homeFeed0)
                                self.bigModel.showMenu = false
                            }
                            
                        }
                    }
                
                Image(systemName: "questionmark.circle")
                    .foregroundColor(.white)
                    .font(.headline)
                    .onTapGesture {
                        bigModel.currentview = .HelpView
                        bigModel.lastViews.append(.Home_homeFeed0)
                    }
                
                Spacer()
                
            }
        }
        
    }
}

struct BurgerMenu_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            ScrollViewReader { proxy in
                BurgerMenu(proxy: proxy)
                    .environmentObject(BigModel())
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
