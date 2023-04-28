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
                                    self.bigModel.currentview = .Home_homeFeed0
                                } else {
                                    alertTF(title: "No person chosen", message: "Please click on the person you want to select", primaryTitle: "Ok") {
                                        
                                    }
                                }
                                
                            }
                        
                    }.padding(20)
                    
                    if #available(iOS 15.0, *) {
                                                                                    
                        if #available(iOS 16.0, *) {
                            List {
                                
                                ForEach(bigModel.user.persons.indices, id: \.self) { index in
                                    
                                    HStack {
                                        
                                        HStack {
                                            
                                            Text(bigModel.user.persons[index].name)
                                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                            
                                            Spacer()
                                            
                                        }.onTapGesture {
                                            
                                            bigModel.currentPersonIndex = index
                                            bigModel.currentPersonId = bigModel.user.persons[index].id
                                            
                                            if bigModel.selectedProductId != nil {
                                                bigModel.fetchNeededMeasurement(selectedProductId: bigModel.selectedProductId ?? 0)
                                            }
                                            
                                            bigModel.fetchMeasurements()
                                            bigModel.fetchLocation()
                                            bigModel.authCurrentView = .Auth_UserInfo
                                            
                                        }
                                        
                                        Image(systemName: "trash")
                                            .foregroundColor(.blue)
                                            .onTapGesture {
                                                print(index)
                                                print(bigModel.user.persons[index].id)
                                                print(bigModel.user.persons[index].name)
                                                //affichage de l'alerte
                                                bigModel.deletedPersonID = bigModel.user.persons[index].id
                                                bigModel.deletedPersonName = bigModel.user.persons[index].name
                                            }
                                    }.padding(10)
                                }.listRowBackground(Color("Background"))
                            }.listStyle(PlainListStyle())
                            .background(Color("Background"))
                            .scrollContentBackground(.hidden)
                        } else {
                            // Fallback on earlier versions
                        }
                    
                    } else {
                        // Fallback on earlier versions
                    }
                                                                                        
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
                
                    Alert(title: Text("Delete \(bigModel.deletedPersonName)"), message: Text("Are you sure you want to delete this person ?"), primaryButton: .default(Text("No")) {
                        bigModel.deletedPersonID = ""
                }, secondaryButton: .default(Text("Yes").font(.system(.caption))) {
                    
                    //suppression de la personne
                    db.collection("users").document("user\(Auth.auth().currentUser?.uid ?? "nil")").collection("persons").document(bigModel.deletedPersonID).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                            bigModel.deletedPersonID = ""
                            bigModel.fetchPerson()
                        
                            //récupération des nouvelles données des personnes
//                            bigModel.db.collection("users").document("user\(self.auth.currentUser?.uid ?? "nil")").collection("persons").getDocuments { snapshot, error in
//                                guard error == nil else {
//                                    print(error!.localizedDescription)
//                                    return
//                                }
//
//                                bigModel.user.persons.removeAll()
//                                if let snapshot = snapshot {
//                                    for document in snapshot.documents {
//                                        let dbID = document.documentID
//                                        let dbName = document.data()["name"] as? String ?? ""
//                                        let dbEmail = document.data()["email"] as? String ?? ""
//
//                                        bigModel.user.persons.append(BigModel.Person(id: dbID, email: dbEmail, name: dbName))
//
//                                        bigModel.deletedPersonID = ""
//
//                                        print("doc added")
//                                    }
//                                }
//                                bigModel.deletedPersonID = ""
//
//                            }
                        
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
