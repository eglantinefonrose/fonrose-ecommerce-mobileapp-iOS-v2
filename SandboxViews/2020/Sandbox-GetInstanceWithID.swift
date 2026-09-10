//
//  Sandbox-GetInstanceWithID.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 02/02/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI


struct Cat: Identifiable {
    var id: Int
    var name: String
}

struct Sandbox_GetInstanceWithID: View {
    let cats: [Cat] = [Cat(id: 1, name: "Felix"), Cat(id: 2, name: "Lion"), Cat(id: 3, name: "Nabilon")]
    var body: some View {
        Text("e")
            .onTapGesture {
                print(cats.first(where: { $0.id == 2 })?.name ?? "")
            }
    }
}

struct Sandbox_GetInstanceWithID_Previews: PreviewProvider {
    static var previews: some View {
        Sandbox_GetInstanceWithID()
    }
}
