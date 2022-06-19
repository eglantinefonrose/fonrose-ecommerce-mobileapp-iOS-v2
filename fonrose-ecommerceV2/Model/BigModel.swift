//
//  BigModel.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 22/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import Foundation
import CoreLocation

class BigModel : ObservableObject {
    
    public static var shared = BigModel()
    
    //@Published var commingFromMeasurement: Bool = false
    @Published var currentview = ViewEnum.Home_homeFeed
    @Published var lastViews: [ViewEnum]
    init(lastViews: [ViewEnum] = []) {
        self.lastViews = lastViews
    }
    @Published var previousView: ViewEnum? = nil
    
    //MARK: HomeFeed
    @Published var showMenu: Bool = false
    
    //MARK: Measurement
    @Published var armpitsMeasurement: String! = ""
    @Published var armsLength: String! = ""
    @Published var headMeasurement: String! = ""
    @Published var pelvisMeasurement: String! = ""
    @Published var pelvisKnee: String! = ""
    @Published var shouldersMeasurement: String! = ""
    @Published var shouldersPelvis: String! = ""
    @Published var commingFromPaymentScreen: Bool = false

    //MARK: Service Client
    @Published var orderID : String? = nil
    @Published var orderStatus : SuiviStatusEnum? = nil
    
    //MARK: Location
    @Published var selectedPlacemark: CLPlacemark? = nil
}
