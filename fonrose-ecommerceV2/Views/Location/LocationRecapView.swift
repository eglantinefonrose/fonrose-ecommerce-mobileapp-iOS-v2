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
    
    @EnvironmentObject var bigModel: BigModel
    @available(iOS 14.0, *)
    @StateObject var mapData = LocationViewModel()
    var db = Firestore.firestore()
    
    var body: some View {
        
        VStack {
            
            Spacer()
                .frame(height: 20)
            
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
                
                Text("Recap")
                    .foregroundColor(Color.black)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "house")
                    .foregroundColor(Color.blue)
                    .onTapGesture {
                        self.bigModel.currentview = .Home_homeFeed
                    }
                
                Spacer()
                    .frame(width: 20)
                
            }
            
            Spacer()
            
            ScrollView {
                VStack(spacing: 15) {
                    LocationText(locationName: "Civility", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.civility ?? "")
                    LocationText(locationName: "First Name", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.firstName ?? "")
                    LocationText(locationName: "Last Name", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.lastName ?? "")
                    LocationText(locationName: "emailAdress", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.emailAdress ?? "")
                    LocationText(locationName: "phoneNumber", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.phoneNumber ?? "")
                    LocationText(locationName: "adressCountry", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressCountry ?? "")
                    VStack {
                        LocationText(locationName: "adressPostalCode", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressPostalCode ?? "")
                        LocationText(locationName: "adressCity", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressCity ?? "")
                        LocationText(locationName: "adressStreet", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressStreet ?? "")
                        LocationText(locationName: "adressMailBox", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressMailBox ?? "")
                        LocationText(locationName: "adressBasement", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressBasement ?? "")
                        LocationText(locationName: "adressStage", locationNameValue: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressStage ?? "")
                    }
                }
            }
            
            Spacer()
            
            Text("Edit location informations")
                .foregroundColor(.blue)
                .onTapGesture {
                    bigModel.currentview = .LivraisonViews_Livraison
                }
            
            HStack {
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    Text("Location")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .onTapGesture {
                            bigModel.lastViews.append(.LivraisonViews_RecapLivraison)
                        }
                    Spacer()
                
                }.background(Color.blue)
                .frame(width: 150)
                .cornerRadius(5)
                
                Spacer()
                
            }.frame(width: 120, height: 35)
            .background(Color.blue)
            .cornerRadius(15)
            
            Spacer()
            
        }
        
    }
}

struct LocationText: View {
    var locationName: String
    var locationNameValue: String
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 15)
            Text(locationName)
            Spacer()
            Text(locationNameValue)
            Spacer()
                .frame(width: 15)
        }
    }
}

struct LocationRecapView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            LocationRecapView()
        } else {
            // Fallback on earlier versions
        }
    }
}
