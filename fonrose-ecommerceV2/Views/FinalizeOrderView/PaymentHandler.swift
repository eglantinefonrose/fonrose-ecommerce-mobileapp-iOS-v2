//
//  PaymentHandler.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 28/10/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import Foundation
import PassKit

typealias PaymentCompletionHandler = (Bool) -> Void

@available(iOS 15.0, *)
class PaymentHandler: NSObject {
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler?
    var addressHandler: ((String) -> Void)?
    
    static let supportedNetworks: [PKPaymentNetwork] = [
        .visa,
        .masterCard
    ]
    
    func shippingMethodCalculator() -> [PKShippingMethod] {
        let today = Date()
        let calendar = Calendar.current
        
        let shippingStart = calendar.date(byAdding: .day, value: 5, to: today)
        let shippingEnd = calendar.date(byAdding: .day, value: 10, to: today)
        
        if let shippingEnd = shippingEnd, let shippingStart = shippingStart {
            let startComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingStart)
            let endComponents = calendar.dateComponents ([.calendar, .year, .month, .day], from: shippingEnd)
            
            let shippingDelivery = PKShippingMethod(label: "Delivery", amount: NSDecimalNumber(string: "0.00"))
            shippingDelivery.dateComponentsRange = PKDateComponentsRange(start: startComponents, end: endComponents)
            shippingDelivery.detail = "Sweaters sent to your address"
            shippingDelivery.identifier = "DELIVERY"
            return [shippingDelivery]
       }
        
        return []
        
    }
    
    func updateTotal() {
        
    }
    
    func startPayment(products: [BigModel.DressPictures], total: Int, completion: @escaping PaymentCompletionHandler) {
            
        completionHandler = completion
        paymentSummaryItems = []
        
        BigModel.shared.dressPictures.forEach { product in
            let item = PKPaymentSummaryItem(label: product.productName, amount: NSDecimalNumber(string: "\(product.price) .00"), type: .final)
            paymentSummaryItems.append(item)
        }
        
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "\(total).00"), type: .final)
        paymentSummaryItems.append(total)
        
        let paymentRequest = PKPaymentRequest ()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = "merchant.com.fonrose.fonrose-ecommerceV2"
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
        paymentRequest.shippingType = .delivery
        paymentRequest.shippingMethods = shippingMethodCalculator ()
        paymentRequest.requiredShippingContactFields = [.name, .postalAddress]
        
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { (presented: Bool) in
            if presented {
                debugPrint("Presented payment controller")
            } else {
                debugPrint("Failed to present payment controller")
            }
        })
    }
    
}

@available(iOS 15.0, *)
extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Handle payment authorization here
        
        // Accessing the shipping contact information
        let shippingContact = payment.shippingContact
        if let postalAddress = shippingContact?.postalAddress {
            // Printing the postal address to the console
            print("Postal Address: \(postalAddress)")
        }
        
        // Complete the payment authorization process
        let paymentAuthorizationResult = PKPaymentAuthorizationResult(status: .success, errors: nil)
        completion(paymentAuthorizationResult)
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        // Dismiss the payment authorization controller
        controller.dismiss(completion: nil)
    }
    
}
