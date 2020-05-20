//
//  MensurationsInfos.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 28/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import Foundation
import SwiftUI

struct MeasurementInfos: Identifiable {
    
    var id: Int
    @State var ArmpitsMeasurement: String
    @State var ArmsLength: String
    @State var HeadMeasurement: String
    @State var PelvisMeasurement: String
    @State var PelvisKnee: String
    @State var ShouldersMeasurement: String
    @State var ShouldersPelvis: String
    
    @State var fesse: Bool
}

let Measurement = LoadedMeasurements()

func LoadedMeasurements() -> [MeasurementInfos] {
    let infos: [MeasurementInfos] = [
        
        MeasurementInfos(id: 1, ArmpitsMeasurement: "", ArmsLength: "", HeadMeasurement: "", PelvisMeasurement: "", PelvisKnee: "", ShouldersMeasurement: "", ShouldersPelvis: "", fesse: true)

        ]
    
    return infos
    
    
    
    }

struct TestButton {
    
    var model: MeasurementInfos
    var isActivee: Bool
    
    var body: some View {
        
        Text(isActivee ? "Premier texte" : "Second texte")
        
    }
    
}
