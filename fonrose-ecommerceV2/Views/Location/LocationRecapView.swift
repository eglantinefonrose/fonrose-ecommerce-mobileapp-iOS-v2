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
import iPhoneNumberField

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
                
                HStack {
                    Spacer()
                        .frame(width: 20)
                    
                    Text("Back")
                        .foregroundColor(Color.blue)
                        .fontWeight(.semibold)
                        .onTapGesture {
                            if !self.bigModel.lastViews.isEmpty {
                                print("back")
                                self.bigModel.currentview = self.bigModel.lastViews.last ?? .AboutUsScreen
                                self.bigModel.lastViews.removeLast()
                                print("previous View = \(String(describing: self.bigModel.lastViews.last))")
                            } else { print("array empty") }
                        }
                    
                    Spacer()
                    
                    Image(systemName: "house")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.bigModel.currentview = .Home_homeFeed0
                        }
                    
                    Spacer()
                        .frame(width: 20)
                    
                }
                
                Spacer()
                                                          
                Text("Recap")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                                                                
                LazyVStack  {
                                                    
                    ScrollView {
                                                        
                            VStack {
                                
                                LocationText(locationName: "Civility", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.civility ?? "")
                                    
                                LocationText(locationName: "First Name", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.firstName ?? "")
                                    
                                LocationText(locationName: "Last Name", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.lastName ?? "")
                                
                                LocationText(locationName: "Email Adress", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.emailAdress ?? "")
                                
                                LocationText(locationName: "phoneNumber", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.phoneNumber ?? "")
                                
                            }
                                
                            LocationText(locationName: "adressCountry", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressCountry ?? "")
                            
                            LocationText(locationName: "adressPostalCode", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressPostalCode ?? "")
                            
                            LocationText(locationName: "adressCity", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressCity ?? "")
                            
                            LocationText(locationName: "adressStreet", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressStreet ?? "")
                            
                            LocationText(locationName: "adressMailBox", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressMailBox ?? "")
                            
                        }.frame(height: orientation == .portrait || orientation == .portraitUpsideDown ? 450 : 100)
                        .onRotate { newOrientation in orientation = newOrientation }
                                                    
                }
                
                    Spacer()
                    
                    VStack {
                                                                                     
                        Text("Edit location informations")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                bigModel.currentview = .LivraisonViews_Livraison
                            }
                        
                        HStack {
                            Spacer()
                            Text("Save")
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                                .padding(10)
                            Spacer()
                        }.background(Color.blue)
                        .cornerRadius(15)
                        .padding(10)
                        .onTapGesture {
                            bigModel.lastViews.append(.LivraisonViews_RecapLivraison)
                        }
                    }
                                    
                }
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
                    .foregroundColor(.white)
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
