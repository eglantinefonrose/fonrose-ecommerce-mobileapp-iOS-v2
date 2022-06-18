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
    //let imageNumber: String
    let cellText: String
    var liked: Bool
    var saved: Bool
    var navigationViewName: ViewEnum
}

var dressPictures: [DressPictures] {
    
    [DressPictures(id: 0, pictureName: "watch the clip-video-promo2_1",/* imageNumber: "1", */cellText: "Watch the clip", liked: false, saved: true, navigationViewName: .VideoPlayer_trailerPlayer),
    
    DressPictures(id: 1, pictureName: "IMG_5195",/* imageNumber:  "2", */cellText: "The dress", liked: true, saved: false, navigationViewName: .MeasurementCarouselView),
    
    DressPictures(id: 2, pictureName: "60511853694__59B14B15-472E-4D34-A312-FB963FEDA4D8",/* imageNumber: "3", */cellText: "About us🍑", liked: false, saved: true, navigationViewName: .AboutUsScreen),
    
    DressPictures(id: 3, pictureName: "IMG_1033 copy",/* imageNumber: "3", */cellText: "Service client", liked: true, saved: false, navigationViewName: .ServiceClient_ServiceClientInfos)]
    
}

