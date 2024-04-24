//
//  PaymentView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 24/04/2024.
//  Copyright © 2024 fonrose. All rights reserved.
//

/*import SwiftUI
import PassKit

struct PaymentView: View {
    @State private var paymentError: Error?
    @State private var paymentStatus: PKPaymentAuthorizationStatus?
    
    var body: some View {
        Button(action: {
            initiatePayment()
        }) {
            Text("Pay $10 with Apple Pay")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        //.alert(item: $paymentError) { error in
            //Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
        //}
        //.alert(item: $paymentStatus) { status in
            //Alert(title: Text(paymentStatusDescription(status)), dismissButton: .default(Text("OK")))
        //}
    }
    
    private func initiatePayment() {
        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = "your_merchant_identifier"
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        paymentRequest.supportedNetworks = [.amex, .visa, .masterCard]
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "10.00"))]
        
        let paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController.delegate = self
        paymentController.present(completion: nil)
    }
    
    private func paymentStatusDescription(_ status: PKPaymentAuthorizationStatus) -> String {
        switch status {
        case .success:
            return "Payment Successful!"
        case .failure:
            return "Payment Failed."
        case .invalidBillingPostalAddress, .invalidShippingPostalAddress, .invalidShippingContact:
            return "Invalid Address."
        //case .invalidShippingMethod:
            //return "Invalid Shipping Method."
        default:
            return "Unknown Error."
        }
    }
}*/
