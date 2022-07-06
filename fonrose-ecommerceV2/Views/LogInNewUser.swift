//
//  LogInNewUser.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 19/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct LogInNewUser: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
         
         ZStack {
                         
            HStack {
                
                Spacer()
                
                VStack {
                         
                    Spacer()
                    
                    VStack {
                        
                        Spacer()
                        
                        Text("email : \(bigModel.newEmail)")
                            .foregroundColor(.white)
                        
                        Spacer()
                            .frame(height: 30)
                        
                        Text("password : \(bigModel.newPassword)")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("Modify email or password")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                bigModel.currentview = .Auth_SignUpView
                            }
                        
                        VStack {
                            
                            Spacer()
                                .frame(height: 30)
                            
                            Text("Log in")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    bigModel.lastViews.append(.Auth_LogInNewUserView)
                                    bigModel.currentview = .Auth_PersonPickerView
                                    guard !bigModel.newEmail.isEmpty, !bigModel.newPassword.isEmpty else {
                                        return
                                    }
                                    
                                    bigModel.newUserSignIn(email: bigModel.newEmail, password: bigModel.newPassword)
                                }
                                                        
                        }
                        
                        Text(Auth.auth().currentUser?.uid ?? "nil")
                        
                        Spacer()
                            .frame(height: 50)
                        
                    }
                    
                    Spacer()
                                 
                 }
                
                Spacer()
                
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
                                 self.bigModel.authCurrentView = self.bigModel.lastViews.last ?? .AboutUsScreen
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

struct LogInNewUser_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            LogInNewUser()
                .environmentObject(BigModel())
        } else {
            // Fallback on earlier versions
        }
    }
}
