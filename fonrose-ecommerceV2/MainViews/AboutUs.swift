//
//  About_us.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 21/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import AVFoundation

struct AboutUs: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        
        ZStack {
        
            LoopingPlayer()

            VStack {

                Spacer()
                    .frame(height: 30)

                HStack {

                   Spacer()
                        .frame(width: 30)

                   Button(action: {
                       self.bigModel.currentview = .Home_homeFeed
                   }) {
                       Text("Back")
                   }

                   Spacer()

                }.frame(width: UIScreen.main.bounds.width)

                Spacer()

            }.frame(height: UIScreen.main.bounds.height)

            Text("Hi, my name’s Eglantine Fonrose and I’m a 16 years old creative girl. I really like to make videos, sew, create and discover new things. Hoping you will like the brand, an about the brand video will be available soon ツ")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .heavy, design: .default))
                .frame(width: UIScreen.main.bounds.width-40)

        }.frame(width: UIScreen.main.bounds.width)
            .edgesIgnoringSafeArea(.all)
        
    }
}

struct LoopingPlayer: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Do nothing here
    }
}

class PlayerUIView: UIView {
    
    private var playerLayer = AVPlayerLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let fileUrl = Bundle.main.url(forResource: "IMG_0247", withExtension: "mp4")!
        let playerItem = AVPlayerItem(url: fileUrl)
        
        let player = AVPlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(rewindVideo(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        player.play()
        
    }
    
    @objc
    func rewindVideo(notification: Notification) {
        playerLayer.player?.seek(to: .zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
