//
//  UserInfo.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 22/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct UserInfo: View {
    
    var auth = Auth.auth()
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        VStack {
            Text(auth.currentUser?.email ?? "nil")
            Text(bigModel.persons[bigModel.currentPersonIndex].name)
            Text("change person")
                .onTapGesture {
                    bigModel.currentview = .Auth_PersonPickerView
                }
        }
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        UserInfo()
            .environmentObject(BigModel())
    }
}
