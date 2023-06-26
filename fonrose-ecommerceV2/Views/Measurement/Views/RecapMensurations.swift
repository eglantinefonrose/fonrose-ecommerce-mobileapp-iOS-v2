//
//  RecapMensurations.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 10/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RecapMensurations: View {
    
    @EnvironmentObject var bigModel: BigModel
    var auth = Auth.auth()
    var db = Firestore.firestore()
    
    var body: some View {
                                
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                BackButtonModel(text: "Recap")
                
                Spacer()
                    
                    HStack {
                        
                        Text("Recap")
                            .font(.system(size: 45, weight: .bold, design: .default))
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack {
                         
                        VStack {
                            if bigModel.isMeasurements0Requested {
                                RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[0].measurementValue) ?? "nil")
                            }
                            
                            if bigModel.isMeasurements1Requested {
                                RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[1].measurementValue) ?? "nil")
                            }
                            
                            if bigModel.isMeasurements2Requested {
                                RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[2].measurementValue) ?? "nil")
                            }
                            
                            if bigModel.isMeasurements3Requested {
                                RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[3].measurementValue) ?? "nil")
                            }
                            
                            if bigModel.isMeasurements4Requested {
                                RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[4].measurementValue) ?? "nil")
                            }
                            
                            if bigModel.isMeasurements5Requested {
                                RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[5].measurementValue) ?? "nil")
                            }
                            
                            if bigModel.isMeasurements6Requested {
                                RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[6].measurementValue) ?? "nil")
                            }
                            
                            if bigModel.isMeasurements7Requested {
                                RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[7].measurementValue) ?? "nil")
                            }
                            
                            if bigModel.isMeasurements8Requested {
                                RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[8].measurementValue) ?? "nil")
                                
                            }
                            
                        }
                        
                        if bigModel.isMeasurements9Requested {
                            RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[9].measurementValue) ?? "nil")
                        }
                        
                        if bigModel.isMeasurements10Requested {
                            RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[10].measurementValue) ?? "nil")
                        }
                        
                        if bigModel.isMeasurements11Requested {
                            RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[11].measurementValue) ?? "nil")
                        }
                            
                        }
                    
                        Spacer()
                    
                    VStack {
                        
                        HStack {
                            Spacer()
                            Text("Save")
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                                .padding(10)
                            Spacer()
                        }.background(Color.blue)
                        .cornerRadius(15)
                        .onTapGesture {
                            self.bigModel.lastViews.append(.Measurement_RecapMensurations)
                            
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
                            
                            print("previous View = \(String(describing: self.bigModel.lastViews.last))")
                            print(self.bigModel.lastViews.count)
                            print("location")
                            
                            if bigModel.signedIn {
                                
                                print("signed in")
                                    
                                    db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.currentPersonId).collection("Location").getDocuments { snapshot, error in
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
                            
                        }
                           
                        
                    Text("Edit measurements")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.bigModel.currentview = .Measurement_Mensurations
                        }
                    }
                                
            }.padding(20)
            
        }
    }
        
}

struct RecapMensurationsTextStruct: View {
    
    var recapMeasurementText: String
    var recapMeasurementText2: String
    
    var body : some View {
        
        VStack {
            HStack {
                Text(recapMeasurementText)
                    .font(.system(size: 20, design: .default))
                    .frame(height: 50, alignment: .leading)
                               
                Spacer()
                               
                Text(recapMeasurementText2)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 20, design: .default))
                    .frame(height: 50, alignment: .leading)
            }
            
            Spacer()
                .frame(height: 7)
        }
        
    }
    
}

struct RecapMensurations_Previews: PreviewProvider {
    static var previews: some View {
        RecapMensurations()
            .environmentObject(BigModel.init(shouldInjectMockedData: true))
    }
}
