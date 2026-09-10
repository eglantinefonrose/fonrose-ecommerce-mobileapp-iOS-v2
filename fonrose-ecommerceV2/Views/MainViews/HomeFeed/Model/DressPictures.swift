//
//  DressPictures.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import Foundation
import SwiftUI

struct DressPictures: Identifiable {
    var id: Int
    let pictureName: String
    let productName: String
    var videoURL: String
    var carouselViewPictures: [String]
    var price: String
}

var dressPictures: [DressPictures] {
    
    [DressPictures(id: 0, pictureName: "IMG_5195", productName: "The dress", videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", carouselViewPictures: ["IMG_0858(1) copy", "PHOTO DOS", "IMG_1019 copy", "IMG_0869(1) copy", "IMG_0854(2)", "IMG_1033"], price: "85€"),
    
     DressPictures(id: 1, pictureName: "pic_detail4f0deb99f2574", productName: "Le serpent", videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4", carouselViewPictures: ["1oRLkhqgOg8PQaFux2UZlu4lrfY", "Batricia", "Itumblr_inline_os040rQzAr1qzi27c_540", "5ed687a5e9e79d0004912341"], price: "???")/*,
    
     DressPictures(id: 2, pictureName: "60511853694__59B14B15-472E-4D34-A312-FB963FEDA4D8", cellText: "About us🍑", navigationViewName: .AboutUsScreen, viewName: .Home_homeFeed2, videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"),
    
     DressPictures(id: 3, pictureName: "IMG_1033 copy", cellText: "Service client", navigationViewName: .ServiceClient_ServiceClientInfos, viewName: .Home_homeFeed3, videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")*/]
    
}

