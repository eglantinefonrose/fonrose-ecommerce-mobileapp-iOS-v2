//
//  Log-In-screen.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 07/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct LogInScreen: View {
    var body: some View {
        
        VStack {
            
            Spacer()
                .frame(height: 75)
            
            Text("Log-in")
                .foregroundColor(.white)
                .font(.system(.largeTitle, design: .default))
            
            VStack {
                Spacer()
                
                Image("React-Google-Login")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
            }
            
            VStack {
                Image("logo-fonrose-vectoriel noir2 copy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
            }
            
            Spacer()
            .frame(height: 75)
            
        }.background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct Log_In_screen_Previews: PreviewProvider {
    static var previews: some View {
        LogInScreen()
    }
}
