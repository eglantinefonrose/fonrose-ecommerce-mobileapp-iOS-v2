
//
//  SignInView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 19/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import AuthenticationServices

@available(iOS 14.0, *)
struct LogInAppleView: View {
    
    @Environment(\.colorScheme) var theColorScheme
    @EnvironmentObject var bigModel: BigModel
    
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
                
                BackButtonModel(text: "sign-in", viewName: .Auth_AuthView)
                
                Spacer()
                                                    
                ZStack {
                    
                    VStack {
                        HStack {
                            Text("sign-in")
                                .font(.system(size: 50, weight: .semibold))
                            Spacer()
                        }
                        Spacer()
                    }
                                                                            
                    VStack {
                        
                        SignInWithAppleButton(.signIn) { request in
                            request.requestedScopes = [.fullName, .email]
                        } onCompletion: { result in
                            switch result {
                                case .success(let authResults):
                                    if let credential = authResults.credential as? ASAuthorizationAppleIDCredential {
                                        Task {
                                            print("credential.user = \(credential.user)")
                                            await bigModel.signInWithApple(inputID: credential.user, inputEmail: credential.email ?? "")
                                        }
                                    }
                                case .failure(let error):
                                    print("Authorisation failed: \(error.localizedDescription)")
                            }
                        }.frame(height: 50)
                        
                    }
                    
                    Spacer()
                    
                }.padding(20)
                
                Spacer()
                
            }.padding(20)
            
        }
        
    }
}

struct LogInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            LogInAppleView()
                .environmentObject(BigModel(shouldInjectMockedData: true))
        } else {
            // Fallback on earlier versions
        }
    }
}

