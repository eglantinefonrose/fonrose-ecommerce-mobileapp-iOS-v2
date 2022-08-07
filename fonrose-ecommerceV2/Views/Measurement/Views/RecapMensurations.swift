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
            VStack {
                
                Spacer()
                    
                    HStack {
                        Spacer()
                            .frame(width: 50)
                        
                        Text("Recap")
                            .font(.system(size: 45, weight: .bold, design: .default))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack {
                                            
                        RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.ArmpitsMeasurement ?? "nil")
                            
                        RecapMensurationsTextStruct(recapMeasurementText: "Arms Length", recapMeasurementText2: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.ArmsLength ?? "nil")
                        
                        RecapMensurationsTextStruct(recapMeasurementText: "Head Measurement", recapMeasurementText2: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.HeadMeasurement ?? "nil")
                        
                        RecapMensurationsTextStruct(recapMeasurementText: "Pelvis knee", recapMeasurementText2: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.PelvisKnee ?? "nil")
                        
                        RecapMensurationsTextStruct(recapMeasurementText: "Pelvis Measurement", recapMeasurementText2: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.PelvisMeasurement ?? "nil")
                        
                        RecapMensurationsTextStruct(recapMeasurementText: "Shoulders Measurement", recapMeasurementText2: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.ShouldersMeasurement ?? "nil")
                        
                        RecapMensurationsTextStruct(recapMeasurementText: "Shoulders Pelvis", recapMeasurementText2: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.ShouldersPelvis ?? "nil")
                            
                        }
                    
                        Spacer()
                    
                        VStack {
                        
                        Button(action: {
                            self.bigModel.lastViews.append(.FinalizeOrderViews_RecapMensurations)
                            self.bigModel.currentview = .FinalizeOrderViews_Livraison
                            print("previous View = \(String(describing: self.bigModel.lastViews.last))")
                            print(self.bigModel.lastViews.count)
                            print("location")
                            
                            if bigModel.signedIn {
                                
                                print("signed in")
                                
                                if bigModel.currentPersonIndex+1 < 10 {
                                    
                                    db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.currentPersonIndex+1)").collection("Location").getDocuments { snapshot, error in
                                        guard error == nil else {
                                            print(error!.localizedDescription)
                                            return
                                        }
                                        
                                        if let snapshot = snapshot {
                                            for document in snapshot.documents {
                                                let dbAdressPostalCode = document.data()["adressPostalCode"] as? String ?? ""
                                                let dbAdressCity = document.data()["adressCity"] as? String ?? ""
                                                let dbAdressStreet = document.data()["adressStreet"] as? String ?? ""
                                                let dbAdressMailBox = document.data()["adressMailBox"] as? String ?? ""
                                                let dbAdressBasement = document.data()["adressBasement"] as? String ?? ""
                                                let dbAdressStage = document.data()["adressStage"] as? String ?? ""
                                                let dbAdressLat = document.data()["adressLat"] as? Int ?? 0
                                                let dbAdressLong = document.data()["adressLong"] as? Int ?? 0
                                                
                                                bigModel.user.persons[bigModel.currentPersonIndex].location = BigModel.Location(adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: CGFloat(dbAdressLat), adressLong: CGFloat(dbAdressLong))
                                                
                                            }
                                        }
                                        
                                    }
                                      
                                }
                                
                                else {
                                    
                                    db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(bigModel.currentPersonIndex+1)").collection("Location").getDocuments { snapshot, error in
                                        guard error == nil else {
                                            print(error!.localizedDescription)
                                            return
                                        }
                                        
                                        if let snapshot = snapshot {
                                            for document in snapshot.documents {
                                                let dbAdressPostalCode = document.data()["adressPostalCode"] as? String ?? ""
                                                let dbAdressCity = document.data()["adressCity"] as? String ?? ""
                                                let dbAdressStreet = document.data()["adressStreet"] as? String ?? ""
                                                let dbAdressMailBox = document.data()["adressMailBox"] as? String ?? ""
                                                let dbAdressBasement = document.data()["adressBasement"] as? String ?? ""
                                                let dbAdressStage = document.data()["adressStage"] as? String ?? ""
                                                let dbAdressLat = document.data()["adressLat"] as? Int ?? 0
                                                let dbAdressLong = document.data()["adressLong"] as? Int ?? 0
                                                
                                                bigModel.user.persons[bigModel.currentPersonIndex].location = BigModel.Location(adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: CGFloat(dbAdressLat), adressLong: CGFloat(dbAdressLong))
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            }) {
                                //Spacer()
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        HStack {
                                            
                                            Spacer()
                                            Text("Location")
                                                .foregroundColor(Color.white)
                                                .fontWeight(.semibold)
                                            Spacer()
                                        
                                        }.background(Color.blue)
                                        .frame(width: 150)
                                        .cornerRadius(5)
                                        
                                        Spacer()
                                        
                                }.frame(width: 120, height: 35)
                                .background(Color.blue)
                                .cornerRadius(15)
                                
                            //Spacer()
                        }
                        
                        Spacer()
                            .frame(height: 20)
                           
                        Button(action: {
                            self.bigModel.currentview = .Measurement_Mensurations
                        }) {
                            Text("Edit measurements")
                                .foregroundColor(Color.blue)
                        }
                        
                        Spacer()
                            .frame(height: 25)
                        
                    }
                                
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

struct RecapMensurationsTextStruct: View {
    
    var recapMeasurementText: String
    var recapMeasurementText2: String
    
    var body : some View {
        
        VStack {
            HStack {
                
            Spacer()
                .frame(width: 50)
                               
                Text(recapMeasurementText)
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, design: .default))
                    .frame(height: 50, alignment: .leading)
                               
                Spacer()
                               
                Text(recapMeasurementText2)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 20, design: .default))
                    .frame(height: 50, alignment: .leading)
                               
                Spacer()
                    .frame(width: 50)
            
            }
            
            Spacer()
                .frame(height: 7)
        }
        
    }
    
}

struct RecapMensurations_Previews: PreviewProvider {
    static var previews: some View {
        RecapMensurations()
            .environmentObject(BigModel())
    }
}
