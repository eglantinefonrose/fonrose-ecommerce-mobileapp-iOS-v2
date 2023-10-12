
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
struct LogInEmailView: View {
    
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
                            self.bigModel.currentview = .Home_homeFeed0
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
                             .textContentType(.emailAddress)
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
                             .keyboardType(.asciiCapable)
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
                
                /*Text(bigModel.signInErrorMessage)
                    .foregroundColor(.red)
                
                Spacer()*/
                
                VStack {
                    
                    HStack(spacing: 10) {
                        
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
                            bigModel.updateUserInfos()

                            }
                            
                        }
                        
                        
                        
                    }.padding(.horizontal, 20)
                    
                    
                    
                    
                    
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
                        .frame(height: 10)
                    
                }
                
            }
            
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
            LogInEmailView()
                .environmentObject(BigModel(shouldInjectMockedData: true))
        } else {
            // Fallback on earlier versions
        }
    }
}

