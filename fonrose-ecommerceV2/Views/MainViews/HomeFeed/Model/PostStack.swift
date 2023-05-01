//
//  PostStack2.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 01/05/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseStorage

struct PostStack: View {
    
    @EnvironmentObject var bigModel: BigModel
    @State var image: Image = Image("")
    var url: String
    var cellText: String
    
    
    var body: some View {
        
        if #available(iOS 15.0, *) {
            ZStack {
                
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                Text(cellText)
                    .frame(alignment: .center)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                
            }.task {
                do {
                    let fetchedImage = try await bigModel.fetchImage(url: url)
                    self.image = fetchedImage
                } catch {
                    print("Error fetching image: \(error.localizedDescription)")
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
}
