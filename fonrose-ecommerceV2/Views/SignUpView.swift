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
    
    @Environment(\.colorScheme) var theColorScheme
    @EnvironmentObject var bigModel: BigModel
    @State var email = ""
    @State var password = ""
    let auth = Auth.auth()
    
    @available(iOS 14.0, *)
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
                 
                BackButtonModel()
                
                Spacer()
                    
                VStack(spacing: 50) {
                    
                    Text("Sign Up")
                        .font(.system(size: 35, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                
                    
                    VStack(spacing: 20) {
                        
                        VStack {
                         
                         Spacer()
                         
                         HStack {
                                                             
                             Spacer()
                            
                             TextField("", text: $email)
                                 .disableAutocorrection(true)
                                 .autocapitalization(.none)
                                 .placeholder(when: email.isEmpty) {
                                     Text("Email")
                                         .foregroundColor(.gray)
                                         .opacity(0.6)
                                         .padding(.horizontal, 5)
                                 }
                         }
                         
                         Spacer()

                        }.background(theColorScheme == .dark ? Color.gray : Color.white)
                        .cornerRadius(7)
                        .frame(height: 30)
                        
                        VStack() {
                         
                         Spacer()
                         
                         HStack {
                                                             
                             Spacer()
                            
                             SecureField("", text: $password)
                                 .disableAutocorrection(true)
                                 .autocapitalization(.none)
                                 .placeholder(when: password.isEmpty) {
                                     Text("Password")
                                         .foregroundColor(.gray)
                                         .opacity(0.6)
                                         .padding(.horizontal, 5)
                                 }
                         }
                         
                         Spacer()

                        }.background(theColorScheme == .dark ? Color.gray : Color.white)
                        .cornerRadius(7)
                        .frame(height: 30)
                        
                    }
                    
                }
                
                Spacer()
                
                Text(bigModel.signOutErrorMessage)
                    .foregroundColor(.red)
                
                Spacer()
                
                VStack {
                                                
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
                        
                    }.frame(height: 35)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .onTapGesture {
                        self.bigModel.authLastViews.append(.Auth_SignUpView)
                        guard !email.isEmpty, !password.isEmpty else {
                            print("email or password empty")
                            return
                        }
                        bigModel.signUp(newUserEmail: email, newUserPassword: password)
                        bigModel.newUserAccountEmail = email
                        bigModel.newUserAccountPassword = password
                    }
                    
                }
                
            }.padding(20)
            
        }
        
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            SignUpView()
                .environmentObject(BigModel())
        } else {
            // Fallback on earlier versions
        }
    }
}
