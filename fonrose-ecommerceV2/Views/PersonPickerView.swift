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

struct PersonPickerView: View {

    let db = Firestore.firestore()
    @State var email: String = ""
    @State var name: String = ""
    @EnvironmentObject var bigModel: BigModel
    @State var showPopup = false
    
    var body: some View {
        
        Spacer()
        
        VStack {
            
            Spacer()
            
            List {
                ForEach(bigModel.persons.indices, id: \.self) { index in
                    Text(bigModel.persons[index].name)
                        .onTapGesture {
                            bigModel.currentPersonIndex = index
                            print(bigModel.currentPersonIndex)
                            
                            if index+1 < 10 {
                                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(index+1)").collection("Mensurations").getDocuments { snapshot, error in
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
                                            
                                            bigModel.persons[index].measurements = Measurements(ArmpitsMeasurement: dbArmpitsMeasurement, ArmsLength: dbArmsLength, HeadMeasurement: dbHeadMeasurement, PelvisMeasurement: dbPelvisMeasurement, PelvisKnee: dbPelvisKnee, ShouldersMeasurement: dbShouldersMeasurement, ShouldersPelvis: dbShouldersPelvis)
                                            
                                        }
                                    }
                                    bigModel.currentview = ViewEnum.Measurement_Mensurations
                                }
                            }
                            
                            else {
                                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(index+1)").collection("Mensurations").getDocuments { snapshot, error in
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
                                            
                                            bigModel.persons[index].measurements = Measurements(ArmpitsMeasurement: dbArmpitsMeasurement, ArmsLength: dbArmsLength, HeadMeasurement: dbHeadMeasurement, PelvisMeasurement: dbPelvisMeasurement, PelvisKnee: dbPelvisKnee, ShouldersMeasurement: dbShouldersMeasurement, ShouldersPelvis: dbShouldersPelvis)
                                            
                                        }
                                    }
                                    
                                    bigModel.currentview = ViewEnum.Measurement_Mensurations
                                }
                            }
                            
                        }
                }
            }.onAppear(perform: {
                UITableView.appearance().contentInset.top = 0
            })
            
            Spacer()
            
            Text(Auth.auth().currentUser?.email ?? "nil")
            
            Text("Sign out")
                .foregroundColor(.blue)
                .onTapGesture {
                    bigModel.signOut()
                    bigModel.currentview = ViewEnum.Auth_SignInView
                }
            
            Text("+")
                .foregroundColor(.blue)
                .onTapGesture {
                    showPopup.toggle()
                }
            
            Spacer()
            
        }.sheet(isPresented: $showPopup) {
            
            VStack {
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    Spacer()
                    Text("Close")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            showPopup.toggle()
                        }
                    Spacer()
                        .frame(width: 20)
                }
                
                Spacer()
                
                TextField("name", text: $name)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Spacer()
                
                TextField("email", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Spacer()
                
                Text("Save")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        
                        //Firestore.firestore().collection("user\(Auth.auth().currentUser?.uid ?? "")").document("person01").setData(["email": "", "name": ""])
                        //Firestore.firestore().collection("user\(Auth.auth().currentUser?.uid ?? "")").document("person01").collection("Mensurations").document("user\(Auth.auth().currentUser?.uid ?? "")-person01-Mensurations").setData(["ArmpitsMeasurement": ":)1", "ArmsLength": ":)2", "HeadMeasurement": ":)3", "PelvisMeasurement": ":)4", "PelvisKnee": ":)5", "ShouldersMeasurement": ":)6", "ShouldersPelvis": ":)7"])
                        
                    if bigModel.persons.count < 9 {
                        
                        db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.persons.count+1)").setData(["email": email, "name": name]) { _ in
                                self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").getDocuments { snapshot, error in
                                    guard error == nil else {
                                        print(error!.localizedDescription)
                                        return
                                    }
                                    
                                    bigModel.persons.removeAll()
                                    if let snapshot = snapshot {
                                        for document in snapshot.documents {
                                            let dbName = document.data()["name"] as? String ?? ""
                                            let dbEmail = document.data()["email"] as? String ?? ""
                                            
                                            bigModel.persons.append(Person(id: Int.random(in: 1...999999), email: dbEmail, name: dbName))
                                            print(bigModel.persons.count)
                                            print("doc added")
                                    }
                                }
                                    
                        db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.persons.count)").collection("Mensurations").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(bigModel.persons.count)-Mensurations").setData(["ArmpitsMeasurement": ":)1", "ArmsLength": ":)2", "HeadMeasurement": ":)3", "PelvisMeasurement": ":)4", "PelvisKnee": ":)5", "ShouldersMeasurement": ":)6", "ShouldersPelvis": ":)7"])
                                
                        email = ""
                        name = ""
                        showPopup.toggle()
                        print(bigModel.persons.count)
                        print(Auth.auth().currentUser?.uid ?? "nil")
                                    
                        }
                    }
                        
                }
                    
                else {
                    
                    db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(bigModel.persons.count+1)").setData(["email": email, "name": name]) { _ in
                            self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").getDocuments { snapshot, error in
                                guard error == nil else {
                                    print(error!.localizedDescription)
                                    return
                                }
                                
                                bigModel.persons.removeAll()
                                if let snapshot = snapshot {
                                    for document in snapshot.documents {
                                        let dbName = document.data()["name"] as? String ?? ""
                                        let dbEmail = document.data()["email"] as? String ?? ""
                                        
                                        bigModel.persons.append(Person(id: Int.random(in: 1...999999), email: dbEmail, name: dbName))
                                        print("doc added")
                                }
                            }
                            
                            email = ""
                            name = ""
                            showPopup.toggle()
                            print(bigModel.persons.count)
                            print(Auth.auth().currentUser?.uid ?? "nil")
                                
                                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(bigModel.persons.count)").collection("Mensurations").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person\(bigModel.persons.count)-Mensurations").setData(["ArmpitsMeasurement": ":)1", "ArmsLength": ":)2", "HeadMeasurement": ":)3", "PelvisMeasurement": ":)4", "PelvisKnee": ":)5", "ShouldersMeasurement": ":)6", "ShouldersPelvis": ":)7"])
                                
                        }
                    }
                    
                }
                        
                }
                
                Spacer()
                
            }
        }
        
    }
}
