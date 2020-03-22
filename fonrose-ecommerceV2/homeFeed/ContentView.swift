//
//  ContentView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 04/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var post: Feed
    
    var body: some View {
     
        VStack {
                   
           Image(post.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+16)
            
        }
        .listRowBackground(Color.black)
        .listRowInsets(EdgeInsets(top: -6, leading: -6, bottom: -6, trailing: -6))
        // Remark: Line separators have been removed using the 'UITableView.appearance().separatorColor = .clear'
        //         tip (cf  https://stackoverflow.com/a/57909325) executed in one of the AppDelegate.application(...)
        //         method
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        ContentView(post: downloadedPosts[0])
        ContentView(post: downloadedPosts[1])
        ContentView(post: downloadedPosts[2])
    }
}
}
#endif
