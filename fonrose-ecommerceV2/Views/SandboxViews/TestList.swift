//
//  TestList.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 18/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI

struct TestList: View {
    var body: some View {
        
        if #available(iOS 14.0, *) {
            ScrollViewReader { proxy in
                VStack {
                    
                    Button("Jump to #50") {
                        proxy.scrollTo(3)
                    }
                    
                    List {
                        ForEach(dressPictures) { picture in
                            PostView(picture: picture)
                                .id(picture.id)
                        }
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
}

struct TestList_Previews: PreviewProvider {
    static var previews: some View {
        TestList()
    }
}
