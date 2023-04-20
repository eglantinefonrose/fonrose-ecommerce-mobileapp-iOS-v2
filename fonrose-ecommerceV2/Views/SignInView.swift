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
    @StateObject var loginModel: LoginViewModel = .init()
    
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
                HStack {
                    
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
                            self.bigModel.currentview = .Home_homeFeed0
                        }
                    
                }.padding(20)
                Spacer()
            }
            
            VStack {
                
                Spacer()
                
                Text("Sign in")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Spacer()
                
                VStack(spacing: 10) {
                    
                    HStack {
                        TextField("Phone number", text: $bigModel.mobileNo)
                            //.keyboardType(.numberPad)
                            //.textContentType(.telephoneNumber)
                            .padding(5)
                        
                        Text("Get code")
                            .foregroundColor(.blue)
                            .padding(10)
                            .font(.caption)
                            .onTapGesture {
                                bigModel.getOTPCode()
                            }
                        
                    }.background(Color.white)
                    .cornerRadius(10)
                    
                    VStack {
                        TextField("OTP code", text: $bigModel.otpCode)
                            .padding(5)
                    }.background(Color.white)
                    .cornerRadius(10)
                    
                    Text("Sign in")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            bigModel.verifyOTPCode()
                        }
                    
                }
                
                Spacer()
                
                Text("No account ? Sign up here")
                    .fontWeight(.medium)
                    .underline()
                
            }.padding(20)
                
        }
        
    }
    
}

struct LogInView: View {
    
    @State var phoneNumber = ""
    @State var confirmationNumber = ""
    
    var body: some View {
        
        VStack {
            TextField("Phone number", text: $phoneNumber)
                .padding(5)
        }.background(Color.white)
        .cornerRadius(10)
        
        VStack {
            TextField("Confirmation number", text: $confirmationNumber)
                .padding(5)
        }.background(Color.white)
        .cornerRadius(10)
        
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
