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
                        
                        if #available(iOS 14.0, *) {
                            List {
                                ForEach(bigModel.user.persons.indices, id: \.self) { index in
                                    Text(bigModel.user.persons[index].name)
                                        .foregroundColor(.white)
                                        .onTapGesture {
                                            bigModel.currentPersonIndex = index
                                            print(bigModel.currentPersonIndex)
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
                                                                bigModel.isPersonChosen = true
                                                                
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
                                                }
                                                
                                            } else {
                                                print("not signed in")
                                            }
                                            
                                            print(index)
                                            
                                        }
                                }.listRowBackground(Color.black)
                            }.background(Color.black)
                            .onAppear(perform: {
                                UITableView.appearance().backgroundColor = .clear
                                
                            })
                            .onAppear(perform: {
                                    UITableView.appearance().contentInset.top = 0
                                })
                        } else {
                            // Fallback on earlier versions
                        }
                        
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
                                    
                                if bigModel.user.persons.count < 9 {
                                    
                                    db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.user.persons.count+1)").setData(["email": email, "name": name]) { _ in
                                            self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").getDocuments { snapshot, error in
                                                guard error == nil else {
                                                    print(error!.localizedDescription)
                                                    return
                                                }
                                                
                                                bigModel.user.persons.removeAll()
                                                if let snapshot = snapshot {
                                                    for document in snapshot.documents {
                                                        let dbName = document.data()["name"] as? String ?? ""
                                                        let dbEmail = document.data()["email"] as? String ?? ""
                                                        
                                                        bigModel.user.persons.append(BigModel.Person(id: Int.random(in: 1...999999), email: dbEmail, name: dbName))
                                                        print(bigModel.user.persons.count)
                                                        print("doc added")
                                                }
                                            }
                                                
                                                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.user.persons.count)").collection("Mensurations").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(bigModel.user.persons.count)-Mensurations").setData(["ArmpitsMeasurement": ":)1", "ArmsLength": ":)2", "HeadMeasurement": ":)3", "PelvisMeasurement": ":)4", "PelvisKnee": ":)5", "ShouldersMeasurement": ":)6", "ShouldersPelvis": ":)7"])
                                            
                                    email = ""
                                    name = ""
                                    showPopup.toggle()
                                    print(bigModel.user.persons.count)
                                    print(Auth.auth().currentUser?.uid ?? "nil")
                                                
                                    }
                                }
                                    
                            }
                                
                            else {
                                
                                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(bigModel.user.persons.count+1)").setData(["email": email, "name": name]) { _ in
                                        self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").getDocuments { snapshot, error in
                                            guard error == nil else {
                                                print(error!.localizedDescription)
                                                return
                                            }
                                            
                                            bigModel.user.persons.removeAll()
                                            if let snapshot = snapshot {
                                                for document in snapshot.documents {
                                                    let dbName = document.data()["name"] as? String ?? ""
                                                    let dbEmail = document.data()["email"] as? String ?? ""
                                                    
                                                    bigModel.user.persons.append(BigModel.Person(id: Int.random(in: 1...999999), email: dbEmail, name: dbName))
                                                    print("doc added")
                                            }
                                        }
                                        
                                        email = ""
                                        name = ""
                                        showPopup.toggle()
                                            print(bigModel.user.persons.count)
                                        print(Auth.auth().currentUser?.uid ?? "nil")
                                            
                                            db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(bigModel.user.persons.count)").collection("Mensurations").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person\(bigModel.user.persons.count)-Mensurations").setData(["ArmpitsMeasurement": ":)1", "ArmsLength": ":)2", "HeadMeasurement": ":)3", "PelvisMeasurement": ":)4", "PelvisKnee": ":)5", "ShouldersMeasurement": ":)6", "ShouldersPelvis": ":)7"])
                                            
                                    }
                                }
                                
                            }
                                    
                            }
                            
                            Spacer()
                            
                        }
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
