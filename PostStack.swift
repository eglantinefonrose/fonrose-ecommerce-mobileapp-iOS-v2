//
//  PostStack.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 19/03/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct PostStack: View {
    
    @EnvironmentObject var bigModel: BigModel
    var picture: DressPictures
    let pictureNamee: String
    let ceellText: String
    
    var body: some View {
        
        VStack {
            /*IconChangableButton(name: "heart", isActive: liked)
            IconChangableButton(name: "flag", isActive: saved)*/
            ZStack {
                Image(self.pictureNamee)
                    .resizable()
                    .padding(.vertical, -7)
                    .aspectRatio(contentMode: .fill)
                    .frame(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height, alignment: .leading)
                    .padding(.leading, -UIScreen.main.bounds.width/2)
                
                
                Button(action: {
                    self.bigModel.currentview = self.picture.navigationViewName
                }) {
                    Text(self.ceellText)
                        .font(.system(size: 60))
                        .foregroundColor(Color(red: 200/255, green: 200/255, blue: 200/255))
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                }
            }
        }
    }
}

struct PostStack_Previews: PreviewProvider {
    static var previews: some View {
        PostStack(picture: LoadedPictures[0], pictureNamee: "Screenshot 2020-04-06 at 18.29.34", ceellText: "Watch the clip")
    }
}
