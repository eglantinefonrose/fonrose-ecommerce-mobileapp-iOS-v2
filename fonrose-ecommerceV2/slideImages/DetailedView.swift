//
//  DetailedView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 24/03/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct DetailedView: View {
    
    var name: String
    
    var body: some View {
        Text("bonjour \(name)")
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(name: "malo")
    }
}
