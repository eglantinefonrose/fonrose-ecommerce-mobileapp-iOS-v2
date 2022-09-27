//
//  test-binding.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 19/11/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct test_binding: View {
    
    @Binding var test1: Bool
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

/*struct test_binding_Previews: PreviewProvider {
    static var previews: some View {
        test_binding(test1: <#Binding<Bool>#>)
    }
}*/
