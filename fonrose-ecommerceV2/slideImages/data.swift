//
//  data.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import Foundation

let LoadedPictures = picturesLoaded()

func picturesLoaded() -> [DressPictures] {
    let pics: [DressPictures] = [
        
        DressPictures(id: 0, pictureName: "video-promo2", imageNumber: "1"),
        
        DressPictures(id: 1, pictureName: "Screenshot", imageNumber:  "2"),
        
        DressPictures(id: 2, pictureName: "About us", imageNumber: "3")

        ]
    
    return pics
    
    }
