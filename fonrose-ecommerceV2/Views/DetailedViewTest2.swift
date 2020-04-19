//
//  DetailedViewTest2.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 18/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct DetailedViewTest2: View {
    
    @State var showDelivery = false
    @State var showReturn = false
    @State var showCard = false
    var parcel: ParcelInfos
    
    var body: some View {
        
    VStack {
        
        //MARK: Header
        
        VStack {
            
        Text("Informations client")
            .font(.system(size: 35, weight: .bold, design: .default))
            .foregroundColor(Color.white)
            .frame(alignment: .center)
            
        Text("Questions fréquentes")
            .foregroundColor(Color.gray)
            .font(.system(size: 25, weight: .semibold, design: .default))
            
        }
        
        Spacer()
            .frame(height: 30)
        
        //MARK: Suivi de colis
        
        NavigationView {
            VStack {
                NavigationLink(destination: SuiviDeCommande(model: statusParcel()[0], statuus: "ziz")) {
                    Text("Show Detail View")
                    }
                }
            }
        }//acollade fermante de la VStack
        .background(Color.black)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}


struct DetailedViewTest2_Previews: PreviewProvider {
    static var previews: some View {
        DetailedViewTest2(parcel: statusParcel()[0])
    }
}
