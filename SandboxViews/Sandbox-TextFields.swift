//
//  Sandbox-TextFields.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 13/04/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI

struct Sandbox_TextFields: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isFirstTime = true

    var body: some View {
            
        if isFirstTime {
            Text("Bienvenue!")
                .onAppear {
                    // Vérifiez si la clé isFirstTime existe dans UserDefaults
                    if UserDefaults.standard.bool(forKey: "isFirstTime") {
                        isFirstTime = false
                    } else {
                        UserDefaults.standard.set(true, forKey: "isFirstTime")
                    }
                }
                .onDisappear {
                    // Réinitialisez la valeur isFirstTime lorsque la vue disparaît
                    isFirstTime = false
                }
        } else {
            Text("Bonjour!")
        }
        
    }
    
}

struct Sandbox_TextFields_Previews: PreviewProvider {
    static var previews: some View {
        Sandbox_TextFields()
    }
}
