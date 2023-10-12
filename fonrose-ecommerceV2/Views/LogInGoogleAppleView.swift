
//
//  SignInView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 19/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift

@available(iOS 14.0, *)
struct LogInGoogleAppleView: View {
    
    @Environment(\.colorScheme) var theColorScheme
    @EnvironmentObject var bigModel: BigModel
    @StateObject var loginModel: LoginViewModel = .init()
    var textContentType: UITextContentType!
    @State var email = ""
    @State var password = ""
    var passwordTextField: UITextField = UITextField()
    
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
                
                BackButtonModel(text: "Sign in")
                
                Spacer()
                    
                VStack {
                        
                        SignInWithAppleButton { (request) in
                            
                            bigModel.nonce = randomNonceString(length: 32)
                            request.requestedScopes = [.email,.fullName]
                            
                        } onCompletion: { (result) in
                            
                            switch result {
                                case .success(let user):
                                guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                    print("error with firebase")
                                    return
                                }
                                bigModel.authentificateWithApple(credential: credential)
                                bigModel.updateUserInfos()
                                
                                print("success")
                                // do Login With Firebase..
                                case .failure (let error):
                                    print (error.localizedDescription)
                            }
                            
                        }.frame(height: 40)
                        
                        GoogleSignInButton {
                            
                            guard let clientID = FirebaseApp.app()?.options.clientID else { return }

                            // Create Google Sign In configuration object.
                            let config = GIDConfiguration(clientID: clientID)
                            GIDSignIn.sharedInstance.configuration = config

                            // Start the sign in flow!
                            GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
                                
                                guard error == nil else {
                                    return
                                }

                                guard let user = result?.user,
                                    let idToken = user.idToken?.tokenString
                                else {
                                      return
                                }

                                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                                    
                                Auth.auth().signIn(with: credential) { result, error in
                                    
                                    guard error == nil else {
                                        return
                                    }
                                    
                                    bigModel.updateUserInfos()
                                    
                                }
                            }
                        }
                    
                    /*HStack {
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
                        Task {
                            print("click")
                            bigModel.signIn(email: email, password: password)
                            self.bigModel.authLastViews.append(.Auth_LogInEmailView)
                            if bigModel.signedIn {
                                bigModel.currentview = .Auth_PersonPickerView
                            }
                        }
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
                        self.bigModel.authLastViews.append(.Auth_LogInEmailView)
                    }
                                                                        
                    Spacer()
                        .frame(height: 10)*/
                    
                }.padding(20)
                
                Spacer()
                
            }.padding(20)
            
        }
        
    }
}

/*struct TextFieldModel: View {
    
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
}*/

struct LogInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            LogInGoogleAppleView()
                .environmentObject(BigModel(shouldInjectMockedData: true))
        } else {
            // Fallback on earlier versions
        }
    }
}

