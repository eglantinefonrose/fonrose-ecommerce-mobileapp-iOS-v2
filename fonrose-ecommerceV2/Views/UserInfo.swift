//
//  UserInfo.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 22/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct UserInfo: View {
    
    var auth = Auth.auth()
    @EnvironmentObject var bigModel: BigModel
    @State var isChangeViewShowed: Bool = false
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                                    
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    
                    Text("Back")
                        .foregroundColor(Color.blue)
                        .fontWeight(.semibold)
                        .onTapGesture {
                            if !self.bigModel.authLastViews.isEmpty {
                                print("back")
                                self.bigModel.authCurrentView = self.bigModel.authLastViews.last ?? .AboutUsScreen
                                self.bigModel.authLastViews.removeLast()
                                print("previous View = \(String(describing: self.bigModel.authLastViews.last))")
                            } else { print("array empty") }
                        }
                    
                    Spacer()
                    
                    Text("User Info")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "house")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.bigModel.currentview = .Home_homeFeed0
                        }
                    
                }.padding(20)
                        
                Spacer()
                
                VStack {
                    
                    Spacer()
                    
                    if #available(iOS 14.0, *) {
                        if #available(iOS 16.0, *) {
                            if bigModel.user.id != "" {
                                Text(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].name)
                                    .font(.title2)
                                    .padding(5)
                                    .fontWeight(.semibold)
                            } else {
                                
                            }
                        } else {
                            // Fallback on earlier versions
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    HStack {
                        
                        Image(systemName: "pencil.line")
                            .foregroundColor(.blue)
                            .font(.callout)
                        
                        Text("Edit...")
                            .foregroundColor(.blue)
                            .font(.caption)
                    }.onTapGesture {
                        bigModel.authCurrentView = .Auth_EditPerson
                    }
                                        
                    VStack {
                        HStack {
                            Image(systemName: "pencil.and.outline")
                                .foregroundColor(.blue)
                            Text("See my measurements")
                                .foregroundColor(.blue)
                                .padding(10)
                        }.onTapGesture {
                            
                            if bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements == nil {
                                
                                bigModel.initializeMeasurements()
                                
                                guard let userId = auth.currentUser?.uid else { return }
                                    
                                let collectionRef = Firestore.firestore().collection("users").document("user\(userId)").collection("persons").document(bigModel.currentPersonId).collection("Measurements")
                                
                                collectionRef.getDocuments { snapshot, error in
                                    guard error == nil else {
                                        print("ERROR WHEN FETCHING LOCATION \(error!.localizedDescription)")
                                       return
                                    }

                                    if let snapshot = snapshot {
                                        for document in snapshot.documents {
                                            do {
                                                bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements = try document.data(as: [BigModel.MeasurementModel].self)
                                            } catch {
                                                print(error)
                                            }
                                        }
                                        bigModel.currentview = .Measurement_Mensurations
                                    }
                                }
                                
                            } else {
                                bigModel.currentview = .Measurement_Mensurations
                            }
                        }
                        
                        HStack {
                            Image(systemName: "mappin.circle")
                                .foregroundColor(.blue)
                            Text("See my location informations")
                                .foregroundColor(.blue)
                                .padding(10)
                        }.onTapGesture {
                            
                            if bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location == nil {
                                
                                bigModel.initializeLocation()
                            
                                /*let collectionRef = Firestore.firestore().collection("users").document("user\(userId)").collection("persons").document(bigModel.currentPersonId).collection("Location")
                                
                                collectionRef.getDocuments { snapshot, error in
                                    
                                    guard error == nil else {
                                        print("ERROR WHEN FETCHING LOCATION \(error!.localizedDescription)")
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

                                            bigModel.user.persons[bigModel.currentPersonIndex].location = BigModel.Location(id: document.documentID, civility: dbCivility, firstName: dbFirstName, lastName: dbLastName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressCountry: dbAdressCountry, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: dbAdressLat, adressLong: dbAdressLong)

                                        }
                                        
                                        print("location infos fetched \(bigModel.currentPersonId)")
                                        bigModel.currentview = .LivraisonViews_Livraison
                                        
                                    }
                                    
                                }*/
                                
                                guard let userId = auth.currentUser?.uid else { return }
                                    
                                let collectionRef = Firestore.firestore().collection("users").document("user\(userId)").collection("persons").document(bigModel.currentPersonId).collection("Location")
                                
                                collectionRef.getDocuments { snapshot, error in
                                    guard error == nil else {
                                        print("ERROR WHEN FETCHING LOCATION \(error!.localizedDescription)")
                                       return
                                    }

                                    if let snapshot = snapshot {
                                        for document in snapshot.documents {
                                            do {
                                                bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location = try document.data(as: BigModel.Location.self)
                                            } catch {
                                                print(error)
                                            }
                                        }
                                        bigModel.currentview = .LivraisonViews_Livraison
                                    }
                                }
                                
                            } else {bigModel.currentview = .LivraisonViews_Livraison}
                        }
                    }.padding(20)
                        
                Spacer()
                    
                }
                
                /*if bigModel.user.id != "" {
                    Text("Connect with \(bigModel.user.email)")
                }*/
            
                VStack {
                    
                    HStack {
                        Image(systemName: "person.fill")
                        Text("Change of person")
                            .padding(5)
                    }.onTapGesture {
                        bigModel.authCurrentView = .Auth_PersonPickerView
                        bigModel.authLastViews.append(.Auth_UserInfo)
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        Spacer()
                            Text("Sign out")
                                .foregroundColor(Color.white)
                                .fontWeight(.medium)
                                .padding(7)
                        Spacer()
                    }.background(Color(UIColor.lightGray))
                    .cornerRadius(15)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .onTapGesture {
                        bigModel.signOut()
                    }
                    
                }
                
            }
            
            //Change(isShowing: $isChangeViewShowed)
                
        }
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        UserInfo()
            .environmentObject(BigModel(shouldInjectMockedData: true))
    }
}
