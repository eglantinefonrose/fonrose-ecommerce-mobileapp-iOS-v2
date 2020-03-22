//
//  PostStack.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 19/03/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct PostStack: View {
    
    let pictureNamee: String
    
    var body: some View {
        HStack {
            Image(pictureNamee)
                .resizable()
                .aspectRatio(contentMode: .fill)
            
        }
    }
}

struct PostStack_Previews: PreviewProvider {
    static var previews: some View {
        PostStack(pictureNamee: "video-promo2")
    }
}
