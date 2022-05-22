//
//  Tab Bar.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 03/05/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI

struct Tab_Bar: View {
    var body: some View {
        TabView(selection: .constant(2),
                content:  {
                    Text("Tab Content 1").tabItem { Image(systemName: "cart") }.tag(1)
                    Text("Tab Content 2").tabItem { Image(systemName: "cart") }.tag(2)
                })
    }
}

struct Tab_Bar_Previews: PreviewProvider {
    static var previews: some View {
        Tab_Bar()
    }
}
