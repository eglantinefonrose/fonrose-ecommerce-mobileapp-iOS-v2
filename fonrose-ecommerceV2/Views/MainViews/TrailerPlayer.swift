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
    @State private var orientation = UIDeviceOrientation.portrait
    @Environment(\.presentationMode) var presentationMode
    let url : URL
    
    var body: some View {

        ZStack {
            
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(.black)
            
            if #available(iOS 14.0, *) {
                
                VideoPlayer(player: AVPlayer(url: url))
               
            } else {
                // Fallback on earlier versions
            }
            
            VStack {
                
                HStack {
                    
                    Text("Back")
                        .foregroundColor(Color.blue)
                        .fontWeight(.semibold)
                        .onTapGesture {
                            if !self.bigModel.lastViews.isEmpty {
                                print("back")
                                self.bigModel.currentview = self.bigModel.lastViews.last ?? .AboutUsScreen
                                self.bigModel.lastViews.removeLast()
                                print("previous View = \(String(describing: self.bigModel.lastViews.last))")
                            } else { print("array empty") }
                        }
                    
                    Spacer()
                    
                    Text(bigModel.dressPictures[bigModel.selectedProductId ?? 0].productName)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "house")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            bigModel.lastViews.append(.VideoPlayer_trailerPlayer)
                            bigModel.currentview = .Home_homeFeed0
                        }
                
                }.onRotate { newOrientation in orientation = newOrientation }
                .padding(20)
                .frame(width: UIScreen.main.bounds.width)
                
                Spacer()
                
                Text("Buy")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        bigModel.lastViews.append(.VideoPlayer_trailerPlayer)
                        bigModel.currentview = .MeasurementCarouselView
                    }
                
            }
            
        }//.frame(width: orientation == .portrait || orientation == .portraitUpsideDown ? UIScreen.main.bounds.width : UIScreen.main.bounds.height)

    }
    
}

/*struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        TrailerPlayer()
            .environmentObject(BigModel(shouldInjectMockedData: true))
    }
}*/
