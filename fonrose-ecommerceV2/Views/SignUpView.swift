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
                    
                }
                
                Spacer()
                    
                Text("Sign Up")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .foregroundColor(Color.white)
            
                Spacer()
                
                VStack {
                    
                    TextFieldEmail(email: email)
                    
                    SecureFieldModel()
                    
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
                        
                    }.frame(width: UIScreen.main.bounds.width - 50, height: 35)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .onTapGesture {
                        self.bigModel.authLastViews.append(.Auth_SignUpView)
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        bigModel.signUp(newUserEmail: email, newUserPassword: password)
                        bigModel.newUserAccountEmail = email
                        bigModel.newUserAccountPassword = password
                    }
                    
                }
                
            }
            
        }
        
    }
}

struct TextFieldEmail: View {
    
    @Environment(\.colorScheme) var theColorScheme
    @State var email: String
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        VStack {
         Spacer()
         HStack {
            Spacer()
             if #available(iOS 14.0, *) {
                 TextField("Email", text: $email)
                     .disableAutocorrection(true)
                     .autocapitalization(.none)
                     .onChange(of: email) { newValue in
                         bigModel.changeEmailAdress(newValue)
                     }
             } else {
                 // Fallback on earlier versions
             }
         }
         Spacer()
        }.background(theColorScheme == .dark ? Color.gray : Color.white)
        .cornerRadius(7)
        .frame(height: 30)
        .padding(10)
    }
}

struct SecureFieldPassword: View {
    
    @Environment(\.colorScheme) var theColorScheme
    @State var password: String
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        VStack {
         
         Spacer()
         
         HStack {
                                             
             Spacer()
            
             if #available(iOS 14.0, *) {
                 SecureField("Password", text: $password)
                     .disableAutocorrection(true)
                     .autocapitalization(.none)
                     .onChange(of: password) { newValue in
                         bigModel.changePassword(newValue)
                     }
             } else {
                 // Fallback on earlier versions
             }
         }
         
         Spacer()

        }.background(theColorScheme == .dark ? Color.gray : Color.white)
        .cornerRadius(7)
        .frame(height: 30)
        .padding(10)
        
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
