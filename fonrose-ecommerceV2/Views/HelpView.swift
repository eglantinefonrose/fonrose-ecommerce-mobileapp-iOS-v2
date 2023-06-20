//
//  HelpView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 20/05/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI

struct HelpView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                BackButtonModel(text: "Informations")
                
                Spacer()
                
                Text("Informations")
                    .font(.system(size: 35, weight: .bold, design: .default))
                
                Spacer()
                
                if #available(iOS 16.0, *) {
                        
                    ScrollView {
                        
                        VStack() {
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text("Personnes")
                                    .font(Font.title.weight(.semibold))
                                
                                
                                Text("À chaque compte sont associés des personnes qui ont des mensurations spécifiques et des données de localisation spécifiques. Grâce à ça, vous pouvez commander des produits aux mensurations de plusieurs personnes en n'utilisant qu’un seul compte. Cependant, les données relatives aux données de paiement sont communes à chaque personne.")
                                    .multilineTextAlignment(.leading)
                                
                            }.padding(.vertical, 10)
                            
                        }.background(Color("Background"))
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        
                        
                        VStack() {
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text("Mensurations")
                                    .font(Font.title.weight(.semibold))
                                
                                
                                Text("Pour chaque produit, des mensurations spécifiques à l’article sélectionné vous sont demandées afin de préparer votre commande. Des vidéos explicatives pour prendre au mieux ses mensurations sont à votre disposition pour vous aider.")
                                    .multilineTextAlignment(.leading)
                                
                            }.padding(.vertical, 10)
                            
                        }.background(Color("Background"))
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        
                    }
                    
                } else {
                    // Fallback on earlier versions
                }
                
                Spacer()
                
                HStack {
                    VStack {
                        Image(systemName: "chevron.down")
                        Image(systemName: "chevron.down")
                    }
                    Text("Scroll down to see every informations")
                }
                
                HStack {
                    Spacer()
                    Text("Go to home page")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .padding(10)
                    Spacer()
                }.background(Color.blue)
                .cornerRadius(15)
                .onTapGesture {
                    bigModel.currentview = .Home_homeFeed0
                }
                
            }.padding(20)
            
        }
        
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
