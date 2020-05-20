//
//  FinDeCommande.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 10/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import AVFoundation

struct FinDeCommande : View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var seconds: Int = 0
    
    var body : some View {
        
        VStack {
            
            Spacer()
            
            ZStack {
                
                Spacer()
                
                Text("\(seconds)").onReceive(timer) { input in
                    self.seconds += 1
                }
                
                PlayerView()
                
                VStack {//élement 1
                          
                    if seconds < 4 {
                        Text("Félicitations")
                            .font(.system(size: 45, weight: .bold, design: .default))
                            .foregroundColor(Color.white)
                    } else {
                        Text("Merci")
                        .font(.system(size: 45, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                    }
                    
                    if seconds < 4 {
                        Text("pour votre achat")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 30, weight: .semibold, design: .default))
                        
                    } else {
                        Text("d'avoir choisi fonrose")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 30, weight: .semibold, design: .default))
                    }
                          
                }
            
                }
            
            Spacer()
            
        }.background(Color.black)
            .edgesIgnoringSafeArea(.all)
        
    }
}

struct PlayerView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
        
    }
}

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let fileUrl = Bundle.main.url(forResource: "IMG_0247", withExtension: "mp4")!
        let playerItem = AVPlayerItem(url: fileUrl)
        
        let player = AVPlayer(playerItem: playerItem)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        player.play()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct FinDeCommande_Previews: PreviewProvider {
    static var previews: some View {
        FinDeCommande()
    }
}
