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
                    Text(bigModel.mainArrayInfos[index].text)
                        .foregroundColor(.white)
                        .font(.headline)
                        .onTapGesture {
                            proxy.scrollTo(index + bigModel.productMainArrayInfos.count)
                            self.bigModel.showMenu = false
                        }
                }
                
                Text("Measurement")
                    .foregroundColor(.white)
                    .font(.headline)
                    .onTapGesture {
                        bigModel.currentview = ViewEnum.Measurement_Mensurations
                        bigModel.lastViews.append(.Home_homeFeed0)
                        self.bigModel.showMenu = false
                    }
                
                Text("Location")
                    .foregroundColor(.white)
                    .font(.headline)
                    .onTapGesture {
                        bigModel.currentview = ViewEnum.LivraisonViews_Livraison
                        bigModel.lastViews.append(.Home_homeFeed0)
                        self.bigModel.showMenu = false
                        
                        if bigModel.signedIn {
                            
                            print("signed in")
                            
                            if (bigModel.currentPersonIndex ?? 0)+1 < 10 {
                                
                                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.currentPersonIndex ?? 0+1)").collection("Location").getDocuments { snapshot, error in
                                    guard error == nil else {
                                        print(error!.localizedDescription)
                                        return
                                    }
                                    
                                    if let snapshot = snapshot {
                                        
                                        for document in snapshot.documents {
                                            let dbCivility = document.data()["civility"] as? String ?? ""
                                            let dbFirstName = document.data()["firstName"] as? String ?? ""
                                            let dbLastName = document.data()["lastName"] as? String ?? ""
                                            let dbEmailAdress = document.data()["emailAdress"] as? String ?? ""
                                            let dbPhoneNumber = document.data()["phoneNumber"] as? String ?? ""
                                            let dbAdressCountry = document.data()["adressCountry"] as? String ?? ""
                                            let dbAdressPostalCode = document.data()["adressPostalCode"] as? String ?? ""
                                            let dbAdressCity = document.data()["adressCity"] as? String ?? ""
                                            let dbAdressStreet = document.data()["adressStreet"] as? String ?? ""
                                            let dbAdressMailBox = document.data()["adressMailBox"] as? String ?? ""
                                            let dbAdressBasement = document.data()["adressBasement"] as? String ?? ""
                                            let dbAdressStage = document.data()["adressStage"] as? String ?? ""
                                            let dbAdressLat = document.data()["adressLat"] as? CGFloat ?? 44
                                            let dbAdressLong = document.data()["adressLong"] as? CGFloat ?? 44
                                            
                                            bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location = BigModel.Location(id: document.documentID, civility: dbCivility, firstName: dbFirstName, lastName: dbLastName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressCountry: dbAdressCountry, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage)
                                            
                                        }
                                        
                                    }

                                    
                                }
                                  
                            }
                            
                            else {
                                
                                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\((bigModel.currentPersonIndex ?? 0)+1)").collection("Location").getDocuments { snapshot, error in
                                    guard error == nil else {
                                        print(error!.localizedDescription)
                                        return
                                    }
                                    
                                    if let snapshot = snapshot {
                                        
                                        for document in snapshot.documents {
                                            let dbCivility = document.data()["civility"] as? String ?? ""
                                            let dbFirstName = document.data()["firstName"] as? String ?? ""
                                            let dbLastName = document.data()["lastName"] as? String ?? ""
                                            let dbEmailAdress = document.data()["emailAdress"] as? String ?? ""
                                            let dbPhoneNumber = document.data()["phoneNumber"] as? String ?? ""
                                            let dbAdressCountry = document.data()["adressCountry"] as? String ?? ""
                                            let dbAdressPostalCode = document.data()["adressPostalCode"] as? String ?? ""
                                            let dbAdressCity = document.data()["adressCity"] as? String ?? ""
                                            let dbAdressStreet = document.data()["adressStreet"] as? String ?? ""
                                            let dbAdressMailBox = document.data()["adressMailBox"] as? String ?? ""
                                            let dbAdressBasement = document.data()["adressBasement"] as? String ?? ""
                                            let dbAdressStage = document.data()["adressStage"] as? String ?? ""
                                            
                                            bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location = BigModel.Location(id: document.documentID, civility: dbCivility, firstName: dbFirstName, lastName: dbLastName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressCountry: dbAdressCountry, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage)
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
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
