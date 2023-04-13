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
    
    @Environment(\.colorScheme) var theColorScheme
    let db = Firestore.firestore()
    @State var newPersonEmail: String = ""
    @State var newPersonName: String = ""
    @EnvironmentObject var bigModel: BigModel
    var auth = Auth.auth()

    var body: some View {
        
        ZStack {
            
            if theColorScheme == .light {
                Color.gray
                    .opacity(0.25)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Color("Background")
                .edgesIgnoringSafeArea(.all)
            }
            
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
                    
                    Text("New person")
                        .font(.headline)
                        .foregroundColor(Color.white)
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
                 
                 HStack {
                                                     
                     Spacer()
                    
                     TextField("name", text: $newPersonName)
                         .disableAutocorrection(true)
                         .autocapitalization(.none)
                 }
                 
                 Spacer()

                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                .cornerRadius(7)
                .frame(height: 30)
                .padding(10)
                                
                VStack {
                 
                 Spacer()
                 
                 HStack {
                                                     
                     Spacer()
                    
                     TextField("email", text: $newPersonEmail)
                         .disableAutocorrection(true)
                         .autocapitalization(.none)
                 }
                 
                 Spacer()

                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                .cornerRadius(7)
                .frame(height: 30)
                .padding(10)
                
                Spacer()
                
                if #available(iOS 14.0, *) {
                    
                    HStack {
                            
                        Spacer()
            
                        Text("Save")
                            .foregroundColor(newPersonName != "" && newPersonEmail != "" ? Color.white: Color.black)
                            .fontWeight(.semibold)

                        Spacer()
                        
                    }.frame(width: UIScreen.main.bounds.width - 50)
                    .padding(5)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .onTapGesture {
                            
                        if newPersonEmail != "" && newPersonName != "" {
                            
                            if bigModel.isThereAPersonWithTheSameName(name: newPersonName) == true {
                                alertTF(title: "Alert", message: "A person with the same name already exists, please choose another name", primaryTitle: "Ok") {
                                    
                                }
                            } else {
                                
                                db.collection("users").document("user\(auth.currentUser?.uid ?? "")").collection("persons").document().setData(["email": newPersonEmail, "name": newPersonName])
                                
                                bigModel.fetchPerson()
                                bigModel.authCurrentView = .Auth_PersonPickerView
                            }
                            
                            //db.collection("users").document("user\(Auth.auth().currentUser?.uid ?? "nil")").collection("persons").document().setData(["email": email, "name": name])
                            
//                            self.db.collection("users").document("user\(Auth.auth().currentUser?.uid ?? "nil")").collection("persons").getDocuments { snapshot, error in
//                                guard error == nil else {
//                                    print(error!.localizedDescription)
//                                    return
//                                }
//
//                                bigModel.user.persons.removeAll()
//
//                                if let snapshot = snapshot {
//                                    for document in snapshot.documents {
//                                        let dbID = document.documentID
//                                        let dbName = document.data()["name"] as? String ?? ""
//                                        let dbEmail = document.data()["email"] as? String ?? ""
//
//                                        bigModel.user.persons.append(BigModel.Person(id: dbID, email: dbEmail, name: dbName))
//                                        print(bigModel.user.persons.count)
//                                        print("person added")
//
//                                    }
//
//                                    bigModel.authCurrentView = .Auth_PersonPickerView
//
//                                }
//
//                                email = ""
//                                name = ""
//                                print(bigModel.user.persons.count)
//                                print(Auth.auth().currentUser?.uid ?? "nil")
//
//                            }
                            
                        }
                        
                    }
//                        .onChange(of: bigModel.user.persons.count) { newValue in
//                            db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.user.persons[bigModel.user.persons.count-1].id).collection("Location").document().setData(["civilty": "", "firstName": "", "lastName": "", "emailAdress": email, "phoneNumber": "", "adressPostalCode": "", "adressCity": "", "adressStreet": "", "adressMailBox": "", "adressBasement": "", "adressStage": "", "adressLat": 0, "adressLong": 0]) { _ in
//
//                                db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.user.persons[bigModel.user.persons.count-1].id).collection("Location").getDocuments { snapshot, error in
//
//                                    guard error == nil else {
//                                        print(error!.localizedDescription)
//                                        return
//                                    }
//
//                                    if let snapshot = snapshot {
//                                        for document in snapshot.documents {
//
//                                            let dbCivility = document.data()["civility"] as? String ?? ""
//                                            let dbFirstName = document.data()["firstName"] as? String ?? ""
//                                            let dbLastName = document.data()["lastName"] as? String ?? ""
//                                            let dbEmailAdress = document.data()["emailAdress"] as? String ?? ""
//                                            let dbPhoneNumber = document.data()["phoneNumber"] as? String ?? ""
//                                            let dbAdressCountry = document.data()["adressCountry"] as? String ?? ""
//                                            let dbAdressPostalCode = document.data()["adressPostalCode"] as? String ?? ""
//                                            let dbAdressCity = document.data()["adressCity"] as? String ?? ""
//                                            let dbAdressStreet = document.data()["adressStreet"] as? String ?? ""
//                                            let dbAdressMailBox = document.data()["adressMailBox"] as? String ?? ""
//                                            let dbAdressBasement = document.data()["adressBasement"] as? String ?? ""
//                                            let dbAdressStage = document.data()["adressStage"] as? String ?? ""
//                                            let dbAdressLat = document.data()["adressLat"] as? CGFloat ?? 44
//                                            let dbAdressLong = document.data()["adressLong"] as? CGFloat ?? 44
//
//                                            bigModel.user.persons[bigModel.user.persons.count-1].location = BigModel.Location(id: document.documentID, civility: dbCivility, firstName: dbFirstName, lastName: dbLastName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressCountry: dbAdressCountry, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: dbAdressLat, adressLong: dbAdressLong)
//
//                                        }
//                                    }
//
//                                }
//
//                            }
//
//                            db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.user.persons[bigModel.user.persons.count-1].id).collection("Measurements").document().setData(["ArmpitsMeasurement": "", "ArmsLength": "", "HeadMeasurement": "", "PelvisMeasurement": "", "PelvisKnee": "", "ShouldersMeasurement": "", "ShouldersPelvis": ""]) { _ in
//
//                            }
//                        }
                } else {
                    // Fallback on earlier versions
                }
                
                Spacer()
                    .frame(height: 30)
                
            }
            
        }
    }
}

struct NewPersonTextFieldModel: View {
    
    var title: String
    @State var text: String = ""
    @Environment(\.colorScheme) var theColorScheme
    
    var body: some View {

        VStack {
         
         Spacer()
         
         HStack {
                                             
             Spacer()
            
             TextField(title, text: $text)
                 .disableAutocorrection(true)
                 .autocapitalization(.none)
         }
         
         Spacer()

        }.background(theColorScheme == .dark ? Color.gray : Color.white)
        .cornerRadius(7)
        .frame(height: 30)
        .padding(10)
        
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewPersonView()
            .environmentObject(BigModel())
    }
}
