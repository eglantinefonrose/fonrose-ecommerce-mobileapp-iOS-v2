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
     
        VStack {
            
            Spacer()
            
            Text(bigModel.newEmail)
            Text(bigModel.newPassword)
            
            Spacer()
            
            Text("Modify email or password")
                .foregroundColor(.blue)
                .onTapGesture {
                    bigModel.currentview = .Auth_SignUpView
                }
            
            Spacer()
                .frame(height: 30)
            
            Text("Log in")
                .foregroundColor(.blue)
                .onTapGesture {
                    bigModel.currentview = .Home_homeFeed
                    guard !bigModel.newEmail.isEmpty, !bigModel.newPassword.isEmpty else {
                        return
                    }
                    
                    bigModel.newUserSignIn(email: bigModel.newEmail, password: bigModel.newPassword)
                }
            
            Spacer()
            
            Text(Auth.auth().currentUser?.uid ?? "nil")
            
            Spacer()
                .frame(height: 50)
            
        }
        
    }
    
}
