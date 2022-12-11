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
    let cellText: String
    var navigationViewName: ViewEnum
    var viewName: ViewEnum
}

var dressPictures: [DressPictures] {
    
    [DressPictures(id: 0, pictureName: "IMG_5195", cellText: "The dress", navigationViewName: .VideoPlayer_trailerPlayer, viewName: .Home_homeFeed0),
    
    DressPictures(id: 1, pictureName: "pic_detail4f0deb99f2574", cellText: "Le serpent", navigationViewName: .VideoPlayer_trailerPlayer, viewName: .Home_homeFeed1),
    
    DressPictures(id: 2, pictureName: "60511853694__59B14B15-472E-4D34-A312-FB963FEDA4D8", cellText: "About us🍑", navigationViewName: .AboutUsScreen, viewName: .Home_homeFeed2),
    
    DressPictures(id: 3, pictureName: "IMG_1033 copy", cellText: "Service client", navigationViewName: .ServiceClient_ServiceClientInfos, viewName: .Home_homeFeed3)]
    
}

