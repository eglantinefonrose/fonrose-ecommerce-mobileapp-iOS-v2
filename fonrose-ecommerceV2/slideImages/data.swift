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
        
        DressPictures(id: 0, pictureName: "watch the clip-video-promo2_1", imageNumber: "1", cellText: "Watch the clip"),
        
        DressPictures(id: 1, pictureName: "IMG_5195", imageNumber:  "2", cellText: "The dress"),
        
        DressPictures(id: 2, pictureName: "IMG_4814", imageNumber: "3", cellText: "About us🍑")

        ]
    
    return pics
    
    }
