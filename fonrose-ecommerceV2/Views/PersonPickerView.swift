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
                                                
                                                bigModel.currentPersonIndex = index
                                                bigModel.currentPersonId = bigModel.user.persons[index].id
                                                print("current person id \(bigModel.currentPersonId)")
                                                bigModel.authCurrentView = .Auth_UserInfo
                                                bigModel.lastViews.append(.Auth_PersonPickerView)
                                                
                                                if bigModel.signedIn {
                                                    
                                                    print("signed in")
                                                    
                                                    //récupération des données de localisation de la personne selectionnée
                                                    db.collection("users").document("user\(Auth.auth().currentUser?.uid ?? "nil")").collection(bigModel.user.persons[index].id).getDocuments { snapshot, error in
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
                                                  
                                                //récupération des données
                                                db.collection("users").document("user\(Auth.auth().currentUser?.uid ?? "nil")").collection(bigModel.user.persons[index].id).getDocuments { snapshot, error in
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
                                                
                                                } else {
                                                    print("not signed in")
                                                }
                                                
                                                print(index)
                                                
                                            }
                                            
                                        Spacer() }
                                        
                                        Image(systemName: "trash")
                                            .foregroundColor(.blue)
                                            .onTapGesture {
                                                bigModel.personNumber = bigModel.user.persons.count < 10 ? "0\(index+1)" : "\(index+1)"
                                                bigModel.currentview = .Auth_DeleteScreen
                                                bigModel.deletedPersonIndex = index
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

struct DeleteScreen: View {
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                Spacer()
                
                Text("Are you sure you want to delete you want to delete this person?")
                Text("Associated informations such as measurements or location adress will be definitively lost.")
                
                Spacer()
                
                Text("Delete")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        bigModel.deletePerson()
                        bigModel.numberArray.remove(at: bigModel.deletedPersonIndex)
                    }
                
                Spacer()
                
            }
            
            Text("delete all informations of the intern arraw")
                .foregroundColor(.blue)
                .onTapGesture {
                    print("delete intern data")
                    bigModel.user.persons.removeAll()
                }
            
            Spacer()
            
            Text("get fb data")
                .foregroundColor(.blue)
                .onTapGesture {
                    
                    db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").getDocuments { snapshot, error in
                        
                        guard error == nil else {
                            print(error!.localizedDescription)
                            return
                        }
                        
                        if let snapshot = snapshot {
                            
                            for document in snapshot.documents {
                                
                                let dbID = document.documentID
                                let dbName = document.data()["name"] as? String ?? ""
                                let dbEmail = document.data()["email"] as? String ?? ""
                                
                                bigModel.user.persons.append(BigModel.Person(id: dbID, email: dbEmail, name: dbName))
                                print("get data")
                                
                            }
                            
                        }
                        
                    }
                    
                }
            
            VStack {
                
                
                
            }
            
            Text("get location and measurements data")
                .onTapGesture {
                    
                    for _ in bigModel.user.persons {
                        print("numberArray = \(bigModel.numberArray.first ?? 666)")
                        
                        db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.numberArray.first ?? 666)").collection("Location").getDocuments { snapshot, error in
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
                                    
                                    bigModel.user.persons[bigModel.numberArray.first ?? 666].location = BigModel.Location(civility: dbCivility, lastName: dbLastName, firstName: dbFirstName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: CGFloat(dbAdressLat), adressLong: CGFloat(dbAdressLong))
                                    
                                }
                            }
                        }
                        
                        db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.numberArray.first ?? 666)").collection("Mensurations").getDocuments { snapshot, error in
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
                                    
                                    bigModel.user.persons[bigModel.numberArray.first ?? 666].location = BigModel.Location(civility: dbCivility, lastName: dbLastName, firstName: dbFirstName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: CGFloat(dbAdressLat), adressLong: CGFloat(dbAdressLong))
                                    
                                }
                            }
                        }
                        
                        if bigModel.user.persons.count != 0 {
                            bigModel.numberArray.removeFirst()
                        }
                        
                    }
                }
            
            Text("💋")
                .onTapGesture {
                    var number = 0
                    for _ in bigModel.user.persons {
                        bigModel.numberArray.append(number)
                        number = number+1
                    }
                }
            
            Spacer()
            
            VStack {
                
                Spacer()
                
                Text("delete last lign")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        db.collection("user\(self.auth.currentUser?.uid ?? "nil")").document("person0\(bigModel.user.persons.count+1)").delete() { err in
                            
                            if let err = err {
                                print("Error removing document: \(err)")
                            } else {
                                print("Document successfully removed!")
                            }
                        }
                    }
                
                VStack {
                    
                    Spacer()
                    
                    Text("reupload data")
                        .onTapGesture {
                            print("intern arraw")
                            var number = 0
                            for _ in bigModel.user.persons {
                                self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(number+1)").setData(["name": bigModel.user.persons[number].name, "email": bigModel.user.persons[number].email])
                                
                                self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(number+1)").collection("Mensurations").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(number+1)-Mensurations").setData(["ArmpitsMeasurement": bigModel.user.persons[number].measurements?.ArmpitsMeasurement ?? "", "ArmsLength": bigModel.user.persons[number].measurements?.ArmsLength ?? "", "HeadMeasurement": bigModel.user.persons[number].measurements?.HeadMeasurement ?? "", "PelvisMeasurement": bigModel.user.persons[number].measurements?.PelvisMeasurement ?? "", "PelvisKnee": bigModel.user.persons[number].measurements?.PelvisKnee ?? "", "ShouldersMeasurement": bigModel.user.persons[number].measurements?.ShouldersMeasurement ?? "", "ShouldersPelvis": bigModel.user.persons[number].measurements?.ShouldersPelvis ?? ""])
                                
                                self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(number+1)").collection("Location").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(number+1)-Location").setData(["civility": bigModel.user.persons[number].location?.civility ?? "", "lastName" : bigModel.user.persons[number].location?.lastName ?? "", "firstName": bigModel.user.persons[number].location?.firstName ?? "", "emailAdress": bigModel.user.persons[number].location?.emailAdress ?? "", "phoneNumber": bigModel.user.persons[number].location?.phoneNumber ?? "", "adressPostalCode": bigModel.user.persons[number].location?.adressPostalCode ?? "", "adressCity": bigModel.user.persons[number].location?.adressCity ?? "", "adressStreet": bigModel.user.persons[number].location?.adressStreet ?? "", "adressMailBox": bigModel.user.persons[number].location?.adressMailBox ?? "", "adressBasement": bigModel.user.persons[number].location?.adressBasement ?? "", "adressStage": bigModel.user.persons[number].location?.adressStage ?? "", "adressLat": bigModel.user.persons[number].location?.adressLat ?? 0, "adressLong": bigModel.user.persons[number].location?.adressLong ?? 0])
                                
                                number = number+1
                            }
                        }
                    
                    Spacer()
                    
                }
                
                Text("Go to person picker view")
                    .onTapGesture {
                        bigModel.currentview = .Auth_PersonPickerView
                    }
                
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
