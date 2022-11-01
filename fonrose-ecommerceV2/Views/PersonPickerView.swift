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
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        if bigModel.deletedPersonID == "" {
            PersonPickerViewHome()
        } else {
            DeletePersonView()
        }
        
    }
    
}

@available(iOS 14.0, *)
struct PersonPickerViewHome: View {
    
    @Environment(\.colorScheme) var colorScheme
    let db = Firestore.firestore()
    var auth = Auth.auth()
    @State var email: String = ""
    @State var name: String = ""
    @State var deletedPersonIndex: Int = 0
    @EnvironmentObject var bigModel: BigModel
    @State var showPopup = false
    @StateObject var mapData = LocationViewModel()
    @State var showAlert = false
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
                            
                HStack {
                                   
                    VStack {
                                                    
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
                            
                            Text("Persons")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Image(systemName: "house")
                                .foregroundColor(Color.blue)
                                .onTapGesture {
                                    if bigModel.currentPersonId != "" {
                                        self.bigModel.currentview = .Home_homeFeed
                                    } else {
                                        alertTF(title: "No person chosen", message: "Please click on the person you want to select", primaryTitle: "Ok") {
                                            
                                        }
                                    }

                                }
                            
                        }.padding(20)
                        
                    List {
                        ForEach(bigModel.user.persons.indices, id: \.self) { index in
                            
                            HStack {
                                
                                HStack {
                                
                                    if #available(iOS 15.0, *) {
                                        Text(bigModel.user.persons[index].name)
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                            .listRowBackground(Color.black)
                                            .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                            .listRowSeparator(.hidden)
                                            .onTapGesture {
                                                
                                                bigModel.currentPersonIndex = index
                                                bigModel.currentPersonId = bigModel.user.persons[index].id
                                                print("current person id \(bigModel.currentPersonId)")
                                                bigModel.authCurrentView = .Auth_UserInfo
                                                bigModel.lastViews.append(.Auth_PersonPickerView)
                                                
                                                //if bigModel.signedIn {
                                                
                                                print("signed in")
                                                
                                                //récupération des données de localisation de la personne selectionnée
                                                db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.user.persons[bigModel.user.persons.count-1].id).collection("Location").getDocuments { snapshot, error in
                                                    
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
                                                            
                                                            bigModel.user.persons[bigModel.user.persons.count-1].location = BigModel.Location(id: document.documentID, civility: dbCivility, firstName: dbFirstName, lastName: dbLastName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressCountry: dbAdressCountry, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: dbAdressLat, adressLong: dbAdressLong)
                                                            
                                                        }
                                                    }
                                                    
                                                }
                                                
                                                db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.user.persons[bigModel.user.persons.count-1].id).collection("Measurements").getDocuments { snapshot, error in
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
                                                            
                                                            bigModel.user.persons[bigModel.currentPersonIndex].measurements = BigModel.Measurements(id: document.documentID, ArmpitsMeasurement: dbArmpitsMeasurement, ArmsLength: dbArmsLength, HeadMeasurement: dbHeadMeasurement, PelvisMeasurement: dbPelvisMeasurement, PelvisKnee: dbPelvisKnee, ShouldersMeasurement: dbShouldersMeasurement, ShouldersPelvis: dbShouldersPelvis)
                                                            
                                                            
                                                        }
                                                    }
                                                }
                                                
                                                print(index)
                                                
                                            }
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                    
                                Spacer() }
                                
                                Image(systemName: "trash")
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        
                                        //affichage de l'alerte
                                        bigModel.deletedPersonID = bigModel.user.persons[index].id
                                        showAlert = true
                                        
                                    }
                            
                            }.padding(15)
                        
                        }.listRowBackground(colorScheme == .dark ? Color.black : Color.white)
                        
                    }
                    .onAppear(perform: {
                        UITableView.appearance().backgroundColor = .clear
                        
                    })
                    .onAppear(perform: {
                            UITableView.appearance().contentInset.top = 0
                    })
                        
                        Spacer()
                        
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
                                      
                }
        }
    }
}

struct DeletePersonView: View {
    
    @State var showAlert: Bool = true
    let db = Firestore.firestore()
    var auth = Auth.auth()
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        VStack {
            Text("")
                .alert(isPresented: $showAlert, content: {
                
                Alert(title: Text("Previous location data"), message: Text("Do you want to keep your saved location ?"), primaryButton: .default(Text("Change")) {
                
                }, secondaryButton: .default(Text("Keep").font(.system(.caption))) {
                    
                    //suppression de la personne
                    db.collection("users").document("user\(Auth.auth().currentUser?.uid ?? "nil")").collection("persons").document(bigModel.deletedPersonID).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        
                            //récupération des nouvelles données des personnes
                            bigModel.db.collection("users").document("user\(self.auth.currentUser?.uid ?? "nil")").collection("persons").getDocuments { snapshot, error in
                                guard error == nil else {
                                    print(error!.localizedDescription)
                                    return
                                }
                                
                                bigModel.user.persons.removeAll()
                                if let snapshot = snapshot {
                                    for document in snapshot.documents {
                                        let dbID = document.documentID
                                        let dbName = document.data()["name"] as? String ?? ""
                                        let dbEmail = document.data()["email"] as? String ?? ""
                                        
                                        bigModel.user.persons.append(BigModel.Person(id: dbID, email: dbEmail, name: dbName))
                                        
                                        print("doc added")
                                    }
                                }
                                bigModel.deletedPersonID = ""
                                
                            }
                        
                        }
                    }
                
                })
            })
        }
    }
}

struct PersonPickerView_Previews: PreviewProvider {
    
    static var previews: some View {
        if #available(iOS 14.0, *) {
            PersonPickerView()
                .environmentObject(BigModel(shouldInjectMockedData: true))
        } else {
            // Fallback on earlier versions
        }
    }
}
