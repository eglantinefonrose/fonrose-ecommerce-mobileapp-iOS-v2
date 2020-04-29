//
//  homeFeed.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 20/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import SwiftUI

struct homeFeed: View {
    
    var test: MeasurementInfos
        
    var body: some View {
        
        NavigationView {
            VStack {
                List(LoadedPictures) { picture in
                    NavigationLink(destination: DetailedView(picture: picture, test: self.test)) {
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
        homeFeed(test: Measurement[0])
            .environmentObject(UserData())
    }
}
#endif


