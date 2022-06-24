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
    //var model: ParcelInfos
    
    @available(iOS 14.0, *)
    var body: some View {
                                                
        if (self.bigModel.currentPopUpView == .Auth_SignInView) {
            SignInView()
        }
        
        if (self.bigModel.currentPopUpView == .Auth_SignUpView) {
            SignUpView()
        }
        
        if (self.bigModel.currentPopUpView == .Auth_LogInNewUserView) {
            LogInNewUser()
        }
        
        if (self.bigModel.currentPopUpView == .Auth_PersonPickerView) {
            PersonPickerView()
        }
        
        if (self.bigModel.currentPopUpView == .Auth_UserInfo) {
            UserInfo()
        }
        
    }
}
