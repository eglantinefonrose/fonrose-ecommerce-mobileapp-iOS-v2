//
//  Sandbox-TextFields.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 13/04/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI

struct Sandbox_TextFields: View {
    var body: some View {
        HomeSandb(name: "babe")
    }
}

struct HomeSandb: View {
    @State var name: String
    var body: some View {
        VStack {
            
            TextField("nom", text: $name)
            Text("😵")
                .onTapGesture {
                    print(name)
                }
            
        }
    }
}

struct Sandbox_TextFields_Previews: PreviewProvider {
    static var previews: some View {
        Sandbox_TextFields()
    }
}
