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
            VStack {
                    player()
                }
            }
            
            // MARK: View3
        if picture.id == 1 {
            
                                       
                VStack {
                    
                    ZStack {
                        List {
                            ScrollView(.horizontal, content: {
                                HStack(spacing: 0) {
                                    
                                    ImagesHStack(imageHStack: "IMG_0858(1) copy")
                                    ImagesHStack(imageHStack: "PHOTO DOS")
                                    ImagesHStack(imageHStack: "IMG_1019 copy")
                                    ImagesHStack(imageHStack: "IMG_0869(1) copy")
                                    ImagesHStack(imageHStack: "IMG_0854(2)")
                                    ImagesHStack(imageHStack: "IMG_1033")
                                    
                                }
                                
                            })
                        }.frame(height: UIScreen.main.bounds.height-100, alignment: .top)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .padding(.horizontal, -15)
                            
                        
                        VStack {
                            Text("La robe")
                                //.font(.system(size: 35, weight: .bold, design: .default))
                                .foregroundColor(Color.white)
                                .frame(alignment: .center)
                            
                            Spacer()
                                .frame(height: 30)
                            
                            Text("85€")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 25, weight: .semibold, design: .default)) }
                    HStack {
                        
                        Spacer()
                        
                        Text("⏩")
                            .font(.system(size: 30))
                        
                    }.frame(width: UIScreen.main.bounds.width)
                        
                                                   
                    }
                
                Spacer()
                    .frame(height: 40)
                    
                VStack {
                    NavigationLink(destination: Mensurations(model: model)) {
                        Text("Acheter")
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    /*NavigationLink(destination: About_us(test: test)) {
                        Text("About the dress")
                    }*/
                    
                }
                
                Spacer()
                    
                }//acolade fermante VStack
                .frame(width: UIScreen.main.bounds.width)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
                  
            }//acolade fermante NavigationView
        }
                    
                
                
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
                
        func makeUIViewController(context: UIViewControllerRepresentableContext<player>) -> AVPlayerViewController {
            let controller = AVPlayerViewController()
            let url = "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4"
            let player1 = AVPlayer(url: URL(string: url)!)
            controller.player = player1
            return controller
        }
        func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<player>) {
            
    }
}




struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(picture: LoadedPictures[0], model: Measurement[0])
    }
}
