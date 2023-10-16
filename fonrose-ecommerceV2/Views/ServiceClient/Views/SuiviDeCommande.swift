//
//  SuiviDeCommande.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 09/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct OrdersExample: Identifiable {
    var id: Int
    var name: String
}

@available(iOS 16.0, *)
struct SuiviDeCommande: View {
    
    @EnvironmentObject var bigModel: BigModel
    @Environment(\.colorScheme) var colorScheme
    var order: BigModel.Order
    
    
    var body: some View {
            
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                BackButtonModel(text: "tracking-control")
                    .padding(20)
                
                VStack(spacing: 0) {
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.gray)
                        HStack {
                            Text("order-saved")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            Image(systemName: "checkmark.circle")
                        }
                        .padding(.horizontal, 15)
                    }
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(order.status != .CommandeEnregistree ? .gray : Color("Background"))
                        HStack {
                            Text("in-preparation")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            if order.status != .CommandeEnregistree {
                                Image(systemName: "checkmark.circle")
                            }
                        }.padding(.horizontal, 15)
                    }
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(order.status == .Arrived || order.status == .Recieved || order.status == .Expedie ? .gray : Color("Background"))
                        HStack {
                            Text("in-shipment")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            if order.status == .Recieved || order.status == .Expedie {
                                Image(systemName: "checkmark.circle")
                            }
                        }.padding(.horizontal, 15)
                    }
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(order.status == .Arrived || order.status == .Recieved ? .gray : Color("Background"))
                        HStack {
                            Text("arrived")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            if order.status == .Arrived || order.status == .Recieved {
                                Image(systemName: "checkmark.circle")
                            }
                        }.padding(.horizontal, 15)
                    }
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(order.status == .Recieved ? .gray : Color("Background"))
                        HStack {
                            Text("recieved")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            if order.status == .Recieved {
                                Image(systemName: "checkmark.circle")
                            }
                        }.padding(.horizontal, 15)
                    }
                    
                }
                
                VStack(spacing: 10) {
                    if order.status == .CommandeEnregistree {
                        Text("\("status%@") : \("order-saved")")
                            .font(.title3)
                    }
                    if order.status == .Expedie {
                        Text("\("status%@") : \("shipped")")
                            .font(.title3)
                    }
                    if order.status == .Recieved {
                        Text("\("status%@") : \("recieved")")
                            .font(.title3)
                    }
                    if order.status == .EnCoursDePrep {
                        Text("\("status%@") : \("in-preparation")")
                            .font(.title3)
                    }
                    if order.status == .Arrived {
                        Text("\("status%@") : \("arrived")")
                            .font(.title3)
                    }
                    
                    Text("more-about-the-delivery")
                        .foregroundColor(.blue)
                    
                    HStack {
                        Spacer()
                        Text("save")
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                            .padding(10)
                        Spacer()
                    }.background(Color.blue)
                    .cornerRadius(15)
                    .padding(20)
                    
                }
                
            }
            
        }
        
    }
}


struct EnCoursDExpedition: View {
    var body : some View {
        HStack {
            
            Spacer()
                .frame(width: 30)
            
             Text("En cours d’expedition")
                 .foregroundColor(Color.white)
                 .font(.system(size: 27, weight: .semibold, design: .default))
            
            Spacer()
            
        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}

struct PrisEnCharge: View {
    var body : some View {
        HStack {
            
            Spacer()
                .frame(width: 30)
            
             Text("order-saved")
                 .foregroundColor(Color.white)
                 .font(.system(size: 27, weight: .semibold, design: .default))
            
            Spacer()
            
        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}

struct PretsAEtreExpedie: View {
    var body : some View {
        HStack {
            
            Spacer()
                .frame(width: 30)
            
             Text("Prets à être expédié")
                 .foregroundColor(Color.white)
                 .font(.system(size: 27, weight: .semibold, design: .default))
            
            Spacer()
            
        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}

struct Livre: View {
    var body : some View {
        HStack {
            
            Spacer()
                .frame(width: 30)
            
             Text("Livré")
                 .foregroundColor(Color.white)
                 .font(.system(size: 27, weight: .semibold, design: .default))
            
            Spacer()
                        
        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}

struct Header: View {
    
    var body: some View {
    
        VStack {
            Text("Suivi")
            .font(.system(size: 40, weight: .bold, design: .default))
            .foregroundColor(Color.white)
            
        Text("de colis en temps réel")
            .foregroundColor(Color.gray)
            .font(.system(size: 25, weight: .semibold, design: .default))
                    
        Spacer()
            .frame(height: 150)
        }
    }
}

struct SuiviDeCommande_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            SuiviDeCommande( order: BigModel.Order(productName: "Robe", status: .EnCoursDePrep, location: BigModel.Location(civility: "", firstName: "", lastName: "", emailAdress: "", phoneNumber: "", adressCountry: "", adressPostalCode: "", adressCity: "", adressStreet: "", adressMailBox: "", adressBasement: "", adressStage: ""), measurements: BigModel.Measurements(measurements: []), orderDate: .now))
                .environmentObject(BigModel(shouldInjectMockedData: true))
        } else {
            // Fallback on earlier versions
        }
    }
}

