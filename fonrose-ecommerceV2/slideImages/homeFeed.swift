//
//  homeFeed.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 20/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import SwiftUI

struct homeFeed: View {
    
    var body: some View {
        
        NavigationView {
            VStack {
                List(LoadedPictures) { picture in
                    NavigationLink(destination: DetailedView(name: picture.cellText)) {
                        PostView(picture: picture)
                    }
                }.buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, -20)
                    .frame(width: 416)
                    .edgesIgnoringSafeArea(.all)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
        }
    }
}


#if DEBUG
struct homeFeed_Previews: PreviewProvider {
    static var previews: some View {
        homeFeed()
    }
}
#endif


