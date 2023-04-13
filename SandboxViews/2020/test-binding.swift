//
//  test-binding.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 19/11/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct test_binding: View {
    
    var body: some View {
        Text("Text")
    }
}

struct test_binding_Previews: PreviewProvider {
    static var previews: some View {
        test_binding()
            .environment(\.colorScheme, .dark)
    }
}
