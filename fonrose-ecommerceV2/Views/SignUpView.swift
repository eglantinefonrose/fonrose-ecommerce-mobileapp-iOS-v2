//
//  SignUpView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 19/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth

@available(iOS 14.0, *)
struct SignUpView: View {
    
    @EnvironmentObject var bigModel: BigModel
    @State var email = ""
    @State var password = ""
    let auth = Auth.auth()
    
    @available(iOS 14.0, *)
    var body: some View {
        
        ZStack {
            
            VStack {
                    
                Spacer()
                
                VStack {
                    
                    VStack {
                     
                     Spacer()
                     
                     HStack {
                                                         
                         Spacer()
                        
                        TextField("Email", text: $email)
                         .background(Color(.secondarySystemBackground))
                         .disableAutocorrection(true)
                         .autocapitalization(.none)
                         .onChange(of: email) { newValue in
                             bigModel.changeEmailAdress(newValue)
                             print(bigModel.newEmail) }
                     }.background(Color.white)
                     
                     Spacer()

                    }.background(Color.white)
                    .cornerRadius(7)
                    .frame(height: 30)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    VStack {
                     
                     Spacer()
                     
                     HStack {
                                                         
                         Spacer()
                        
                         SecureField("Password", text: $password)
                             .background(Color.white)
                             .disableAutocorrection(true)
                             .autocapitalization(.none)
                            .onChange(of: password) { newValue in
                                bigModel.changePassword(newValue)
                                print(bigModel.newPassword)
                            }
                     }
                     
                     Spacer()

                    }.background(Color.white)
                    .cornerRadius(7)
                    .frame(height: 30)
                    
                }
                    
                    Spacer()
                    
                    VStack {
                        
                            Button(action: {
                                
                                self.bigModel.lastViews.append(.Auth_SignUpView)
                                guard !email.isEmpty, !password.isEmpty else {
                                    return
                                }
                                bigModel.signUp(newUserEmail: email, newUserPassword: password)
                                bigModel.newUserAccountEmail = email
                                bigModel.newUserAccountPassword = password
                                
                            }) {
                            //Spacer()
                                
                            HStack {
                                    
                                Spacer()
                                    
                                HStack {
                                    
                                    Spacer()
                                    Text("Create account")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold)
                                    Spacer()
                                
                                }
                                .frame(width: 150)
                                .cornerRadius(5)
                                
                                Spacer()
                                
                            }.frame(width: UIScreen.main.bounds.width - 50, height: 35)
                            .background(Color.blue)
                            .cornerRadius(15)
                            
                        //Spacer()
                        }
                        
                        Spacer()
                            .frame(height: 50)
                        
                    }
                            
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
                            if !self.bigModel.lastViews.isEmpty {
                                print("back")
                                self.bigModel.currentview = self.bigModel.lastViews.last ?? .AboutUsScreen
                                self.bigModel.lastViews.removeLast()
                                print("previous View = \(String(describing: self.bigModel.lastViews.last))")
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
                    .frame(height: UIScreen.main.bounds.height/10)
                
                
                Text("Sign Up")
                        .font(.system(size: 35, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                        .frame(width: UIScreen.main.bounds.width)
                
                Spacer()
                
            }
            
        }
        
    }
}

/*
 
 @EnvironmentObject var bigModel: BigModel
 @State var email = ""
 @State var password = ""
 let auth = Auth.auth()
 
 var body: some View {
     
     VStack {
         
         Spacer()
         
         TextField("Email", text: $email)
             .background(Color(.secondarySystemBackground))
             .disableAutocorrection(true)
             .autocapitalization(.none)
             .onChange(of: email) { newValue in
                 bigModel.changeEmailAdress(newValue)
                 print(bigModel.newEmail) }
         
         SecureField("Password", text: $password)
             .background(Color(.secondarySystemBackground))
             .disableAutocorrection(true)
             .autocapitalization(.none)
             .onChange(of: password) { newValue in
                 bigModel.changePassword(newValue)
                 print(bigModel.newPassword)
             }
         
         Spacer()
         
         Text(email)
         Text(password)
         
         Button("Create Account") {
             
             guard !email.isEmpty, !password.isEmpty else {
                 return
             }
         
             bigModel.signUp(newUserEmail: email, newUserPassword: password)
             bigModel.newUserAccountEmail = email
             bigModel.newUserAccountPassword = password
             bigModel.currentView = ViewEnum.LogInNewUserView
             
         }
         
         Spacer()
         
     }.navigationTitle("Create Account")
     
 }
 
 */

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            SignUpView()
        } else {
            // Fallback on earlier versions
        }
    }
}
