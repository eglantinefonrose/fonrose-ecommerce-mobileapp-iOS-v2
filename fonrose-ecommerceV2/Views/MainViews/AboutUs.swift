//
//  About_us.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 21/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import AVFoundation

struct AboutUs: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        Text("Back")
            .onTapGesture {
                print("back")
                bigModel.currentview = bigModel.lastViews.last ?? .AboutUsScreen
            }
        
    }
}

struct AboutUsView_Previews: PreviewProvider {
     
    static var previews: some View {
        AboutUs()
    }
}
