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
    @State var isFinalEmailValid: Bool = true

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
                
                BackAuthButtonModel(text: "New person")
                
                Spacer()
                
                VStack {
                 
                 Spacer()
                 
                 HStack {
                                                     
                     Spacer()
                    
                     TextField("", text: $newPersonName)
                         .disableAutocorrection(true)
                         .autocapitalization(.none)
                         .placeholder(when: newPersonName.isEmpty) {
                             Text("Name")
                                 .foregroundColor(.gray)
                                 .opacity(0.6)
                                 .padding(.horizontal, 5)
                         }
                     
                 }
                 
                 Spacer()

                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                .cornerRadius(7)
                .frame(height: 30)
                
                Spacer()
                    .frame(height: 20)
                                
                VStack {
                 
                 Spacer()
                 
                 HStack {
                                                     
                     Spacer()
                    
                     if #available(iOS 14.0, *) {
                         TextField("", text: $newPersonEmail)
                             .disableAutocorrection(true)
                             .autocapitalization(.none)
                             .placeholder(when: newPersonEmail.isEmpty) {
                                 Text("Email")
                                     .foregroundColor(.gray)
                                     .opacity(0.6)
                                     .padding(.horizontal, 5)
                             }
                             .onChange(of: newPersonEmail) { newValue in
                                 isFinalEmailValid = true
                             }
                     } else {
                         // Fallback on earlier versions
                     }
                 }
                 
                 Spacer()

                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                .cornerRadius(7)
                .frame(height: 30)
                
                if !isFinalEmailValid {
                    Text("The email adress is not valid, please verify your email adress.")
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                if #available(iOS 14.0, *) {
                    
                    HStack {
                            
                        Spacer()
            
                        Text("Save")
                            .foregroundColor(newPersonName != "" && newPersonEmail != "" ? Color.white: Color.black)
                            .fontWeight(.semibold)

                        Spacer()
                        
                    }
                    .padding(5)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .onTapGesture {
                        
                        if newPersonEmail.isValideEmailAdress() {
                            Task {
                                
                                if newPersonEmail != "" && newPersonName != "" {
                                    
                                    if bigModel.isThereAPersonWithTheSameName(name: newPersonName) == true {
                                        alertTF(title: "Alert", message: "A person with the same name already exists, please choose another name", primaryTitle: "Ok") {
                                            
                                        }
                                    } else {
                                        
                                        try  db.collection("users").document("user\(auth.currentUser?.uid ?? "")").collection("persons").document().setData(from: BigModel.Person(email: newPersonEmail, name: newPersonName, orders: []))
                                        
                                        //setData(["email": newPersonEmail, "name": newPersonName])
                                        
                                        await bigModel.fetchPerson()
                                        bigModel.authCurrentView = .Auth_PersonPickerView
                                        bigModel.authLastViews.append(.Auth_NewUserView)
                                    }
                                }
                                
                            }
                        }
                        
                        else {
                            isFinalEmailValid = false
                        }
                        
                        
                    }
                } else {
                    // Fallback on earlier versions
                }
                
            }.padding(20)
            
        }
    }
}


struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewPersonView()
            .environmentObject(BigModel())
    }
}

extension String {
    func isValideEmailAdress() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailCheck = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailCheck.evaluate(with: self)
    }
}
