//
//  player2.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 04/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import AVKit

struct home: View {
    
    @Binding var isPresented: Bool
    let CPSMVideoName: String

    var body: some View {
        
        VStack {
            
            HStack {
                Spacer()
                    .frame(width: 30)
                
                Button(action: {
                    self.isPresented.toggle()
                }) {
                    Text("< Back")
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
                
                Spacer()
            }
            
            player2(videoName: CPSMVideoName)
            
        }.background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct player2 : UIViewControllerRepresentable {
    
    let videoName: String
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<player2>) -> AVPlayerViewController {
            let controller = AVPlayerViewController()
            let url = "\(videoName)"
            let player1 = AVPlayer(url: URL(string: url)!)
            controller.player = player1
            return controller
        }
        func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<player2>) {
            
    }
}
