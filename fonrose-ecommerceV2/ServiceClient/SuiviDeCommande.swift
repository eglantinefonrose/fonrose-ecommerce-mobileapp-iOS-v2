//
//  SuiviDeCommande.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 09/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct SuiviDeCommande: View {
    
    var model: ParcelInfos
    let statuus: String

    
    var body: some View {

        List {
            
            // MARK: En cours d'expedition
            
            //if model.status == "En cours d'expedition" {
                        //Header()
            VStack {
                
                VStack {
                    VStack {
                    //Header()
                    
                    VStack {
                        Text("Prets à être expédié")
                            .foregroundColor(Color.white)
                            .font(.system(size: 27, weight: .semibold, design: .default))
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 80)
                                
                        Spacer()
                            .frame(height: 30)
                                
                        Text("Pris en charge")
                            .foregroundColor(Color.white)
                            .font(.system(size: 27, weight: .semibold, design: .default))
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 80)
                                
                        Spacer()
                            .frame(height: 30)
                        
                        Text("En cours d’expedition")
                                .foregroundColor(Color.white)
                                .font(.system(size: 27, weight: .semibold, design: .default))
                                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                                .padding(.leading, 80)
                            }
                        }
                    } .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-250)
                        
                    ZStack {
                                
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: UIScreen.main.bounds.width, height: 250, alignment: .bottom)
                            
                        VStack() {

                                
                        Text("Livré")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 27, weight: .semibold, design: .default))
                            .frame(width: UIScreen.main.bounds.width, height: 210, alignment: .topLeading)
                            .padding(.leading, 80) }
                            //.padding(.bottom)
                                
                        } .frame(width: UIScreen.main.bounds.width, height: 250, alignment: .bottom)
                        .foregroundColor(Color.blue)
                        
                    //}.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    //.padding(.vertical, -7)
            }
            .padding([.top, .leading])
            .background(Color.black)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            // MARK: Pris en charge
            
            //if model.status == "En cours d'expedition" {
            /*VStack {
                    VStack {
                        Text("Suivi")
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .foregroundColor(Color.white)
                            
                        Text("de colis en temps réel")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 25, weight: .semibold, design: .default))
                                    
                        Spacer()
                            .frame(height: 150)
                            
                        Text("Prets à être expédié")
                            .foregroundColor(Color.white)
                            .font(.system(size: 27, weight: .semibold, design: .default))
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 80)
                                
                        Spacer()
                            .frame(height: 30)
                                
                        Text("Pris en charge")
                            .foregroundColor(Color.white)
                            .font(.system(size: 27, weight: .semibold, design: .default))
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 80) }
                                
                        Spacer()
                           .frame(height: 20)
                        
                            ZStack {
                                
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: UIScreen.main.bounds.width, height: 280, alignment: .bottom)
                            
                                VStack {
                                    Text("En cours d’expedition")
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 27, weight: .semibold, design: .default))
                                        .frame(width: UIScreen.main.bounds.width, height: 30, alignment: .topLeading)
                                        .padding(.leading, 80)
                                    
                                    Spacer()
                                        .frame(height: 30)
                                
                                    Text("Livré")
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 27, weight: .semibold, design: .default))
                                        .frame(width: UIScreen.main.bounds.width, height: 30, alignment: .leading)
                                        .padding(.leading, 80)
                                    
                                } .frame(width: UIScreen.main.bounds.width, height: 280, alignment: .top)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                                
                            } .frame(width: UIScreen.main.bounds.width, height: 280, alignment: .bottom)
                            .foregroundColor(Color.red)
                        
                    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    .padding(.vertical, -7)
                    .background(Color.black)*/
        //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .padding(.vertical, -7)
                
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
        SuiviDeCommande(model: statusParcel()[0], statuus: "testtttt")
    }
}
