//
//  LoopTest.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 11/08/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI

struct LoopTest: View {
    
    var body: some View {
        VStack {
            Text("💋")
                .onTapGesture {
                    loop()
                }
        }
    }
}

func loop() {

    let array = [1, 2, 3]
    var number = 0

    for _ in array {
        print(number)
        number = number+1
    }
}

struct LoopTest_Previews: PreviewProvider {
    static var previews: some View {
        LoopTest()
    }
}
