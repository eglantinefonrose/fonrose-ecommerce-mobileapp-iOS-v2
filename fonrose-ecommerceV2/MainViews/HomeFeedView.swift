//
//  homeFeed.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 20/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import SwiftUI

struct HomeFeedView: View {
    
    @EnvironmentObject var bigModel: BigModel
    var model: MeasurementInfos

    var body: some View {
        
            VStack {
                List(LoadedPictures) { picture in
                    PostView(picture: picture)
                }.buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, -15)
                    .frame(width: UIScreen.main.bounds.width)
                    .edgesIgnoringSafeArea(.all)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
        }
            

    }

#if DEBUG
struct homeFeed_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedView(model: Measurement[0])
            .environmentObject(UserData())
    }
        
}
#endif


