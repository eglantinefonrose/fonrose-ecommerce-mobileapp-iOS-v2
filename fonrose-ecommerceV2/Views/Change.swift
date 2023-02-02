//
//  Change.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 01/02/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct Change: View {
    
    @EnvironmentObject var bigModel: BigModel
    let db = Firestore.firestore()
    @Environment(\.colorScheme) var theColorScheme
    
    var body: some View {
        
        ZStack {
            
            if bigModel.signedIn {
                
                ChangeHome(newCurrentPersonName: bigModel.user.persons[bigModel.currentPersonIndex].name, newPersonEmail: bigModel.user.persons[bigModel.currentPersonIndex].email)
                
            }
            
        }
        
    }
    
}

struct ChangeHome: View {
        
    @EnvironmentObject var bigModel: BigModel
    let db = Firestore.firestore()
    @Environment(\.colorScheme) var theColorScheme
    @State var newCurrentPersonName: String
    @State var newPersonEmail: String
    var isShowing: Bool = true
    
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
                         
                         TextField("New name", text: $newCurrentPersonName)
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
                    
                    db.collection("users").document("user\(bigModel.user.id)").collection("persons").document(bigModel.currentPersonId).setData(["name": newCurrentPersonName, "email": newPersonEmail])
                    
                    db.collection("users").document("user\(bigModel.user.id)").collection("persons").document(bigModel.currentPersonId).getDocument { (document, error) in
                        
                        guard error == nil else {
                            print(error!.localizedDescription)
                            return
                        }
                        
                        if let document = document, document.exists {
                            let dbName = document.data()?["name"] as? String ?? ""
                            let dbEmail = document.data()?["email"] as? String ?? ""
                            bigModel.user.persons[bigModel.currentPersonIndex].name = dbName
                            bigModel.user.persons[bigModel.currentPersonIndex].email = dbEmail
                            
                        } else {
                            print("Document does not exist")
                        }
                        
                    }
                    
                    bigModel.fetchPerson()
                    bigModel.authCurrentView = .Auth_UserInfo
                    bigModel.authLastViews.append(.Auth_EditPerson)
                    
                }
            }
            
        }.opacity(isShowing ? 1 : 0)
        
    }
    
}


struct Change_Previews: PreviewProvider {
    static var previews: some View {
        Change()
    }
}
