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
    let status: SuiviStatusEnum
}




let parcelStatus = statusParcel()

func statusParcel() -> [ParcelInfos] {
    let parcels: [ParcelInfos] = [
        ParcelInfos(status: .EnCoursDExpedition),
        ParcelInfos(status: .Livré),
        ParcelInfos(status: .PrisEnCharge),
        ParcelInfos(status: .PretsAEtreExpédié)]
    
    return parcels
    
}
