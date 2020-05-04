//
//  About us.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI


struct About_us: View {
    
    @EnvironmentObject var userData: UserData
    var model: MeasurementInfos
    
    
    var postIndex: Int {
        userData.measurementTextFields.firstIndex(where: { $0.id == model.id })!
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            TextField("caca", text: self.userData.measurementTextFields[self.postIndex].$ArmpitsMeasurement)
            
            Spacer()
            
        }.background(Color.red)
    }
}

struct About_us_Previews: PreviewProvider {
        
    static var previews: some View {
        About_us(model: Measurement[0])
            .environmentObject(UserData())
    }
}
