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
        
        DressPictures(id: 0, pictureName: "Screenshot 2020-04-06 at 18.29.34",/* imageNumber: "1", */cellText: "Watch the clip", liked: false, saved: true),
        
        DressPictures(id: 1, pictureName: "IMG_5195",/* imageNumber:  "2", */cellText: "The dress", liked: true, saved: false),
        
        DressPictures(id: 2, pictureName: "IMG_4814",/* imageNumber: "3", */cellText: "About us🍑", liked: false, saved: true),
        
        DressPictures(id: 3, pictureName: "IMG_1033 copy",/* imageNumber: "3", */cellText: "Service client", liked: true, saved: false)

        ]
    
    return pics
    
    }
