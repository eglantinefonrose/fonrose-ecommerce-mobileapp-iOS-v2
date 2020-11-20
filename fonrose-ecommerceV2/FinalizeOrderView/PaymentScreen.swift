//
//  PaymentScreen.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 10/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct PaymentScreen: View {

    @EnvironmentObject var bigModel: BigModel
    @State var commingFromMeasurement: Bool
    
    var body: some View {
        
            VStack {
                
                Spacer()
                    .frame(height: 70)
                
                HStack {
                    Spacer()
                        .frame(width: 50)
                    
                    Text("Paiement")
                        .font(.system(size: 45, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
                
                Spacer()
                
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.width-20)
                    
                    Text("Pay")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                }
                    
                Spacer()
                
                Button(action: {
                    self.bigModel.currentview = .FinalizeOrderViews_FinDeCommande
                    }) {
                        //Spacer()
                            
                            HStack {
                                
                                Spacer()
                                
                                HStack {
                                    
                                    Spacer()
                                    Text("Valider")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold)
                                    Spacer()
                                
                                }.background(Color.blue)
                                .frame(width: 150)
                                .cornerRadius(5)
                                
                                Spacer()
                                
                        }.frame(width: 120, height: 35)
                        .background(Color.blue)
                        .cornerRadius(15)
                    
                }
                
                Spacer()
                .frame(height: 20)
                
                Button(action: {
                    self.bigModel.commingFromMeasurement.toggle()
                }) {
                    Text("Modifier mes mesures")
                        .foregroundColor(.blue)
                    }
                
                Spacer()
                    .frame(height: 50)
                
            }.background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

/*struct PaymentScreen_Previews: PreviewProvider {
    static var previews: some View {
        PaymentScreen(commingFromMeasurement: $commingFromMeasurement)
    }
}*/
