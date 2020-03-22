//
//  DressController.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import SwiftUI

struct View1: View {
    var body: some View {
        
        ScrollView() {
        HStack {
            
            Image("video-promo2")
                .resizable()
                .frame(width: 200, height: UIScreen.main.bounds.width)
            
            Image("Screenshot")
                .resizable()
                .frame(width: 200, height: UIScreen.main.bounds.width)
            
            Image("About us")
                .resizable()
                .frame(width: 200, height: UIScreen.main.bounds.width)
            
        }
    
    }
        
    }
}

#if DEBUG
struct DressController_Previews: PreviewProvider {
    static var previews: some View {
        View1()
    }
}
#endif
