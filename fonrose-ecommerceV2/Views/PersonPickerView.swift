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
                            
            VStack {
                
                VStack {
                    
                    HStack {
                        
                        Text("back")
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
                        
                        Text("persons")
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Image(systemName: "house")
                            .foregroundColor(Color.blue)
                            .onTapGesture {
                                if bigModel.currentPersonIndex == nil {
                                    alertTF(title: "Alert", message: "Select a person first", primaryTitle: "Ok") {
                                        
                                    }
                                } else {
                                    self.bigModel.currentview = .Home_homeFeed0
                                }
                            }
                        
                    }
                    
                    if #available(iOS 15.0, *) {
                                                                                    
                        if #available(iOS 16.0, *) {
                            
                            if bigModel.user.persons.count != 0 {
                                List {
                                    
                                    ForEach(bigModel.user.persons.indices, id: \.self) { index in
                                        
                                        HStack {
                                            
                                            HStack {
                                                
                                                Text(bigModel.user.persons[index].name)
                                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                                    .foregroundColor(.black)
                                                
                                                Spacer()
                                                
                                            }.onTapGesture {
                                                
                                                //Task {
                                                    
                                                bigModel.currentPersonIndex = index
                                                UserDefaults.standard.set(index, forKey: "lastCurrentPersonIndex")
                                                bigModel.currentPersonId = bigModel.user.persons[index].id ?? "nilcb"
                                                UserDefaults.standard.set(index, forKey: "lastCurrentPersonId")
                                                bigModel.isMeasurementModelUpdated = true
                                                //bigModel.selectedProductId = nil
                                                
                                                Task {
                                                    
                                                    await bigModel.fetchMeasurements()
                                                    
                                                    if bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements.count == 0 {
                                                        print("measurments nil")
                                                        await bigModel.initializeMeasurements()
                                                        await bigModel.fetchMeasurements()
                                                    } else {
                                                        print("not nil")
                                                    }
                                                    
                                                    await bigModel.fetchLocation()
                                                    
                                                    if bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location == nil {
                                                        print("location nil")
                                                        await bigModel.initializeLocation()
                                                        await bigModel.fetchLocation()
                                                    } else {
                                                        print("not nil")
                                                    }
                                                }
                                                
                                                bigModel.authCurrentView = .Auth_UserInfo
                                                bigModel.authLastViews.append(.Auth_PersonPickerView)
                                                bigModel.fullViewHistory.append(.Auth_PersonPickerView)
                                                
                                                
                                            }
                                            
                                            Image(systemName: "trash")
                                                .foregroundColor(.blue)
                                                .onTapGesture {
                                                    print(index)
                                                    print(bigModel.user.persons[index].id)
                                                    print(bigModel.user.persons[index].name)
                                                    //affichage de l'alerte
                                                    bigModel.deletedPersonID = bigModel.user.persons[index].id ?? "nil"
                                                    bigModel.deletedPersonName = bigModel.user.persons[index].name
                                                }
                                        }.padding(.vertical, 10)
                                    }.listRowBackground(Color("Background"))
                                }.listStyle(PlainListStyle())
                                .background(Color("Background"))
                                .scrollContentBackground(.hidden)
                            } else {
                                Spacer()
                                VStack(spacing: 20) {
                                    Text("no-persons")
                                        .multilineTextAlignment(.center)
                                    ZStack {
                                        Circle()
                                            .foregroundStyle(Color(UIColor.lightGray))
                                            .frame(width: 70, height: 70)
                                        Image(systemName: "person.badge.plus")
                                            .font(.title)
                                            .foregroundStyle(Color.white)
                                    }.onTapGesture {
                                        bigModel.authCurrentView = .Auth_NewUserView
                                    }
                                }
                                Spacer()
                            }
                            
                        } else {
                            // Fallback on earlier versions
                        }
                    
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    Text("sign-out")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            bigModel.signOut()
                            bigModel.authCurrentView = ViewEnum.Auth_LogInEmailView
                        }
                    
                }.padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "person.badge.plus")
                            .foregroundStyle(Color.white)
                            .padding(.vertical, 7)
                        Text("new-person")
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .padding(7)
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .onTapGesture {
                        bigModel.authCurrentView = .Auth_NewUserView
                    }
                }.background(Color(UIColor.lightGray))
                
            }
        }.edgesIgnoringSafeArea(.bottom)
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
                
                    Alert(title: Text("delete \(bigModel.deletedPersonName)"), message: Text("delete-message"), primaryButton: .default(Text("no")) {
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
