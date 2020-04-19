//
//  DetailedView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 24/03/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import AVKit

struct DetailedView: View {
    
    @EnvironmentObject var userData: UserData
    var picture: DressPictures
    
    var postIndex: Int {
        userData.posts.firstIndex(where: { $0.id == picture.id })!
    }
        
    var body: some View {
                
        //ZStack {
                
                VStack {
                    
                    Button(action: {
                        self.userData.posts[self.postIndex].liked.toggle()
                    }) {
                        IconChangableButton(name: "heart", isActive: self.userData.posts[self.postIndex].liked)
                    }
                    
                        Button(action: {
                            self.userData.posts[self.postIndex].saved.toggle()
                        }) {
                            IconChangableButton(name: "flag", isActive: self.userData.posts[self.postIndex].saved)
                        }
            }
        //}
            
            // MARK: View2
            
            /*if picture.id == 1 {
                Image("video-promo2")
            }
            
            // MARK: View3
            
            if picture.id == 2 {
                Image("About us")
            }
            
            // MARK: View4
            
            if picture.id == 3 {
                    VStack {
                        detailedViewTest()
                }.frame(width: UIScreen.main.bounds.width)
            }
            
        }//.background(Color.black)
        .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height)
            .padding(.top, -20)
            .padding(.horizontal, -20)
        
    }
    
    
    
    // MARK: Controller pour video
    struct player : UIViewControllerRepresentable {
                
        func makeUIViewController(context: UIViewControllerRepresentableContext<player>) -> AVPlayerViewController {
            let controller = AVPlayerViewController()
            let url = "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4"
            let player1 = AVPlayer(url: URL(string: url)!)
            controller.player = player1
            return controller
        }
        func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<player>) {
            
        }*/
    }
    
}




struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(picture: LoadedPictures[0])
            .environmentObject(UserData())
    }
}
