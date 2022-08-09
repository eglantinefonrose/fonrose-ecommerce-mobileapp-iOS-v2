//
//  PersonPickerView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 19/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import MapKit

@available(iOS 14.0, *)
struct PersonPickerView: View {

    let db = Firestore.firestore()
    @State var email: String = ""
    @State var name: String = ""
    @EnvironmentObject var bigModel: BigModel
    @State var showPopup = false
    @StateObject var mapData = LocationViewModel()
    @State var showAlert = false
    
    var body: some View {
        
        ZStack {
                            
                HStack {
                   
                Spacer()
                
                    VStack {
                        
                    Spacer()
                        .frame(height: 100)
                        
                        HStack {
                            Spacer()
                                .frame(width: 0)
                            Text("Persons")
                                .font(.system(size: 35, weight: .bold, design: .default))
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width)
                            Spacer()
                        }
                        
                            List {
                                ForEach(bigModel.user.persons.indices, id: \.self) { index in
                                    
                                    HStack {
                                        
                                        HStack {
                                        
                                        Spacer()
                                            .frame(width: 15)
                                        
                                        Text(bigModel.user.persons[index].name)
                                            .foregroundColor(.white)
                                            .onTapGesture {
                                                
                                                //mapData.pinSelectedPlace(pointSelectedPlaceLat: CGFloat(Int(CLLocationDegrees(25.276987))), pointSelectedPlaceLong: CGFloat(Int(CLLocationDegrees(55.296249))))
                                                
                                                bigModel.currentPersonIndex = index
                                                print(bigModel.currentPersonIndex)
                                                bigModel.authCurrentView = .Auth_UserInfo
                                                bigModel.lastViews.append(.Auth_PersonPickerView)
                                                print(bigModel.user.userID)
                                                print(bigModel.user.email)
                                                
                                                if bigModel.signedIn {
                                                    
                                                    print("signed in")
                                                    
                                                    if bigModel.currentPersonIndex+1 < 10 {
                                                        
                                                        db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.currentPersonIndex+1)").collection("Mensurations").getDocuments { snapshot, error in
                                                            guard error == nil else {
                                                                print(error!.localizedDescription)
                                                                return
                                                            }
                                                            
                                                            if let snapshot = snapshot {
                                                                for document in snapshot.documents {
                                                                    let dbArmpitsMeasurement = document.data()["ArmpitsMeasurement"] as? String ?? ""
                                                                    let dbArmsLength = document.data()["ArmsLength"] as? String ?? ""
                                                                    let dbHeadMeasurement = document.data()["HeadMeasurement"] as? String ?? ""
                                                                    let dbPelvisMeasurement = document.data()["PelvisMeasurement"] as? String ?? ""
                                                                    let dbPelvisKnee = document.data()["PelvisKnee"] as? String ?? ""
                                                                    let dbShouldersMeasurement = document.data()["ShouldersMeasurement"] as? String ?? ""
                                                                    let dbShouldersPelvis = document.data()["ShouldersPelvis"] as? String ?? ""
                                                                    
                                                                    bigModel.user.persons[bigModel.currentPersonIndex].measurements = BigModel.Measurements(ArmpitsMeasurement: dbArmpitsMeasurement, ArmsLength: dbArmsLength, HeadMeasurement: dbHeadMeasurement, PelvisMeasurement: dbPelvisMeasurement, PelvisKnee: dbPelvisKnee, ShouldersMeasurement: dbShouldersMeasurement, ShouldersPelvis: dbShouldersPelvis)
                                                                    
                                                                    print("measurement got")
                                                                    
                                                                }
                                                                
                                                                bigModel.isPersonChosen = true
                                                                
                                                            }
                                                                                                                    
                                                        }
                                                        
                                                        db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.currentPersonIndex+1)").collection("Location").getDocuments { snapshot, error in
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
                                                                    let dbAdressPostalCode = document.data()["adressPostalCode"] as? String ?? ""
                                                                    let dbAdressCity = document.data()["adressCity"] as? String ?? ""
                                                                    let dbAdressStreet = document.data()["adressStreet"] as? String ?? ""
                                                                    let dbAdressMailBox = document.data()["adressMailBox"] as? String ?? ""
                                                                    let dbAdressBasement = document.data()["adressBasement"] as? String ?? ""
                                                                    let dbAdressStage = document.data()["adressStage"] as? String ?? ""
                                                                    let dbAdressLat = document.data()["adressLat"] as? CGFloat ?? 44
                                                                    let dbAdressLong = document.data()["adressLong"] as? CGFloat ?? 44
                                                                    
                                                                    bigModel.user.persons[bigModel.currentPersonIndex].location = BigModel.Location(civility: dbCivility, lastName: dbLastName, firstName: dbFirstName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: dbAdressLat, adressLong: dbAdressLong)
                                                                    
                                                                    
                                                                    //Location(civility: dbCivility, lastName: dbLastName, firstName: dbFirstName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: CGFloat(dbAdressLat), adressLong: CGFloat(dbAdressLong))
                                                                    
                                                                }
                                                            }
                                                            
                                                        }
                                                          
                                                    }
                                                    
                                                    else {
                                                        db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(bigModel.currentPersonIndex+1)").collection("Mensurations").getDocuments { snapshot, error in
                                                            guard error == nil else {
                                                                print(error!.localizedDescription)
                                                                return
                                                            }
                                                            
                                                            if let snapshot = snapshot {
                                                                for document in snapshot.documents {
                                                                    let dbArmpitsMeasurement = document.data()["ArmpitsMeasurement"] as? String ?? ""
                                                                    let dbArmsLength = document.data()["ArmsLength"] as? String ?? ""
                                                                    let dbHeadMeasurement = document.data()["HeadMeasurement"] as? String ?? ""
                                                                    let dbPelvisMeasurement = document.data()["PelvisMeasurement"] as? String ?? ""
                                                                    let dbPelvisKnee = document.data()["PelvisKnee"] as? String ?? ""
                                                                    let dbShouldersMeasurement = document.data()["ShouldersMeasurement"] as? String ?? ""
                                                                    let dbShouldersPelvis = document.data()["ShouldersPelvis"] as? String ?? ""
                                                                    
                                                                    bigModel.user.persons[bigModel.currentPersonIndex].measurements = BigModel.Measurements(ArmpitsMeasurement: dbArmpitsMeasurement, ArmsLength: dbArmsLength, HeadMeasurement: dbHeadMeasurement, PelvisMeasurement: dbPelvisMeasurement, PelvisKnee: dbPelvisKnee, ShouldersMeasurement: dbShouldersMeasurement, ShouldersPelvis: dbShouldersPelvis)
                                                                    
                                                                }
                                                            }
                                                                                                                    
                                                        }
                                                        
                                                        db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.currentPersonIndex+1)").collection("Location").getDocuments { snapshot, error in
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
                                                                    let dbAdressPostalCode = document.data()["adressPostalCode"] as? String ?? ""
                                                                    let dbAdressCity = document.data()["adressCity"] as? String ?? ""
                                                                    let dbAdressStreet = document.data()["adressStreet"] as? String ?? ""
                                                                    let dbAdressMailBox = document.data()["adressMailBox"] as? String ?? ""
                                                                    let dbAdressBasement = document.data()["adressBasement"] as? String ?? ""
                                                                    let dbAdressStage = document.data()["adressStage"] as? String ?? ""
                                                                    let dbAdressLat = document.data()["adressLat"] as? CGFloat ?? 44
                                                                    let dbAdressLong = document.data()["adressLong"] as? CGFloat ?? 44
                                                                    
                                                                    bigModel.user.persons[bigModel.currentPersonIndex].location = BigModel.Location(civility: dbCivility, lastName: dbLastName, firstName: dbFirstName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: CGFloat(dbAdressLat), adressLong: CGFloat(dbAdressLong))
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                        }

                                                        
                                                    }
                                                    
                                                } else {
                                                    print("not signed in")
                                                }
                                                
                                                print(index)
                                                
                                            }
                                            
                                        Spacer() }
                                        
                                        Image(systemName: "trash")
                                            .foregroundColor(.blue)
                                            .onTapGesture {
                                                bigModel.deletePerson(personNumber: "\(index+1)")
                                            }
                                        
                                        Spacer()
                                            .frame(width: 15)
                                    
                                    }
                                }.listRowBackground(Color.black)
                            }.background(Color.black)
                            .onAppear(perform: {
                                UITableView.appearance().backgroundColor = .clear
                                
                            })
                            .onAppear(perform: {
                                    UITableView.appearance().contentInset.top = 0
                            })
                        
                        Spacer()
                        
                        Text(Auth.auth().currentUser?.email ?? "nil")
                        
                        Text("Sign out")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                bigModel.signOut()
                                bigModel.authCurrentView = ViewEnum.Auth_SignInView
                            }
                        
                        Text("+")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                print()
                                bigModel.authCurrentView = .Auth_NewUserView
                            }
                        
                        Spacer()
                        
                    }
                   
                   Spacer()
                   
               }.background(Color.black)
               .edgesIgnoringSafeArea(.all)
                
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
                                if !self.bigModel.authLastViews.isEmpty {
                                    print("back")
                                    self.bigModel.authCurrentView = self.bigModel.authLastViews.last ?? .AboutUsScreen
                                    self.bigModel.authLastViews.removeLast()
                                    print("previous View = \(String(describing: self.bigModel.authLastViews.last))")
                                } else { print("array empty") }
                            }
                        
                        Spacer()
                        
                        Image(systemName: "house")
                            .foregroundColor(Color.blue)
                            .onTapGesture {
                                self.bigModel.currentview = .Home_homeFeed
                            }
                        
                        Spacer()
                            .frame(width: 20)
                        
                    }.frame(width: UIScreen.main.bounds.width)
                    
                    Spacer()
                    
                }
        }
        
    }
}

struct PersonPickerView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            PersonPickerView()
                .environmentObject(BigModel())
        } else {
            // Fallback on earlier versions
        }
    }
}
