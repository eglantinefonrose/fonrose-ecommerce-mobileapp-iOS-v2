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
                    
                    ZStack {
                        //BackButtonModel()
                        Text("Persons")
                            .fontWeight(.semibold)
                        
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
                    }
                    
                    if #available(iOS 15.0, *) {
                                                                                    
                        if #available(iOS 16.0, *) {
                            List {
                                
                                ForEach(bigModel.user.persons.indices, id: \.self) { index in
                                    
                                    HStack {
                                        
                                        HStack {
                                            
                                            Text(bigModel.user.persons[index].name)
                                                //.foregroundColor(colorScheme == .dark ? .white : .black)
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                            
                                        }.onTapGesture {
                                            
                                            Task {
                                                
                                                bigModel.currentPersonIndex = index
                                                bigModel.currentPersonId = bigModel.user.persons[index].id
                                                
                                                if bigModel.selectedProductId != nil {
                                                    bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements = await bigModel.updatedMeasurementModel()
                                                }
                                                bigModel.authCurrentView = .Auth_UserInfo
                                                
                                                //try await bigModel.fetchOrders()
                                                
                                                print("true")
                                                
                                                //if bigModel.selectedProductId != nil {
                                                    //bigModel.fetchNeededMeasurement(selectedProductId: bigModel.selectedProductId)
                                                //}
                                                
                                                //bigModel.fetchLocation()
                                                
                                            }
                                            
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
                                    }.padding(.vertical, 10)
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
                    
                }.padding(20)
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
                    
                    Task {
                        
                        bigModel.deleteSelectedPerson()
                        await bigModel.fetchPerson()
                        
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
