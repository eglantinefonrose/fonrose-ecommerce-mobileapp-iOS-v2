//
//  PaymentScreen.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 10/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct PaymentScreen: View {
    var body: some View {
        
        NavigationView {
            VStack {
                
                Spacer()
                    .frame(height: 150)
                
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
                    .frame(width: UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.width-50)
                    
                    Text("Pay")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                }
                    
                /*(LinearGradient(gradient: Gradient(colors: [.white, .gray
                    ]), startPoint: .topLeading, endPoint: .bottomTrailing))*/
                
                Spacer()
                
                NavigationLink(destination: FinDeCommande()) {
                    Text("navigation")
                }
                
                Spacer()
                    .frame(height: 50)
                
            }.edgesIgnoringSafeArea(.all)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .background(Color.black)
            .padding(.vertical, -44)
        }//.padding(.top, -40)
        
    }
}

struct PaymentScreen_Previews: PreviewProvider {
    static var previews: some View {
        PaymentScreen()
    }
}
