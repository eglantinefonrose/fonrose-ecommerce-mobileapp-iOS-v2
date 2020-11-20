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
    
    var body: some View {

        VStack {
            
            ZStack {
                //player()
                
                HStack {
                    
                    Spacer()
                        .frame(width: 30)
                    VStack {
                        
                        Spacer()
                            .frame(height: 30)
                        Button(action: {
                            self.bigModel.currentview = .Home_homeFeed
                        }) {
                            Text("< Back")
                                .foregroundColor(Color.blue)
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        
                    }
                    Spacer()
                    
                }//.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .topLeading)
            }
        }.edgesIgnoringSafeArea(.all)

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
