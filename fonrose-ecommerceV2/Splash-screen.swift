//
//  Splash-screen.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 21/04/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI

struct Splash_screen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "flag.checkered")
                    .font(.system(size: 80))
                Text("ecommerce")
                    .font(.title)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.size = 0.9
                    opacity = 1
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isActive = true
            }
        }
    }
}

struct Splash_screen_Previews: PreviewProvider {
    static var previews: some View {
        Splash_screen()
    }
}
