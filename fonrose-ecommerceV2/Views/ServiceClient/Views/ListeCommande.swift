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
