//
//  BigRootView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 22/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import MapKit
import FirebaseAuth
import FirebaseFirestore

@available(iOS 14.0, *)
struct BigRootView: View {
    
    @EnvironmentObject var bigModel: BigModel
    @StateObject var mapData = LocationViewModel()
    var db = Firestore.firestore()
    
    @available(iOS 14.0, *)
    var body: some View {
        
        VStack {
            
            //MARK: Main views
            
            VStack {
                
                //MARK: Home Feed
                VStack {
                    
                    if (self.bigModel.currentview == .Home_homeFeed0) {
                        HomeFeedView()
                    }
                    
                    if (self.bigModel.currentview == .Home_homeFeed1) {
                        HomeFeedView()
                    }
                    
                    if (self.bigModel.currentview == .Home_homeFeed2) {
                        HomeFeedView()
                    }
                    
                    if (self.bigModel.currentview == .Home_homeFeed3) {
                        HomeFeedView()
                    }
                    
                }
                
                if (self.bigModel.currentview == .MeasurementCarouselViewTheDress) {
                    CarouselView()
                }
                
                if (self.bigModel.currentview == .MeasurementCarouselViewLeSerpent) {
                    CarouselView()
                }
                
                if (self.bigModel.currentview == .VideoPlayer_trailerPlayer) {
                    TrailerPlayer(url: URL(string: bigModel.videoURL)!)
                }
                
                if (self.bigModel.currentview == .AboutUsScreen) {
                    AboutUs()
                }
                
            }
            
            //MARK: Service client
            
            VStack {
                
                if (self.bigModel.currentview == .ServiceClient_ServiceClientInfos) {
                    ServiceClientInfos()
                }
                
                if (self.bigModel.currentview == .ServiceClient_showDelivery) {
                    ShowDeliveryView()
                }
                
                if (self.bigModel.currentview == .ServiceClient_showReturn) {
                    showReturnView()
                }
                
                if (self.bigModel.currentview == .ServiceClient_showCard) {
                    showCardView()
                }
                
                if (self.bigModel.currentview == .ServiceClient_showServices) {
                    ShowServicesView()
                }
            }
            
            //MARK: Measurements
            
            VStack {
                
                if (self.bigModel.currentview == .Measurement_Mensurations) {
                    if bigModel.user.persons.isEmpty {
                        AuthView()
                    } else {
                        MeasurementView()
                    }
                }
                
                if (self.bigModel.currentview == .Measurement_RecapMensurations) {
                    RecapMensurations()
                }
                
                if (self.bigModel.currentview == .Measurement_MeasurementsTut) {
                    MeasurementsTut()
                }
                
            }
            
            //MARK: Finalize order
            
            VStack {
                
                if (self.bigModel.currentview == .FinalizeOrderViews_PaymentScreen) {
                    PaymentScreen()
                }
            
                if (self.bigModel.currentview == .FinalizeOrderViews_FinDeCommande) {
                    FinDeCommande()
                }
                
            }
            
            //MARK: Location
            
            VStack {
                
                if (self.bigModel.currentview == .LivraisonViews_Livraison) {
                    //si aucune personne n'est sélectionnée, on affiche la vue d'authenfication qui affichera l'écran de selection des personnes de l'utilisateur
                    if bigModel.user.persons.isEmpty {
                        AuthView()
                    } else {
                        LocationView()
                    }
                }
                
                if (self.bigModel.currentview == .LivraisonViews_RecapLivraison) {
                    LocationRecapView()
                }
                
            }
            
            //MARK: Auth
            
            VStack {
                
                if (self.bigModel.currentview == .Auth_AuthView) {
                    AuthView()
                }
                
            }
            
        }
    }
}
