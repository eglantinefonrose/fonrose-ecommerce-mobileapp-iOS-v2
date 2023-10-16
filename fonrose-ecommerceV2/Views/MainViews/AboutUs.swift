//
//  About_us.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 21/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import AVFoundation

@available(iOS 14.0, *)
struct AboutUs: View {
    
    @EnvironmentObject var bigModel: BigModel
    let aboutUsTexts = [Text("Nous vivons dans un monde authentique, entourés de personnes toutes") + Text(" uniques").bold().italic() + Text(", bien loin des standards de beauté."),
    Text("L’objectif : créer des vêtements pour tout le spectre de") + Text(" morphologies ").bold().italic() + Text("dans le but de dépeindre la") + Text(" femme ").bold().italic() +  Text("dans sa") + Text(" totalité ").bold().italic() + Text(", bien au-delà des silhouettes stéréotypées des réseaux sociaux.")
    ]
    @State private var index = 0
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                BackButtonModel(text: "about-us")
                    .padding(20)
                
                TabView(selection: $index) {
                    ForEach((0..<aboutUsTexts.count), id: \.self) { index in
                        ZStack {
                            Rectangle()
                                .foregroundColor(.gray)
                                .opacity(0.3)
                            aboutUsTexts[index]
                                .font(.largeTitle)
                                .padding(20)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                HStack(spacing: 15) {
                    ForEach((0..<aboutUsTexts.count), id: \.self) { index in
                        Circle()
                            .fill(index == self.index ? Color.gray : Color.gray.opacity(0.5))
                            .frame(width: 10, height: 10)

                    }
                }
                .padding()
                
            }
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
     
    static var previews: some View {
        if #available(iOS 14.0, *) {
            AboutUs()
        } else {
            // Fallback on earlier versions
        }
    }
}
