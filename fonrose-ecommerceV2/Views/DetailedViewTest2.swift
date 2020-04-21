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
    @State var showServices = false
    var parcel: ParcelInfos
    
    var body: some View {
        //NavigationView {
        VStack { //VStack globale
            
            Spacer()
                .frame(height: 100)
            
             VStack {//élement 1
                       
                   Text("Informations client")
                       .font(.system(size: 35, weight: .bold, design: .default))
                       .foregroundColor(Color.white)
                       .frame(alignment: .center)
                       
                   Text("Questions fréquentes")
                       .foregroundColor(Color.gray)
                       .font(.system(size: 25, weight: .semibold, design: .default))
                       
             }
                   
            Spacer()
                .frame(height: 150)//élement 2
                       
            VStack { //vstack de livraison & renvoi de colis //élement 3
                
                //MARK: Livraison
                
                VStack { //élement 3.1
                    
                        ZStack {
                        
                        Button(action: {
                                self.showCard.toggle()
                            }) {
                            if showCard == false {
                                Text("Fiche de livraison")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 28, weight: .medium, design: .default))
                                }
                            else {
                                }
                            } }.frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
                            .padding(.leading, 80)
                    
                    if showDelivery {
                        VStack {
                            VStack {
                                ZStack {
                                    Button(action: {
                                        self.showDelivery.toggle()
                                    }) {
                                        Text("Back")
                                    }
                                }.frame(width: UIScreen.main.bounds.width, height: 30, alignment: .leading)
                                .padding(EdgeInsets(top: 40, leading: 40, bottom: 0, trailing: 0))
                                
                                Spacer()
                                
                                VStack {
                                    Text("Livraison")
                                    .font(.system(size: 40, weight: .bold, design: .default))
                                    .foregroundColor(Color.white)
                                            
                                    Text("en collaboration avec")
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 25, weight: .semibold, design: .default))
                                }
                                
                                Spacer()
                                
                            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                        }.edgesIgnoringSafeArea(.all)
                    }
                                    
                        }//acollade fermante de la VStack
                
                 }
                                
                Spacer()
                    .frame(height: 20)

                //MARK: Renvoi de colis
                
                VStack {//élement 3.3
                    
                    
                    
                        ZStack {
                                    
                            Button(action: {
                                self.showReturn.toggle()
                                }) {
                                if showReturn == false {
                                Text("Renvoi de colis")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 28, weight: .medium, design: .default))
                                }
                                    else {
                                    }
                                } } .frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
                                    .padding(.leading, 80)
                                    
                                if showReturn {
                                    VStack {
                                        ZStack {
                                            Button(action: {
                                                self.showReturn.toggle()
                                            }) {
                                                Text("Back")
                                            }
                                        }.frame(width: UIScreen.main.bounds.width, height: 30, alignment: .leading)
                                            .padding(EdgeInsets(top: 40, leading: 40, bottom: 0, trailing: 0))
                                        
                                        VStack {
                                            
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
                                    
                    }//acolade de la VStack du if return
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.green)
                    
            }//acolade du if
        }
        
            Spacer()//élement 4
                .frame(height: 20)
                    
            
            
            VStack {//élement 5
                //vstack avec fiche de livraison & service
                
                //VStack {//élement 5.1
                    //MARK: Fiche de livraison
                    
                    ZStack {
                    
                    Button(action: {
                            self.showCard.toggle()
                        }) {
                        if showCard == false {
                            Text("Fiche de livraison")
                                .foregroundColor(Color.white)
                                .font(.system(size: 28, weight: .medium, design: .default))
                            }
                        else {
                            }
                        } }.frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
                        .padding(.leading, 80)
                
                if showCard {
                    VStack {
                        VStack {
                            ZStack {
                                Button(action: {
                                    self.showCard.toggle()
                                }) {
                                    Text("Back")
                                }
                            }.frame(width: UIScreen.main.bounds.width, height: 30, alignment: .leading)
                            .padding(EdgeInsets(top: 40, leading: 40, bottom: 0, trailing: 0))
                            
                            Spacer()
                            
                            VStack {
                                Text("Livraison")
                                //.font(.system(size: 40, weight: .bold, design: .default))
                                    .foregroundColor(Color.white)
                                        
                                Text("en collaboration avec")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 25, weight: .semibold, design: .default))
                            }
                            
                            Spacer()
                            
                        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    }.edgesIgnoringSafeArea(.all)
                }
                
                //MARK: Service
                
                Spacer()
                .frame(height: 20)//élement 5.2
                
                VStack {//élement 5.3
                    
                    
                    ZStack {
                    
                        Button(action: {
                                self.showServices.toggle()
                            }) {
                            if showServices == false {
                                Text("Service client")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 28, weight: .medium, design: .default))
                                }
                            else {
                                    }
                                    }
                            } .frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
                            .padding(.leading, 80)
                        }
                
                
                    }//acolade fermante de la VStack fiche + service
            
            Spacer()
            
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.black)
                
        }
        //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        //.padding(EdgeInsets(top: -100, leading: 0, bottom: 0, trailing: 0))
    }



        
struct DetailedViewTest2_Previews: PreviewProvider {
    static var previews: some View {
        DetailedViewTest2(parcel: statusParcel()[0])
    }
}
