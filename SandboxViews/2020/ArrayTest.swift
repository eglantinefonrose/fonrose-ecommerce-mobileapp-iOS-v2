//
//  ArrayTest.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 14/08/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI

struct ArrayTest: View {
    @State var persons: [String] = ["p1", "p2", "p3"]
    @State var number: [Int] = [1, 2, 3, 4]
    var body: some View {
        VStack {
            Text("delete person3")
                .onTapGesture {
                    self.number.remove(at: 2)
                }
            Text("print array")
                .onTapGesture {
                    for _ in persons {
                        print("\(number.first ?? 666)")
                        if number.count != 0 {
                            number.removeFirst()
                        } else {
                            
                        }
                    }
                }
        }
    }
}

struct ArrayTest_Previews: PreviewProvider {
    static var previews: some View {
        ArrayTest()
    }
}
