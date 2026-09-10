//
//  PaymentScreen_sandbox.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 19/12/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI

struct PaymentScreen_sandbox: View {
    var body: some View {
        if #available(iOS 14.0, *) {
            PaymentButton_sandbox(action: {})
                .padding(10)
        } else {
            // Fallback on earlier versions
        }
    }
}

struct PaymentScreen_sandbox_Previews: PreviewProvider {
    static var previews: some View {
        PaymentScreen_sandbox()
    }
}
