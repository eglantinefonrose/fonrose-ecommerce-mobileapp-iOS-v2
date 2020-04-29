//
//  MensurationsInfos.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 28/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import Foundation
import SwiftUI

struct MeasurementInfos {
    
    var ArmpitsMeasurement: String
    var ArmsLength: String
    var HeadMeasurement: String
    var PelvisMeasurement: String
    var PelvisKnee: String
    var ShouldersMeasurement: String
    var ShouldersPelvis: String
    
}

let Measurement = LoadedMeasurements()

func LoadedMeasurements() -> [MeasurementInfos] {
    let infos: [MeasurementInfos] = [
        
        MeasurementInfos(ArmpitsMeasurement: "coucougnette", ArmsLength: "", HeadMeasurement: "", PelvisMeasurement: "", PelvisKnee: "", ShouldersMeasurement: "", ShouldersPelvis: "")

        ]
    
    return infos
    
    }
