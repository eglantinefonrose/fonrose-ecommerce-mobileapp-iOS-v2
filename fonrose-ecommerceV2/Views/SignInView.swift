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
    var textContentType: UITextContentType!
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
                    .frame(height: 10)
                
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
                    
                Text("Sign in")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .foregroundColor(Color.white)
                    .fontWeight(.semibold)
            
                Spacer()
                
                VStack {
                    
                    VStack {
                     
                     Spacer()
                     
                     HStack {
                                                         
                         Spacer()
                         
                         TextField("Email", text: $email)
                             .textContentType(.URL)
                             .disableAutocorrection(true)
                             .autocapitalization(.none)
                             .keyboardType(UIKeyboardType.emailAddress)
                     }
                     
                     Spacer()

                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                    .cornerRadius(7)
                    .frame(height: 30)
                    .padding(10)
                    
                    VStack {
                     
                     Spacer()
                     
                     HStack {
                                                         
                         Spacer()
                         
                         SecureField("Password", text: $password)
                             .textContentType(.password)
                             .disableAutocorrection(true)
                             .autocapitalization(.none)
                     }
                     
                     Spacer()

                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                    .cornerRadius(7)
                    .frame(height: 30)
                    .padding(10)
                    
                }
                
                Spacer()
                
                Text(bigModel.signInErrorMessage)
                    .foregroundColor(.red)
                
                Spacer()
                
                VStack {
                    
                    HStack {
                        Spacer()
                        if !email.isEmpty, !password.isEmpty {
                            Text("Sign in")
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                                .padding(7)
                        } else {
                            Text("Sign in")
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                                .padding(7)
                        }
                        Spacer()
                    }.background(Color.blue)
                    .cornerRadius(15)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .onTapGesture {
                        print("click")
                        bigModel.signIn(email: email, password: password)
                        self.bigModel.authLastViews.append(.Auth_SignInView)
                    }
                    
                    HStack {
                        Spacer()
                            Text("Sign up")
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                                .padding(7)
                        Spacer()
                    }.background(Color(UIColor.lightGray))
                    .cornerRadius(15)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .onTapGesture {
                        self.bigModel.authCurrentView = .Auth_SignUpView
                        self.bigModel.authLastViews.append(.Auth_SignInView)
                    }
                                                                        
                    Spacer()
                        .frame(height: 10)
                    
                }
                
            }
            
        }
        
    }
}

struct TextFieldModel: View {
    
    var title: String
    @State var text: String = ""
    @Environment(\.colorScheme) var theColorScheme
    var textContentType: UITextContentType!
    
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

struct SecureFieldModel: View {
    
    var title: String
    @State var text: String
    @Environment(\.colorScheme) var theColorScheme
    
    var body: some View {

        VStack {
         
         Spacer()
         
         HStack {
                                             
             Spacer()
            
             SecureField(title, text: $text)
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
