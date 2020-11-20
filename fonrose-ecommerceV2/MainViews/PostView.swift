//
//  PostView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 28/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import SwiftUI

struct PostView: View {

    @EnvironmentObject var bigModel: BigModel
    var picture: DressPictures

    var body: some View {
        
        HStack {
            
            PostStack(picture: picture, pictureNamee: picture.pictureName, ceellText: picture.cellText)
            
        }
    }
}

#if DEBUG
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(picture: LoadedPictures[1])
    }
}
#endif
