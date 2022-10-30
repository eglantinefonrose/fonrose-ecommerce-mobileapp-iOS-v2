//
//  SignInView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 19/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth

@available(iOS 14.0, *)
struct SignInView: View {
    
    @Environment(\.colorScheme) var theColorScheme
    @EnvironmentObject var bigModel: BigModel
    @State var email = ""
    @State var password = ""
    
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
                    
                }
                
                Spacer()
                    
                if !email.isEmpty, !password.isEmpty {
                    Text("Sign in")
                        .font(.system(size: 35, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                } else {
                    Text("Sign in")
                        .font(.system(size: 35, weight: .bold, design: .default))
                        .foregroundColor(Color.black)
                        .fontWeight(.semibold)
                }
            
                Spacer()
                
                VStack {
                    
                    TextFieldModel()
                    
                    SecureFieldModel()
                    
                }
                
                Spacer()
                
                Text(bigModel.signInErrorMessage)
                    .foregroundColor(.red)
                
                Spacer()
                
                VStack {
                                        
                    VStack {
                            
                        HStack {
                                
                            Spacer()
                                
                            HStack {
                                
                                Spacer()
                                
                                if !email.isEmpty, !password.isEmpty {
                                    Text("Sign in")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold)
                                } else {
                                    Text("Sign in")
                                        .foregroundColor(Color.black)
                                        .fontWeight(.semibold)
                                }

                                Spacer()
                            
                            }
                            .frame(width: 150)
                            .cornerRadius(5)
                            
                            Spacer()
                            
                            }.frame(width: UIScreen.main.bounds.width - 50, height: 35)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .onTapGesture {
                                print("sign in")
                                guard !email.isEmpty, !password.isEmpty else {
                                    return
                                }
                                bigModel.signIn(email: email, password: password)
                                self.bigModel.authLastViews.append(.Auth_SignInView)
                            }
                    
                        Spacer()
                            .frame(height: 10)
                    
                    }
            
                    VStack {
                        
                        HStack {
                                
                            Spacer()
                                
                            HStack {
                                
                                Spacer()
                                Text("Sign up")
                                    .foregroundColor(.white)
                                    .fontWeight(.medium)
                                Spacer()
                            
                            }.background(Color(UIColor.lightGray))
                            .frame(width: 150)
                            .cornerRadius(5)
                            
                            Spacer()
                            
                        }.frame(width: UIScreen.main.bounds.width - 50, height: 35)
                        .background(Color(UIColor.lightGray))
                        .cornerRadius(15)
                        .onTapGesture {
                            self.bigModel.authCurrentView = .Auth_SignUpView
                            self.bigModel.authLastViews.append(.Auth_SignInView)
                        }
                
                    }
                    
                }
                
            }
            
        }
        
    }
}

struct TextFieldModel: View {
    
    @State var text: String = ""
    @Environment(\.colorScheme) var theColorScheme
    
    var body: some View {

        VStack {
         
         Spacer()
         
         HStack {
                                             
             Spacer()
            
             TextField("Email", text: $text)
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

struct SecureFieldModel: View {
    
    @State var text: String = ""
    @Environment(\.colorScheme) var theColorScheme
    
    var body: some View {

        VStack {
         
         Spacer()
         
         HStack {
                                             
             Spacer()
            
             SecureField("Password", text: $text)
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            SignInView()
                .environmentObject(BigModel())
        } else {
            // Fallback on earlier versions
        }
    }
}
