//
//  DetailedViewTest2.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 18/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct ServiceClientModel: Identifiable, Hashable {
    var id: Int
    var text: String
    var nextView: ViewEnum
}

@available(iOS 14.0, *)
struct ServiceClientInfos: View {
    
    let serviceClient = [ServiceClientModel(id: 0, text: "Livraison", nextView: .ServiceClient_showDelivery), ServiceClientModel(id: 1, text: "Suivi en temps réel", nextView: .ServiceClient_showOrdersList), ServiceClientModel(id: 2, text: "Renvoi de colis", nextView: .ServiceClient_showReturn), ServiceClientModel(id: 3, text: "Fiche de livraison", nextView: .ServiceClient_showCard), ServiceClientModel(id: 4, text: "Service client", nextView: .ServiceClient_showServices)]
    let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
    
    @Environment(\.colorScheme) var theColorScheme
    @EnvironmentObject var bigModel: BigModel
    @State var showReturn = false
    @State var showCard = false
    @State var showServices = false
    
    var body: some View {
                
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack { //VStack globale
                  
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
                    
                    Text("Informations client")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "house")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.bigModel.currentview = .Home_homeFeed0
                        }
                    
                }.padding(20)
                
                Spacer()
                    
                 VStack {//élement 1
                           
                       Text("Informations client")
                           .font(.system(size: 35, weight: .bold, design: .default))
                           .frame(alignment: .center)
                           
                       Text("Questions fréquentes")
                           .foregroundColor(Color.gray)
                           .font(.system(size: 25, weight: .semibold, design: .default))
                           
                 }
                       
                Spacer()
                    //.frame(height: 150)//élement 2
                
                //MARK: Livraison
                
                LazyVGrid(columns: columns) {
                    
                    ForEach(serviceClient, id: \.self) { serviceClient in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 150)
                                .foregroundColor(.blue)
                            VStack(alignment: .leading) {
                                Image(systemName: "shippingbox")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 40, height: 40)
                                Text(serviceClient.text)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                        }.onTapGesture {
                            self.bigModel.currentview = serviceClient.nextView
                            self.bigModel.lastViews.append(.ServiceClient_ServiceClientInfos)
                        }
                    }
                }.padding(.horizontal, 20)
                
                /*VStack(spacing: 40) {//élément 3
                                
                    HStack {
                        Text("Livraison")
                            .font(.system(size: 28, weight: .medium, design: .default))
                            
                        Spacer()
                            
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.blue)
                        
                    }.padding(.horizontal, 20)
                    .onTapGesture {
                        self.bigModel.currentview = .ServiceClient_showDelivery
                        self.bigModel.lastViews.append(.ServiceClient_ServiceClientInfos)
                    }
                    
                    HStack {
                        Text("Suivi en temps réel")
                        .font(.system(size: 28, weight: .medium, design: .default))
                        
                        Spacer()
                        
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.blue)
                        
                    }.padding(.horizontal, 20)
                    .onTapGesture {
                            self.bigModel.currentview = .ServiceClient_showSuiviDeCommande
                            self.bigModel.lastViews.append(.ServiceClient_ServiceClientInfos) }
                    //MARK: Renvoi de colis
                    
                        
                    HStack {
                        Text("Renvoi de colis")
                        .font(.system(size: 28, weight: .medium, design: .default))
                            
                        Spacer()
                        
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.blue)
                            
                        }.padding(.horizontal, 20)
                        .onTapGesture {
                            self.bigModel.currentview = .ServiceClient_showReturn
                            self.bigModel.lastViews.append(.ServiceClient_ServiceClientInfos)
                    }
                    HStack {
                        Text("Fiche de livraison")
                        .font(.system(size: 28, weight: .medium, design: .default))
                        
                        Spacer()
                        
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.blue)
                        
                    }.padding(.horizontal, 20)
                    .onTapGesture {
                        self.bigModel.currentview = .ServiceClient_showCard
                        self.bigModel.lastViews.append(.ServiceClient_ServiceClientInfos)
                        }
                    
                    //MARK: Service
                        HStack {
                            Text("Service client")
                            .font(.system(size: 28, weight: .medium, design: .default))
                            
                            Spacer()
                            
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                        }.padding(.horizontal, 20)
                        .onTapGesture {
                            self.bigModel.currentview = .ServiceClient_showServices
                            self.bigModel.lastViews.append(.ServiceClient_ServiceClientInfos)
                        }
                }*/
            
            Spacer()
            
            }
        }
        }
    }


struct ShowDeliveryView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
     
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                BackButtonModel(text: "")
                
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
                                                
            }.padding(20)
        }

    }
    
}

struct showReturnView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
    
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                BackButtonModel(text: "")
                
                Spacer()
                
                VStack {
                    
                    Text("Renvoi")
                        .font(.system(size: 40, weight: .bold, design: .default))
                                        
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
                            
            }.padding(20)
        }
    }
}

struct showCardView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                BackButtonModel(text: "")
                
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
                            
            }.padding(20)
        }
    }
}

struct ShowServicesView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                BackButtonModel(text: "")
                
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
                }.padding(20)
            }
        }
        
    }




        
struct DetailedViewTest2_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            ServiceClientInfos()
        } else {
            // Fallback on earlier versions
        }
    }
}
