//
//  BackButtonModel.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 23/04/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI

@available(iOS 15.0, *)
struct BackButtonModel: View {
    
    @EnvironmentObject var bigModel: BigModel
    var text: String
    
    var body: some View {
        HStack {
            
            Text("back")
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
            
            Text(LocalizedStringKey(text))
                .bold()
            
            Spacer()
            
            Image(systemName: "house")
                .foregroundColor(Color.blue)
                .onTapGesture {
                    self.bigModel.currentview = .Home_homeFeed0
                }
            
        }
    }
}

struct BackAuthButtonModel: View {
    
    @EnvironmentObject var bigModel: BigModel
    var text: String
    
    var body: some View {
        HStack {
            
            Text("Back")
                .foregroundColor(Color.blue)
                .fontWeight(.semibold)
                .onTapGesture {
                    if !self.bigModel.authLastViews.isEmpty {
                        print("back")
                        self.bigModel.authCurrentView = self.bigModel.authLastViews.last ?? .AboutUsScreen
                        self.bigModel.authLastViews.removeLast()
                        print("previous View = \(String(describing: self.bigModel.authLastViews.last))")
                    } else { print("array empty") }
                }
            
            Spacer()
            
            Text(text)
                .bold()
            
            Spacer()
            
            Image(systemName: "house")
                .foregroundColor(Color.blue)
                .onTapGesture {
                    self.bigModel.currentview = .Home_homeFeed0
                }
            
        }
    }
}

struct BackButtonModel_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonModel(text: "test")
    }
}
