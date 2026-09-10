//
//  PaymentButton.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 12/10/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI
import PassKit

@available(iOS 14.0, *)
struct PaymentButton: View {
    var action: () -> Void
    var body: some View {
        Representable(action: action)
            .frame(minWidth: 100, maxWidth: 400)
            .frame(height: 45)
            .frame(maxWidth: .infinity)
    }
}

@available(iOS 14.0, *)
struct PaymentButton_Previews: PreviewProvider {
    static var previews: some View {
        PaymentButton(action: {})
    }
}

@available(iOS 14.0, *)
extension PaymentButton {
    @available(iOS 14.0, *)
    struct Representable: UIViewRepresentable {
        var action: () -> Void
        
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
        
        init(action: @escaping() -> Void) {
            self.action = action
            super.init()
            
            button.addTarget(self, action: #selector(callback(_:)), for: .touchUpInside)
        }
        
        @objc
        func callback(_ sender: Any) {
            action()
        }
        
    }
    
}
