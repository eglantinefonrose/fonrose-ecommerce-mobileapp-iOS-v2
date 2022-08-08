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

struct NewUserView: View {
    
    let db = Firestore.firestore()
    @State var email: String = ""
    @State var name: String = ""
    @EnvironmentObject var bigModel: BigModel

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
                                        print("person added")
                                        bigModel.authCurrentView = .Auth_PersonPickerView
                                        
                                    }
                                }
                                
                                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.user.persons.count)").collection("Mensurations").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(bigModel.user.persons.count)-Mensurations").setData(["ArmpitsMeasurement": "", "ArmsLength": "", "HeadMeasurement": "", "PelvisMeasurement": "", "PelvisKnee": "", "ShouldersMeasurement": "", "ShouldersPelvis": ""])
                                
                                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.user.persons.count)").collection("Location").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(bigModel.user.persons.count)-Location").setData(["civility": "", "lastName" : "", "firstName": "", "emailAdress": "", "phoneNumber": "", "adressPostalCode": "", "adressCity": "", "adressStreet": "", "adressMailBox": "", "adressBasement": "", "adressStage": "", "adressLat": 0, "adressLong": 0])
                            
                    email = ""
                    name = ""
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
                                    print(bigModel.user.persons.count)
                                    print("person added")
                                    bigModel.authCurrentView = .Auth_PersonPickerView
                                    
                                }
                            }
                        
                        email = ""
                        name = ""
                        print(bigModel.user.persons.count)
                        print(Auth.auth().currentUser?.uid ?? "nil")
                            
                            db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(bigModel.user.persons.count)").collection("Mensurations").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person\(bigModel.user.persons.count)-Mensurations").setData(["ArmpitsMeasurement": "", "ArmsLength": "", "HeadMeasurement": "", "PelvisMeasurement": "", "PelvisKnee": "", "ShouldersMeasurement": "", "ShouldersPelvis": ""])
                            
                            db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(bigModel.user.persons.count)").collection("Location").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person\(bigModel.user.persons.count)-Location").setData(["civility": "", "lastName" : "", "firstName": "", "emailAdress": "", "phoneNumber": "", "adressPostalCode": "", "adressCity": "", "adressStreet": "", "adressMailBox": "", "adressBasement": "", "adressStage": "", "adressLat": 0, "adressLong": 0])
                            
                    }
                }
                
            }
                    
            }
            
            Spacer()
            
        }
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView()
    }
}
