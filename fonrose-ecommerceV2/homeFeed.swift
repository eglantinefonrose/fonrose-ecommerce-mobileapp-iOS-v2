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
        List {
            ContentView(post: downloadedPosts[0])
            ContentView(post: downloadedPosts[1])
            ContentView(post: downloadedPosts[2])
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}


#if DEBUG
struct homeFeed_Previews: PreviewProvider {
    static var previews: some View {
        homeFeed()
    }
}
#endif
