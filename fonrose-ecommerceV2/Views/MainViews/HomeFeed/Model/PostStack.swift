//
//  PostStack2.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 01/05/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI

struct PostStack: View {
    
    @EnvironmentObject var bigModel: BigModel
    var imageName: String
    var cellText: String
    
    var body: some View {
        
        ZStack {
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            Text(cellText)
                .frame(alignment: .center)
                .foregroundColor(.white)
                .font(.largeTitle)
            
        }
    }
}
