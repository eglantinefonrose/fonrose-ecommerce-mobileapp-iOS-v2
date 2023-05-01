//
//  Test-coordinate.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 07/07/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import CoreLocation
import SwiftUI

@available(iOS 14.0, *)
struct Test_coordinate: View {
    
    @State private var text: String = ""
    
    @available(iOS 14.0, *)
    var body: some View {
        
        Text("à")
        
    }
}

struct Test_coordinate_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            Test_coordinate()
        } else {
            // Fallback on earlier versions
        }
    }
}
