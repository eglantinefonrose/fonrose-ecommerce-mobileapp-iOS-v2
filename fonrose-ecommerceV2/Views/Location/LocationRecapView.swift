//
//  LocationRecapView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 17/10/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@available(iOS 14.0, *)
struct LocationRecapView: View {

    @available(iOS 14.0, *)
    @EnvironmentObject var bigModel: BigModel
    @StateObject var mapData = LocationViewModel()
    var db = Firestore.firestore()
    @State private var orientation = UIDeviceOrientation.portrait
    
    var body: some View {
        
        if #available(iOS 15.0, *) {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                BackButtonModel(text: "location-recap", viewName: .LivraisonViews_RecapLivraison)
                
                Spacer()
                                                          
                Text("recap")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                                                                
                LazyVStack  {
                                                    
                    ScrollView {
                                                        
                            VStack {
                                
                                LocationText(locationName: "civility", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.civility ?? "")
                                    
                                LocationText(locationName: "first-name", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.firstName ?? "")
                                    
                                LocationText(locationName: "last-name", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.lastName ?? "")
                                
                                LocationText(locationName: "email-adress", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.emailAdress ?? "")
                                
                                LocationText(locationName: "phone-number", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.phoneNumber ?? "")
                                
                            }
                                
                            LocationText(locationName: "adress-country", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressCountry ?? "")
                            
                            LocationText(locationName: "adress-postal-code", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressPostalCode ?? "")
                            
                            LocationText(locationName: "adress-city", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressCity ?? "")
                            
                            LocationText(locationName: "adress-street", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressStreet ?? "")
                            
                            LocationText(locationName: "adress-mail-box", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressMailBox ?? "")
                        
                            LocationText(locationName: "adress-basement", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressBasement ?? "")
                            
                        }.frame(height: orientation == .portrait || orientation == .portraitUpsideDown ? 450 : 100)
                        .onRotate { newOrientation in orientation = newOrientation }
                                                    
                }
                
                    Spacer()
                    
                    VStack {
                                                                                     
                        Text("edit-location-informations")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                bigModel.currentview = .LivraisonViews_Livraison
                                print(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressCountry ?? "nil")
                                print(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressStreet ?? "nil")
                            }
                        
                        HStack {
                            Spacer()
                            Text("save")
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                                .padding(10)
                            Spacer()
                        }.background(Color.blue)
                        .cornerRadius(15)
                        .onTapGesture {
                            bigModel.lastViews.append(.LivraisonViews_RecapLivraison)
                            bigModel.fullViewHistory.append(.LivraisonViews_RecapLivraison)
                            bigModel.currentview = .FinalizeOrderViews_PaymentScreen
                        }
                    }
                                    
                }.padding(20)
            }
        
        } else {
            // Fallback on earlier versions
        }
    }
}

struct LocationText: View {
    var locationName: String
    var locationNameValue: String
    var body: some View {
        if #available(iOS 15.0, *) {
            HStack {
                Text(locationName)
                    .fontWeight(.medium)
                Spacer()
                Text(locationNameValue)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }.padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
        } else {
            // Fallback on earlier versions
        }
    }
}

struct LocationRecapView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            LocationRecapView()
                .environmentObject(BigModel())
        } else {
            // Fallback on earlier versions
        }
    }
}
