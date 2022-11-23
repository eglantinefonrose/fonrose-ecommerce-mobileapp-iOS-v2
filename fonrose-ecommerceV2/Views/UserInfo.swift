//
//  UserInfo.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 22/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct UserInfo: View {
    
    var auth = Auth.auth()
    @EnvironmentObject var bigModel: BigModel
    @State var isChangeViewShowed: Bool = false
    @State var newPersonName: String = ""
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
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
                    
                    Text("User Info")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "house")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.bigModel.currentview = .Home_homeFeed
                        }
                    
                }.padding(20)
                        
                Spacer()
                
                VStack {
                    
                    Spacer()
                    
                    if #available(iOS 14.0, *) {
                        if #available(iOS 16.0, *) {
                            if bigModel.user.id != "" {
                                Text(bigModel.user.persons[bigModel.currentPersonIndex].name)
                                    .font(.title2)
                                    .padding(5)
                                    .fontWeight(.semibold)
                            } else {
                                
                            }
                        } else {
                            // Fallback on earlier versions
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    HStack {
                        
                        Image(systemName: "pencil.line")
                            .foregroundColor(.blue)
                            .font(.callout)
                        
                        Text("Edit...")
                            .foregroundColor(.blue)
                            .font(.caption)
                    }.onTapGesture {
                        isChangeViewShowed = true
                    }
                                        
                    VStack {
                        HStack {
                            Image(systemName: "pencil.and.outline")
                                .foregroundColor(.blue)
                            Text("See my measurements")
                                .foregroundColor(.blue)
                                .padding(10)
                        }
                        
                        HStack {
                            Image(systemName: "mappin.circle")
                                .foregroundColor(.blue)
                            Text("See my location informations")
                                .foregroundColor(.blue)
                                .padding(10)
                        }
                    }.padding(20)
                        
                Spacer()
                    
                }
                
                /*if bigModel.user.id != "" {
                    Text("Connect with \(bigModel.user.email)")
                }*/
            
                VStack {
                    
                    HStack {
                        Image(systemName: "person.fill")
                        Text("Change of person")
                            .padding(5)
                    }.onTapGesture {
                        bigModel.authCurrentView = .Auth_PersonPickerView
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        Spacer()
                            Text("Sign out")
                                .foregroundColor(Color.white)
                                .fontWeight(.medium)
                                .padding(7)
                        Spacer()
                    }.background(Color(UIColor.lightGray))
                    .cornerRadius(15)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                }
                
            }
            
            Change(isShowing: $isChangeViewShowed)
                
        }
    }
}

struct Change: View {
    
    @EnvironmentObject var bigModel: BigModel
    let db = Firestore.firestore()
    @Environment(\.colorScheme) var theColorScheme
    @Binding var isShowing: Bool
    
    var body: some View {
        
        ZStack {
            
            ChangeHome(newPersonName: bigModel.user.persons[bigModel.currentPersonIndex].name, newPersonEmail: bigModel.user.persons[bigModel.currentPersonIndex].email)
            
        }.opacity(isShowing ? 1 : 0)
        
    }
    
}

struct ChangeHome: View {
        
    @EnvironmentObject var bigModel: BigModel
    let db = Firestore.firestore()
    @Environment(\.colorScheme) var theColorScheme
    @State var newPersonName: String
    @State var newPersonEmail: String
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                VStack {
                        
                    VStack {
                     
                     Spacer()
                     
                     HStack {
                                                         
                         Spacer()
                         
                         TextField("New name", text: $newPersonName)
                             .disableAutocorrection(true)
                             .autocapitalization(.none)
                     }
                     
                     Spacer()

                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                    .cornerRadius(7)
                    .frame(height: 30)
                    .padding(5)
                        
                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                .cornerRadius(7)
                .frame(height: 30)
                .padding(10)
                                        
                VStack {
                    
                    VStack {
                     
                     Spacer()
                     
                     HStack {
                                                         
                         Spacer()
                         
                         TextField("New email", text: $newPersonEmail)
                             .disableAutocorrection(true)
                             .autocapitalization(.none)
                     }
                     
                     Spacer()

                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                    .cornerRadius(7)
                    .frame(height: 30)
                    .padding(5)
                    
                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                .cornerRadius(7)
                .frame(height: 30)
                .padding(10)
                
            }
            
            VStack {
                
                Spacer()
                
                HStack {
                    Spacer()
                        Text("Change")
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                            .padding(7)
                    Spacer()
                }.background(Color.blue)
                .cornerRadius(15)
                .padding(20)
                .onTapGesture {
                    
                    db.collection("users").document("user\(bigModel.user.id)").collection("persons").document(bigModel.currentPersonId).setData(["name": newPersonName, "email": newPersonEmail])
                    
                    db.collection("users").document("user\(bigModel.user.id)").collection("persons").document(bigModel.currentPersonId).getDocument { (document, error) in
                        
                        guard error == nil else {
                            print(error!.localizedDescription)
                            return
                        }
                        
                        if let document = document, document.exists {
                            let dbName = document.data()?["name"] as? String ?? ""
                            
                            bigModel.user.persons[bigModel.currentPersonIndex].name = dbName
                            
                        } else {
                            print("Document does not exist")
                        }
                        
                    }
                    
                    bigModel.fetchPerson()
                    
                }
            }
            
        }
        
    }
    
}

struct TextFieldChangeModel: View {
    
    var title: String
    @State var text: String
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

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        UserInfo()
            .environmentObject(BigModel(shouldInjectMockedData: true))
    }
}
