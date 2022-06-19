//
//  UserModel.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 19/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import MapKit

struct User: Identifiable {
    var id: Int
    var userID: String
    var email: String
    var persons: [Person] = []
}

struct Location {
    var adress: String
}

struct Measurements {
    var ArmpitsMeasurement: String
    var ArmsLength: String
    var HeadMeasurement: String
    var PelvisMeasurement: String
    var PelvisKnee: String
    var ShouldersMeasurement: String
    var ShouldersPelvis: String
}

struct Person: Identifiable {
    var id: Int
    var email: String
    var name: String
    var measurements: Measurements?
    var location: Location?
}
