//
//  NewUserView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 06/07/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct NewPersonView: View {
    
    let db = Firestore.firestore()
    @State var email: String = ""
    @State var name: String = ""
    @EnvironmentObject var bigModel: BigModel
    var auth = Auth.auth()

    var body: some View {
        VStack {
            
            Spacer()
            
            TextField("name", text: $name)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Spacer()
            
            TextField("email", text: $email)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Spacer()
            
            if #available(iOS 14.0, *) {
                Text("Save")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        
                        db.collection("users").document("user\(Auth.auth().currentUser?.uid ?? "nil")").collection("persons").document().setData(["email": email, "name": name])
                        
                        self.db.collection("users").document("user\(Auth.auth().currentUser?.uid ?? "nil")").collection("persons").getDocuments { snapshot, error in
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
                                    print(bigModel.user.persons.count)
                                    print("person added")
                                    
                                }
                                
                                bigModel.authCurrentView = .Auth_PersonPickerView
                                
                            }
                            
                            email = ""
                            name = ""
                            print(bigModel.user.persons.count)
                            print(Auth.auth().currentUser?.uid ?? "nil")
                            
                        }
                        
                    }
                    .onChange(of: bigModel.user.persons.count) { newValue in
                        db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.user.persons[bigModel.user.persons.count-1].id).collection("Location").document().setData(["civility": "", "lastName" : "", "firstName": "", "emailAdress": email, "phoneNumber": "", "adressPostalCode": "", "adressCity": "", "adressStreet": "", "adressMailBox": "", "adressBasement": "", "adressStage": "", "adressLat": 0, "adressLong": 0]) { _ in
                            
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
                                        let dbAdressPostalCode = document.data()["adressPostalCode"] as? String ?? ""
                                        let dbAdressCity = document.data()["adressCity"] as? String ?? ""
                                        let dbAdressStreet = document.data()["adressStreet"] as? String ?? ""
                                        let dbAdressMailBox = document.data()["adressMailBox"] as? String ?? ""
                                        let dbAdressBasement = document.data()["adressBasement"] as? String ?? ""
                                        let dbAdressStage = document.data()["adressStage"] as? String ?? ""
                                        let dbAdressLat = document.data()["adressLat"] as? CGFloat ?? 44
                                        let dbAdressLong = document.data()["adressLong"] as? CGFloat ?? 44
                                        
                                        bigModel.user.persons[bigModel.user.persons.count-1].location = BigModel.Location(id: document.documentID, civility: dbCivility, lastName: dbLastName, firstName: dbFirstName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: dbAdressLat, adressLong: dbAdressLong)
                                        
                                    }
                                }
                                
                            }
                            
                        }
                        
                        db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.user.persons[bigModel.user.persons.count-1].id).collection("Measurements").document().setData(["ArmpitsMeasurement": "", "ArmsLength": "", "HeadMeasurement": "", "PelvisMeasurement": "", "PelvisKnee": "", "ShouldersMeasurement": "", "ShouldersPelvis": ""]) { _ in
                            
                            /*db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.user.persons[bigModel.user.persons.count-1].id).collection("Measurements").getDocuments { snapshot, error in
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
                                
                            }*/
                            
                        }
                    }
            } else {
                // Fallback on earlier versions
            }
            
            Spacer()
            
        }
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewPersonView()
    }
}
