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
    
    
    @State var ArmpitsMeasurement: String
    var id: Int
    /*@State var ArmsLength: String
    @State var HeadMeasurement: String
    @State var PelvisMeasurement: String
    @State var PelvisKnee: String
    @State var ShouldersMeasurement: String
    @State var ShouldersPelvis: String
    
    var ArmpitsMeasurementText: String
    var ArmsLengthText: String
    var HeadMeasurementText: String
    var PelvisMeasurementText: String
    var PelvisKneeText: String
    var ShouldersMeasurementText: String
    var ShouldersPelvisText: String*/
    
}

let Measurement = LoadedMeasurements()

func LoadedMeasurements() -> [MeasurementInfos] {
    let infos: [MeasurementInfos] = [
        
        /*MeasurementInfos(ArmpitsMeasurement: "", ArmsLength: "", HeadMeasurement: "", PelvisMeasurement: "", PelvisKnee: "", ShouldersMeasurement: "", ShouldersPelvis: "", ArmpitsMeasurementText: "Armpits measurement", ArmsLengthText: "ArmsLength", HeadMeasurementText: "Head measurement", PelvisMeasurementText: "Pelvis measurement", PelvisKneeText: "Pelvis knee", ShouldersMeasurementText: "Shoulders measurement", ShouldersPelvisText: "Shoulders pelvis")*/
        
        MeasurementInfos(ArmpitsMeasurement: "coucougnettas", id: 1)

        ]
    
    return infos
    
    
    
    }
