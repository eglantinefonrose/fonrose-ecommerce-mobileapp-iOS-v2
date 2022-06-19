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
    
    @EnvironmentObject var bigModel: BigModel
    @State var email = ""
    @State var password = ""
    let auth = Auth.auth()
    
    @available(iOS 14.0, *)
    var body: some View {
        
        VStack {
            
            Spacer()
            
            TextField("Email", text: $email)
                .background(Color(.secondarySystemBackground))
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .onChange(of: email) { newValue in
                    bigModel.changeEmailAdress(newValue)
                    print(bigModel.newEmail) }
        
        
            SecureField("Password", text: $password)
                .background(Color(.secondarySystemBackground))
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .onChange(of: password) { newValue in
                    bigModel.changePassword(newValue)
                    print(bigModel.newPassword)
                }
            
            Spacer()
            
            Text(email)
            Text(password)
            
            Button("Create Account") {
                
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
            
                bigModel.signUp(newUserEmail: email, newUserPassword: password)
                bigModel.newUserAccountEmail = email
                bigModel.newUserAccountPassword = password
                bigModel.currentview = .Auth_LogInNewUserView
                
            }
            
            Spacer()
            
        }.navigationTitle("Create Account")
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            SignUpView()
        } else {
            // Fallback on earlier versions
        }
    }
}
