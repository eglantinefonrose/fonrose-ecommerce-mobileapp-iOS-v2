//
//  DetailedView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 24/03/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import AVKit

struct TrailerPlayer: View {
    
    @EnvironmentObject var bigModel: BigModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {

        ZStack {
            
            player()
        
            VStack {
                
                Spacer()
                    .frame(height: 40)
                
                if #available(iOS 14.0, *) {
                    HStack {
                        
                        Spacer()
                            .frame(width: 20)
                        
                        Text("Back")
                            .foregroundColor(Color.blue)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Image(systemName: "house")
                            .foregroundColor(Color.blue)
                            .onTapGesture {
                                self.bigModel.currentview = .Home_homeFeed
                                self.bigModel.lastViews.removeAll()
                            }
                        
                        Spacer()
                            .frame(width: 20)
                        
                    }.onTapGesture {
                        if !self.bigModel.lastViews.isEmpty {
                            self.bigModel.currentview = self.bigModel.lastViews.last ?? .AboutUsScreen
                            self.bigModel.lastViews.removeLast()
                            print("previous View = \(String(describing: self.bigModel.lastViews.last))")
                        } else { print("array empty") }
                    }
                } else {
                    // Fallback on earlier versions
                }
                
                Spacer()
                
            }
            
        }.edgesIgnoringSafeArea(.all)
        .background(Color.black)

    }
    
}


    // MARK: Controller pour video
struct player : UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<player>) {
        
    }
    
        func makeUIViewController(context: UIViewControllerRepresentableContext<player>) -> AVPlayerViewController {
            let controller = AVPlayerViewController()
            let url = "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4" // url non existante
            let player1 = AVPlayer(url: URL(string: url)!)
            controller.player = player1
            return controller
        }
}




struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        player()
    }
}
