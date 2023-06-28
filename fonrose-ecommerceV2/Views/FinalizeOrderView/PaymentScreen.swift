//
//  PaymentScreen.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 10/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import PassKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

@available(iOS 14.0, *)
struct PaymentScreen: View {

    @EnvironmentObject var bigModel: BigModel
    //var action: () -> Void
    
    @available(iOS 14.0, *)
    var body: some View {
        
        ZStack {
                        
            VStack {
                BackButtonModel(text: "Payment")
                Spacer()
                Text("Pay")
                    .onTapGesture {
                        bigModel.currentview = .FinalizeOrderViews_FinDeCommande
                        bigModel.lastViews.append(.FinalizeOrderViews_PaymentScreen)
                        
                        if bigModel.currentPersonIndex != nil && bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location != nil  {
                            
                            bigModel.addAnOrder(
                                location: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location ?? BigModel.Location(civility: "", firstName: "", lastName: "", emailAdress: "", phoneNumber: "", adressCountry: "", adressPostalCode: "", adressCity: "", adressStreet: "", adressMailBox: "", adressBasement: "", adressStage: ""),
                                measurements: [],
                                productName: bigModel.dressPictures[bigModel.selectedProductId ?? 0].productName
                            )
                            
                            /*for i in 0..<bigModel.user.persons[bigModel.currentPersonIndex].orders.count {
                                
                                guard let userID = Auth.auth().currentUser?.uid else {return}
                                
                                let docRef = db.collection("users").document("user\(userID)")

                                  docRef.getDocument { document, error in
                                    if let error = error as NSError? {
                                      self.errorMessage = "Error getting document: \(error.localizedDescription)"
                                    }
                                    else {
                                      if let document = document {
                                        do {
                                          self.book = try document.data(as: Book.self)
                                        }
                                        catch {
                                          print(error)
                                        }
                                      }
                                    }
                                  }
                            }*/
                            
                        }
                    }
                Spacer()
            }.padding(20)
        }
            
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
