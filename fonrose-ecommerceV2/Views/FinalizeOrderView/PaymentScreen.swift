//
//  PaymentScreen.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 10/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import PassKit

@available(iOS 14.0, *)
struct PaymentScreen: View {

    @EnvironmentObject var bigModel: BigModel
    //var action: () -> Void
    
    @available(iOS 14.0, *)
    var body: some View {
        
        Text("")
            
        }
        
    }

@available(iOS 14.0, *)
struct PaymentScreen_Previews: PreviewProvider {
    @available(iOS 14.0, *)
    static var previews: some View {
        PaymentScreen()
    }
}

/*extension PKPaymentButton {
    struct Representable: UIViewRepresentable {
        var action: () -> Void
        
        @available(iOS 14.0, *)
        func makeCoordinator() -> Coordinator {
            Coordinator(action: action)
        }
        
        func makeUIView(context: Context) -> some UIView {
            context.coordinator.button
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            context.coordinator.action = action
        }
        
    }
    
    @available(iOS 14.0, *)
    class Coordinator: NSObject {
        var action: () -> Void
        var button = PKPaymentButton(paymentButtonType: .checkout, paymentButtonStyle: .automatic)
        
    }
    
}*/
