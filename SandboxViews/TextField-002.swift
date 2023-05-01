//
//  TextField-002.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 29/04/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct TextField_002: View {
        
    var body: some View {
            VStack {
                
                Text("")
                //fetchImage(url: "https://firebasestorage.googleapis.com/v0/b/fonrose-ecommerce-v2.appspot.com/o/les-noces-funebres-sur-netflix-c-est-quoi-l-animation-en-stop-motion-4.jpg?alt=media&token=b3be12d6-f47b-42ca-8652-2dc1c3436832")
                
                
            }
        }

    func fetchImage(url: String) -> Image {
        var image: Image = Image("tumblr_inline_os040rQzAr1qzi27c_540")
        let storage = Storage.storage()
        let gsReference = storage.reference(forURL: url)

        gsReference.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                return
            }

            guard let imageData = data, let uiImage = UIImage(data: imageData) else {
                print("Error converting image data to UIImage.")
                return
            }

            image = Image(uiImage: uiImage)
            
        }
        
        print("image")
        return image
        
    }
}

struct TextField_002_Previews: PreviewProvider {
    static var previews: some View {
        TextField_002()
    }
}
