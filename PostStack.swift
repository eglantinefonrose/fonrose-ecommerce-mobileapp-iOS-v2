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
        
        VStack {
            //GeometryReader { geometry in
                Image(self.pictureNamee)
                    .resizable()
                    .padding(.vertical, -7)
                    .aspectRatio(contentMode: .fill)
                    .frame(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height, alignment: .leading)
                    //.clipped()
                //}
            } .padding(.leading, -UIScreen.main.bounds.width / 2)
        }
    }

struct PostStack_Previews: PreviewProvider {
    static var previews: some View {
        PostStack(pictureNamee: "video-promo2")
    }
}
