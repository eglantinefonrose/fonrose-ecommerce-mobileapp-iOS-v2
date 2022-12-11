//
//  SignInSandbox.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 21/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI

struct SignInSandbox: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        ZStack {
            VStack {
                
                Text("Hello")
                    .foregroundColor(.white)
                
                }.background(Color.black)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    
                    Spacer()
                        .frame(width: 20)
                    
                    
                    Text("Back")
                        .foregroundColor(Color.blue)
                        .fontWeight(.semibold)
                        .onTapGesture {
                            
                        }
                    
                    Spacer()
                    
                    Image(systemName: "house")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.bigModel.currentview = .Home_homeFeed0
                        }
                    
                    Spacer()
                        .frame(width: 20)
                    
                }.frame(width: UIScreen.main.bounds.width)
                
                Spacer()
                
            }
            
        }
    }
}

struct SignInSandbox_Previews: PreviewProvider {
    static var previews: some View {
        SignInSandbox()
    }
}
