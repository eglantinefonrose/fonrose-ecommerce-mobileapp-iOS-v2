//
//  PostStack2.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 01/05/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI

struct PostStack: View {
    
    var picture: DressPictures
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        ZStack {
            
            Image(picture.pictureName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            Text(picture.cellText)
                .frame(alignment: .center)
                .foregroundColor(.white)
                .font(.largeTitle)
            
        } .onTapGesture {
            
            self.bigModel.currentview = picture.navigationViewName
            self.bigModel.lastViews.append(.Home_homeFeed)
            print("append")
            
            if !bigModel.showMenu {
            } else {
                bigModel.showMenu.toggle()
            }
        }
        
    }
}
