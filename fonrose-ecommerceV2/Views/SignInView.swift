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
struct LogInPhoneView: View {
    
    @Environment(\.colorScheme) var theColorScheme
    @EnvironmentObject var bigModel: BigModel
    @StateObject var loginModel: LoginViewModel = .init()
    @State var isTheFinalNumberCorrect: Bool = true
    
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
                    
                    BackButtonModel(text: "Sign in")
                        
                    Spacer()
                    
                    VStack {
                        
                        Spacer()
                        
                        VStack(spacing: 50) {
                            
                            Text("Sign in")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                            
                            VStack(spacing: 10) {
                                
                                HStack {
                                            
                                    TextField("", text: $bigModel.mobileNo)
                                        .padding(5)
                                        .placeholder(when: bigModel.mobileNo.isEmpty) {
                                            Text("Phone number").foregroundColor(.gray)
                                                .opacity(0.6)
                                                .padding(.horizontal, 5)
                                        }
                                        .onChange(of: bigModel.mobileNo) { newValue in
                                            isTheFinalNumberCorrect = true
                                        }
                                        
                                    
                                    Text("Get code")
                                        .foregroundColor(.blue)
                                        .padding(10)
                                        .font(.caption)
                                        .onTapGesture {
                                            
                                            if bigModel.mobileNo.isValidPhoneNumber() {
                                                bigModel.getOTPCode()
                                            } else {
                                                isTheFinalNumberCorrect = false
                                            }
                                            
                                        }
                                    
                                }.background(Color.white)
                                .cornerRadius(10)
                                
                                if !isTheFinalNumberCorrect {
                                    Text("The phone number is not valid, please verify your phone number.")
                                        .foregroundColor(.red)
                                }
                                
                                VStack {
                                    TextField("", text: $bigModel.otpCode)
                                        .padding(5)
                                        .placeholder(when: bigModel.otpCode.isEmpty) {
                                            Text("OTP Code")
                                                .foregroundColor(.gray)
                                                .opacity(0.6)
                                                .padding(.horizontal, 5)
                                        }
                                }.background(Color.white)
                                .cornerRadius(10)
                                
                            }
                            
                        }
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Text("Sign in or sign up")
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                                .padding(10)
                            Spacer()
                        }.background(Color.blue)
                        .cornerRadius(15)
                        .onTapGesture {
                            bigModel.verifyOTPCode()
                        }
                        
                    }
                    
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

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension String {
    func isValidPhoneNumber() -> Bool {
        let regEx = "^\\+(?:[0-9]?){6,14}[0-9]$"

        let phoneCheck = NSPredicate(format: "SELF MATCHES[c] %@", regEx)
        return phoneCheck.evaluate(with: self)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            LogInPhoneView()
                .environmentObject(BigModel())
        } else {
            // Fallback on earlier versions
        }
    }
}
