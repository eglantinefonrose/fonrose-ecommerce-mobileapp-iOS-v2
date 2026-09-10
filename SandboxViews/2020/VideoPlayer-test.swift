//
//  VideoPlayer-test.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 28/11/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import AVKit

struct VideoPlayer_test: View {
    var body: some View {
        Player(player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video1", ofType: "mp4") ?? "")))
    }
}

struct Player : UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        return view
    }
    
}

struct VideoPlayer_test_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayer_test()
    }
}
