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
            
            VStack {
                
                VStack(spacing: 20) {
                    
                    BackButtonModel(text: "Informations", viewName: .HelpView)
                    
                    Spacer()
                    
                    Text("Informations")
                        .font(.system(size: 35, weight: .bold, design: .default))
                    
                    Spacer()
                    
                    if #available(iOS 16.0, *) {
                            
                        ScrollView {
                            
                            VStack() {
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text("persons")
                                        .font(Font.title.weight(.semibold))
                                    
                                    Text("persons-explanations")
                                    
                                }.padding(.vertical, 10)
                                
                            }.background(Color("Background"))
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            
                            
                            VStack() {
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text("measurements")
                                        .font(Font.title.weight(.semibold))
                                    
                                    Text("measurements-explanations")
                                    
                                    
                                    //Text("Pour chaque produit, des ") + Text("mensurations").bold() + Text(" spécifiques à l’article sélectionné vous sont demandées afin de préparer votre commande. Des") + Text(" vidéos explicatives ").bold() + Text("pour prendre au mieux ses mensurations sont à votre disposition pour vous aider.")
                                        //.multilineTextAlignment(.leading)
                                    
                                }.padding(.vertical, 10)
                                
                            }.background(Color("Background"))
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            
                            
                            
                        }
                        
                    } else {
                        // Fallback on earlier versions
                    }
                }
                    
                Spacer()
                    
                VStack {
                    HStack {
                        VStack {
                            Image(systemName: "chevron.down")
                            Image(systemName: "chevron.down")
                        }
                        Text("Scroll down to see every informations")
                    }
                    
                    HStack {
                        Spacer()
                        Text("Start creating persons")
                            .foregroundColor(Color.white)
                            .padding(10)
                        Spacer()
                    }.background(Color.blue)
                    .cornerRadius(15)
                    .onTapGesture {
                        bigModel.currentview = .Auth_AuthView
                        bigModel.authCurrentView = .Auth_PersonPickerView
                        bigModel.lastViews.append(.HelpView)
                        bigModel.fullViewHistory.append(.HelpView)
                    }
                }
                
            }.padding(20)
                
        }
        
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
            .environmentObject(BigModel(shouldInjectMockedData: true))
    }
}
