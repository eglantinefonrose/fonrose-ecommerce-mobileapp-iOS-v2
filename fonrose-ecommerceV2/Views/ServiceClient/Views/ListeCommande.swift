//
//  ListeCommande.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 23/04/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI

struct ListeCommande: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                BackButtonModel(text: "Suivi de Commande")
                
                Spacer()
                
                if bigModel.currentPersonIndex != nil {
                    
                    if (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].orders.count != 0) {
                        VStack {
                            if #available(iOS 16.0, *) {
                                List(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].orders) { order in
                                    Text(order.productName)
                                        .listRowBackground(Color("Background"))
                                        .onTapGesture {
                                            SuiviDeCommande(order: order)
                                        }
                                }
                                .listStyle(PlainListStyle())
                                .background(Color("Background"))
                                .scrollContentBackground(.hidden)
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                    } else {
                        VStack(spacing: 20) {
                            Text("No orders here")
                            Text("See our products")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    bigModel.lastViews.append(.ServiceClient_showOrdersList)
                                    bigModel.currentview = .ProductsView
                                }
                        }
                    }
                    
                } else {
                    VStack(spacing: 20) {
                        Text("You can find all your orders here")
                        Text("Log in")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                bigModel.lastViews.append(.ServiceClient_showOrdersList)
                                bigModel.currentview = .Auth_AuthView
                            }
                    }
                }
                
                Spacer()
                
            }.padding(20)
        }
    }
}

struct ListeCommande_Previews: PreviewProvider {
    static var previews: some View {
        ListeCommande()
            .environmentObject(BigModel(shouldInjectMockedData: true))
    }
}
