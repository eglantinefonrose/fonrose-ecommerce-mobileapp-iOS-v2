//
//  DetailedViewTest2.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 18/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct ServiceClientInfos: View {
    
    @EnvironmentObject var bigModel: BigModel
    @State var showReturn = false
    @State var showCard = false
    @State var showServices = false
    
    var body: some View {
                
        VStack { //VStack globale
            
            Spacer()
                .frame(height: 40)
                
            HStack {
            
                Spacer()
                    .frame(width: 30)
                
                Button(action: {
                    self.bigModel.currentview = .Home_homeFeed
                }) {
                    Text("Back")
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
            }
            
            Spacer()
                
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
            
            //MARK: Livraison
            
            VStack {//élément 3
                        ZStack {
                            
                            Button(action: {
                                self.bigModel.currentview = .ServiceClient_showDelivery
                                }) {
                                    HStack {
                                        Text("Livraison")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 28, weight: .medium, design: .default))
                                        
                                        Spacer()
                                        
                                        Image(systemName: "info.circle")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(.blue)
                                        
                                        Spacer()
                                            .frame(width: 70)
                                    }.frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
                                .padding(.leading, 80)
                        }
                }
                
                Spacer()
                    .frame(height: 20)
            
                ZStack {
                            
                    Button(action: {
                        self.bigModel.currentview = .ServiceClient_showSuiviDeCommande
                        }) {
                            HStack {
                                Text("Suivi en temps réel")
                                .foregroundColor(Color.white)
                                .font(.system(size: 28, weight: .medium, design: .default))
                                
                                Spacer()
                                
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.blue)
                                
                                Spacer()
                                    .frame(width: 70)
                                
                        }.frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
                        .padding(.leading, 80)
                    }
                }
                                
                Spacer()
                    .frame(height: 20)

                //MARK: Renvoi de colis
                
                VStack {//élement 3.3
                    
                    ZStack {
                                    
                        Button(action: {
                            self.bigModel.currentview = .ServiceClient_showReturn
                            }) {
                                
                            HStack {
                                Text("Renvoi de colis")
                                .foregroundColor(Color.white)
                                .font(.system(size: 28, weight: .medium, design: .default))
                                
                                Spacer()
                                
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.blue)
                                
                                Spacer()
                                    .frame(width: 70)
                            }
                        } } .frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
                                .padding(.leading, 80)
        }
        
            Spacer()//élement 4
                .frame(height: 20)
                    
            
            
            VStack {//élement 5
                //vstack avec fiche de livraison & service
                
                //VStack {//élement 5.1
                    //MARK: Fiche de livraison
                    
                    ZStack {
                    
                    Button(action: {
                        self.bigModel.currentview = .ServiceClient_showCard
                        }) {
                            
                            HStack {
                                Text("Fiche de livraison")
                                .foregroundColor(Color.white)
                                .font(.system(size: 28, weight: .medium, design: .default))
                                
                                Spacer()
                                
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.blue)
                                
                                Spacer()
                                    .frame(width: 70)
                            }
                        } }.frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
                        .padding(.leading, 80)
                
                    
                }
                
                //MARK: Service
                
                Spacer()
                .frame(height: 20)//élement 5.2
                
                VStack {
                    
                    ZStack {//élement 5.3
                    
                        VStack {
                        
                            Button(action: {
                                self.bigModel.currentview = .ServiceClient_showServices
                                }) {
                                    HStack {
                                        Text("Service client")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 28, weight: .medium, design: .default))
                                        
                                        Spacer()
                                        
                                        Image(systemName: "info.circle")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(.blue)
                                        
                                        Spacer()
                                            .frame(width: 70)
                                    }
                                }
                            } .frame(width: UIScreen.main.bounds.width, height: 40, alignment: .leading)
                            .padding(.leading, 80)
                        }
                    
                        
                }//fin VStack
            }
        
        Spacer()
        
            }.frame(width: UIScreen.main.bounds.width)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
        }
    }


struct ShowDeliveryView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
     
        VStack {
            
            Spacer()
                .frame(height: 30)
            
            ZStack {
               Button(action: {
                    self.bigModel.currentview = .ServiceClient_ServiceClientInfos
                }) {
                    Text("Back")
                }
            }.frame(width: UIScreen.main.bounds.width, height: 30, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
            
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
                                            
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(Color.black)
            .edgesIgnoringSafeArea(.all)

    }
    
}

struct showReturnView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
    
        VStack {
            
            Spacer()
                .frame(height: 30)
            
            ZStack {
                Button(action: {
                    self.bigModel.currentview = .ServiceClient_ServiceClientInfos
                }) {
                        Text("Back")
                    }
                }.frame(width: UIScreen.main.bounds.width, height: 30, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
            
            Spacer()
            
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
            
            }.frame(width: UIScreen.main.bounds.width, alignment: .center)
            
            Spacer()
                        
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct showCardView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        VStack {
            
            Spacer()
                .frame(height: 30)
            
            ZStack {
                Button(action: {
                    self.bigModel.currentview = .ServiceClient_ServiceClientInfos
                }) {
                        Text("Back")
                    }
                }.frame(width: UIScreen.main.bounds.width, height: 30, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
            
            Spacer()
            
            VStack {
            Text("Fiche")
                .font(.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(Color.white)
                                
            Text("complète de commande")
                .foregroundColor(Color.gray)
                .font(.system(size: 25, weight: .semibold, design: .default))
                .frame(alignment: .center)
                            
            Spacer()
                .frame(height: 100)
                                
            VStack {
                                    
                Text("N° de commande")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, design: .default))
                    .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .leading)
                                    
                Text("Date d’expedition prévue")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, design: .default))
                    .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .leading)
                    
                Text("Date de livraison")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, design: .default))
                    .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .leading)
                    
                Text("Nom du transporteur")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, design: .default))
                    .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .leading)
                    
                Text("N° de suivi")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, design: .default))
                    .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .leading)
                                    
            }.padding(.leading, 80)
            }.frame(width: UIScreen.main.bounds.width)
            
            Spacer()
                        
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ShowServicesView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        VStack {
            
            Spacer()
                .frame(height: 30)
            
            ZStack {
                Button(action: {
                    self.bigModel.currentview = .ServiceClient_ServiceClientInfos
                }) {
                        Text("Back")
                    }
                }.frame(width: UIScreen.main.bounds.width, height: 30, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
            
            Spacer()
            
            
            VStack {
                Text("Service")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .foregroundColor(Color.white)
                    .frame(alignment: .center)
                            
                Text("client")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 25, weight: .semibold, design: .default))
            }
            
            Spacer()
                
            ZStack {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
                    .foregroundColor(Color.gray)
                    
                VStack {
                    Text("24/7")
                        .font(.system(size: 35, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                        .frame(alignment: .center)
                    }
                }
            }
            .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        }
        
    }




        
struct DetailedViewTest2_Previews: PreviewProvider {
    static var previews: some View {
        ServiceClientInfos()
    }
}
