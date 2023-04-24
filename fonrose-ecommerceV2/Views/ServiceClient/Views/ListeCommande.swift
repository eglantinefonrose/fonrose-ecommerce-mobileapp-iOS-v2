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
                HStack {
                    
                    Text("Back")
                        .bold()
                        .foregroundColor(.blue)
                        .onTapGesture {
                            self.bigModel.currentview = self.bigModel.lastViews.last ?? .AboutUsScreen
                            self.bigModel.lastViews.append(.ServiceClient_ServiceClientInfos)
                            print("back")
                        }
                                    
                    Spacer()
                    
                    Text("Suvi de commande")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "house")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.bigModel.currentview = .Home_homeFeed0
                        }
                    
                }
                
                if #available(iOS 16.0, *) {
                    List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                        Text("f")
                    }.listStyle(PlainListStyle())
                        .background(Color("Background"))
                        .scrollContentBackground(.hidden)
                } else {
                    // Fallback on earlier versions
                }
                 
                Spacer()
                
            }.padding(20)
        }
    }
}

struct ListeCommande_Previews: PreviewProvider {
    static var previews: some View {
        ListeCommande()
    }
}
