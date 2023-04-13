//
//  Binding-test1.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 20/03/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI

struct Binding_test1: View {
    
    @State var showModal = false
    
    var body: some View {
        Image(systemName: "paperplane")
            .sheet(isPresented: $showModal) {
                TrailerPlayer()
            }
            .onTapGesture {
                showModal = true
            }
    }
}

struct Binding_test1_Previews: PreviewProvider {
    static var previews: some View {
        Binding_test1()
    }
}
