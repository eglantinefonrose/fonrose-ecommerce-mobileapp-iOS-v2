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
    var pictureNamee: String
    var ceellText: String
    var navigationName: ViewEnum
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        ZStack {
            
            Image(pictureNamee)
                .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            //Rectangle()
                //.foregroundColor(.blue)
            Text(ceellText)
                .frame(alignment: .center)
                .foregroundColor(.white)
                .font(.largeTitle)
            
        } .onTapGesture {
            self.bigModel.currentview = navigationName
        }
        
    }
}
