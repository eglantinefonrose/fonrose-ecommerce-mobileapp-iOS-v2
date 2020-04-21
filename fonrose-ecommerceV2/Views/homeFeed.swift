//
//  homeFeed.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 20/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import SwiftUI

struct homeFeed: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        NavigationView {
            VStack {
                List(userData.posts) { picture in
                    NavigationLink(destination: DetailedView(picture: picture)) {
                PostView(picture: picture)
                    }
                }.buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, -15)
                    .frame(width: UIScreen.main.bounds.width)
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
            .environmentObject(UserData())
    }
}
#endif

