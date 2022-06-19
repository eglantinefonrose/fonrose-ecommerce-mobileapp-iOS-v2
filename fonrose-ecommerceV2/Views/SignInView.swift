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
    
    @EnvironmentObject var bigModel: BigModel
    @State var email = ""
    @State var password = ""
    
    @available(iOS 14.0, *)
    var body: some View {
        
        NavigationView {
            
                VStack {
                    
                    Spacer()
                    
                        TextField("Email", text: $email)
                            .background(Color(.secondarySystemBackground))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                            .background(Color(.secondarySystemBackground))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Spacer()
                        
                        if bigModel.signedIn {
                            VStack {
                                Spacer()
                                Text(Auth.auth().currentUser?.uid ?? "nil")
                                Spacer()
                                Text("sign out")
                                    .onTapGesture {
                                        //bigModel.signOut()
                                    }
                                Spacer()
                            }
                        }
                    
                        Spacer()
                    
                        Text("Sign in")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                print("sign in")
                                guard !email.isEmpty, !password.isEmpty else {
                                    return
                                }
                                bigModel.signIn(email: email, password: password)
                            }
                    
                    Spacer()
                    
                    Text("Sign up")
                        .onTapGesture {
                            bigModel.currentview = ViewEnum.Auth_SignUpView
                        }
                    
                }
            
        }
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            SignInView()
        } else {
            // Fallback on earlier versions
        }
    }
}
