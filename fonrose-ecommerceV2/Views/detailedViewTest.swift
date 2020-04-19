//
//  detailedViewTest.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 07/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct detailedViewTest: View {

    @State var showDelivery = false
    @State var showReturn = false
    @State var showCard = false
    var parcel: ParcelInfos
    
    var body: some View {
            
    VStack {
        
        VStack {
            
        Text("Informations client")
            .font(.system(size: 35, weight: .bold, design: .default))
            .foregroundColor(Color.white)
            .frame(alignment: .center)
            
        Text("Questions fréquentes")
            .foregroundColor(Color.gray)
            .font(.system(size: 25, weight: .semibold, design: .default))
            
        }
            
            // MARK: Suivi de colis
        
        Spacer()
            .frame(height: 100)
            
        /*VStack {
            ZStack {
                NavigationLink(destination: SuiviDeCommande(model: statusParcel()[0], statuus: "toz"), label: {
                    Text("fekir")
                })
                    Text("Suivi en temps réel")
                        .foregroundColor(Color.white)
                        .font(.system(size: 21, weight: .medium, design: .default))
                } .frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
            }*/
                
            Spacer()
                .frame(height: 20)
                
            // MARK: Livraison
                
            ZStack {
                Button(action: {
                    self.showDelivery.toggle()
                }) {
                if showDelivery == false {
                    Text("Livraison")
                        .foregroundColor(Color.white)
                        .font(.system(size: 21, weight: .medium, design: .default))
                    }
                else {
                    }
            } } .frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
                
            if showDelivery {
                VStack {
    
                    ZStack {
                        Button(action: {
                            self.showDelivery.toggle()
                        }) {
                            Text("Back")
                        }
                    }.frame(width: UIScreen.main.bounds.width, height: 30, alignment: .topLeading)
                    .padding(EdgeInsets(top: (-UIScreen.main.bounds.height/2)+80, leading: 35, bottom: 0, trailing: 0))
                    
                    Text("Livraison")
                    //.font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                            
                    Text("en collaboration avec")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 25, weight: .semibold, design: .default))
                    
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    .background(Color.black)
                    .padding(EdgeInsets(top: -418, leading: -80, bottom: 0, trailing: 0))
                
                
            }
                
            Spacer()
                .frame(height: 20)
                
            // MARK: Renvoi de colis
        
            ZStack {
                
                Button(action: {
                        self.showReturn.toggle()
                    }) {
                    if showReturn == false {
                        Text("Renvoi de colis")
                            .foregroundColor(Color.white)
                            .font(.system(size: 21, weight: .medium, design: .default))
                        }
                    else {
                        }
                } } .frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
                
            //Spacer()
                //.frame(height: 20)
        
                if showReturn {
                    VStack {
                        ZStack {
                            Button(action: {
                                self.showReturn.toggle()
                            }) {
                                Text("Back")
                            }
                        }.frame(width: UIScreen.main.bounds.width, height: 30, alignment: .topLeading)
                        .padding(EdgeInsets(top: (-UIScreen.main.bounds.height/2)+80, leading: 35, bottom: 0, trailing: 0))
                        
                            Text("Renvoi")
                                .font(.system(size: 40, weight: .bold, design: .default))
                                .foregroundColor(Color.white)
                                            
                            Text("de colis")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 25, weight: .semibold, design: .default))
                                        
                            Spacer()
                                .frame(height: 40)
                                        
                            Text("Renvoi gratuit et produit remboursé après le renvoi du produit")
                                .foregroundColor(Color.gray)
                                //.font(.system(size: 20, weight: .light, design: .default))
                                .frame(width: UIScreen.main.bounds.width-60)
                        
                    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                        .background(Color.black)
                        .padding(EdgeInsets(top: -418, leading: -80, bottom: 0, trailing: 0))

                }
                                
                //Spacer()
                    //.frame(height: 20)
                        
                // MARK: Suivi d'expedition
                        
                ZStack {
                    Button(action: {
                        self.showCard.toggle()
                    }) {
                    if showCard == false {
                        Text("Livraison")
                            .foregroundColor(Color.white)
                            .font(.system(size: 21, weight: .medium, design: .default))
                        }
                    else {
                        }
                } .frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
            }
                                        
                    VStack {
            
                        ZStack {
                            Button(action: {
                                self.showDelivery.toggle()
                            }) {
                                Text("Back")
                            }
                        }.frame(width: UIScreen.main.bounds.width, height: 30, alignment: .topLeading)
                        .padding(EdgeInsets(top: (-UIScreen.main.bounds.height/2)+80, leading: 35, bottom: 0, trailing: 0))
                        
                        VStack {
                            Text("Livraison")
                            //.font(.system(size: 40, weight: .bold, design: .default))
                                .foregroundColor(Color.white)
                                        
                            Text("en collaboration avec")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 25, weight: .semibold, design: .default))
                        }
                    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    .background(Color.black)
                    .padding(EdgeInsets(top: -418, leading: -80, bottom: 0, trailing: 0))
                
                }
                    
            // MARK: Suivi d'expedition
        
        
            /*ZStack {
                    Button(action: {
                        self.showCard.toggle()
                    }) {
                    if showCard == false {
                        Text("Fiche de commande")
                            .foregroundColor(Color.white)
                            .font(.system(size: 21, weight: .medium, design: .default))
                        }
                    else {
                        }
                }
            }.frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)*/
        
                //}acolade fermante du if
            }
        }

struct detailedViewTest_Previews: PreviewProvider {
    static var previews: some View {
        SuiviDeCommande(model: statusParcel()[0], statuus: "testt")
        }
    }

