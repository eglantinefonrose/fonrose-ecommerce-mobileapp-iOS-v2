//
//  AuthView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 23/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct AuthView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    @available(iOS 14.0, *)
    var body: some View {
                                                
        VStack {
                            
            if (self.bigModel.authCurrentView == .Auth_LogInEmailView) {
                LogInGoogleAppleView()
            }
                
            if (self.bigModel.authCurrentView == .Auth_SignUpView) {
                SignUpView()
            }
                
            if (self.bigModel.authCurrentView == .Auth_UserInfo) {
                UserInfo()
            }
            
            if (self.bigModel.authCurrentView == .Auth_PersonPickerView) {
                if bigModel.deletedPersonID == "" {
                    PersonPickerView()
                } else {
                    DeletePersonView()
                }
            }
            
            if (self.bigModel.authCurrentView == .Auth_NewUserView) {
                NewPersonView()
            }
            
            if (self.bigModel.authCurrentView == .Auth_DeleteScreen) {
                DeletePersonView()
            }
            
            if (self.bigModel.authCurrentView == .HelpView) {
                HelpView()
            }
            
            /*if (self.bigModel.authCurrentView == .Auth_EditPerson) {
                EditPersonView()
            }*/
            
        }
        
    }
}
