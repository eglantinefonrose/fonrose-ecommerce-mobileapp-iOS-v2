//
//  IconButton.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 13/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct IconButton: View {
    
    let name: String
    
    var body: some View {
        Image(systemName: name)
            .frame(width: 30, height: 30, alignment: .center)
            .foregroundColor(.gray)
    }
}

struct IconChangableButton: View {
    
    let name: String
    var isActive: Bool
    
    var body: some View {
        Image(systemName: isActive ? "\(name).fill" : name)
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(isActive ? (name == "heart" ? .red : .black) : .gray)
    }
}

struct IconButton_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            IconChangableButton(name: "heart", isActive: true)
            IconChangableButton(name: "heart", isActive: false)
            IconChangableButton(name: "flag", isActive: true)
            IconChangableButton(name: "flag", isActive: false)
        }
    }
}
