//
//  dataSuivi.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 09/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import Foundation
import SwiftUI


struct ParcelInfos {
    let status: String
}




let parcelStatus = statusParcel()

func statusParcel() -> [ParcelInfos] {
    let parcels: [ParcelInfos] = [
        ParcelInfos(status: "En cours d'expedition"),
        ParcelInfos(status: "Livré"),
        ParcelInfos(status: "Prets à être expédié"),
        ParcelInfos(status: "Pris en charge")]
    
    return parcels
    
}
