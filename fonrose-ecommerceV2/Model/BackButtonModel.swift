//
//  BackButtonModel.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 23/04/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI

struct BackButtonModel: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        HStack {
            
            Text("Back")
                .foregroundColor(Color.blue)
                .fontWeight(.semibold)
                .onTapGesture {
                    if !self.bigModel.lastViews.isEmpty {
                        print("back")
                        self.bigModel.currentview = self.bigModel.lastViews.last ?? .AboutUsScreen
                        self.bigModel.lastViews.removeLast()
                        print("previous View = \(String(describing: self.bigModel.lastViews.last))")
                    } else { print("array empty") }
                }
            
            Spacer()
            
            Image(systemName: "house")
                .foregroundColor(Color.blue)
                .onTapGesture {
                    self.bigModel.currentview = .Home_homeFeed0
                }
            
        }
        Spacer()
    }
}

struct BackButtonModel_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonModel()
    }
}
