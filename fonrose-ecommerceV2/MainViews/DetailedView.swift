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
    
    var picture: DressPictures
    var model: MeasurementInfos
    //var test: MeasurementInfos
    
    /*var postIndex: Int {
        userData.posts.firstIndex(where: { $0.id == picture.id })!
    }*/
    
        
    var body: some View {
        NavigationView {
            // MARK: View2
            
    if picture.id == 0 {
                player()
            }
            
            // MARK: View3
        if picture.id == 1 {
            
                CarouselView()
            
            }//acolade fermante du if
        
        if picture.id == 3 {
        
            ServiceClientInfos(parcel: statusParcel()[0])
        
        }
            
            
        }//acolade fermante NavigationView
    }
}

    //MARK: Format image pour 
    struct ImagesHStack: View {
        
        let imageHStack: String
        
        var body: some View {
            
            VStack {
                Image(imageHStack)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (UIScreen.main.bounds.width+UIScreen.main.bounds.height)/2, height: UIScreen.main.bounds.height-100, alignment: .center)
                            
            }

        }
    }



    // MARK: Controller pour video
struct player : UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<player>) {
        
    }
    
        func makeUIViewController(context: UIViewControllerRepresentableContext<player>) -> AVPlayerViewController {
            let controller = AVPlayerViewController()
            let url = "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4"
            let player1 = AVPlayer(url: URL(string: url)!)
            controller.player = player1
            return controller
        }
}




struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(picture: LoadedPictures[0], model: Measurement[0])
    }
}
