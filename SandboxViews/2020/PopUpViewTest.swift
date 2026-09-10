//
//  PopUpViewTest.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 06/07/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI

struct PopUpViewTest: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        Text("Hello, World!")
            .foregroundColor(bigModel.isPersonChosen ? .blue : .red)
            .onTapGesture {
                bigModel.isPersonChosen = true
            }
    }
}

struct PopUpViewTest_Previews: PreviewProvider {
    static var previews: some View {
        PopUpViewTest()
    }
}
