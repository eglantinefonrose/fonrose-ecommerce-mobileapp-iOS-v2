//
//  Meas-Tut.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 20/10/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct Meas_Tut: View {
    let imagesName = ["Sans titre", "Sans titre 2"]
    @State private var index = 0
    
    var body: some View {
        
        VStack {
            //BackButtonModel(text: "about-us")
                //.padding(20)
            
            TabView(selection: $index) {
                ForEach((0..<imagesName.count), id: \.self) { index in
                    ZStack {
                        Image(imagesName[index])
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            HStack(spacing: 15) {
                ForEach((0..<imagesName.count), id: \.self) { index in
                    Circle()
                        .fill(index == self.index ? Color.gray : Color.gray.opacity(0.5))
                        .frame(width: 10, height: 10)

                }
            }
            .padding()
            
        }

    }
}

@available(iOS 14.0, *)
struct Meas_Tut_Previews: PreviewProvider {
    static var previews: some View {
        Meas_Tut()
    }
}
