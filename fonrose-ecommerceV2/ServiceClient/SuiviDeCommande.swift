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
            
        // MARK: En cours d'expedition
        
            // MARK: En cours d'expedition
            
        VStack {
            
            if model.status == "Livré" {
            
            VStack {
            
                    Spacer()
                    .frame(height: 150)
                
                    VStack {
                        
                        
                       VStack {
                           Text("Suivi")
                               .font(.system(size: 40, weight: .bold, design: .default))
                               .foregroundColor(Color.white)
                                   
                           Text("de colis en temps réel")
                               .foregroundColor(Color.gray)
                               .font(.system(size: 25, weight: .semibold, design: .default))
                       }
                        
                        Spacer()
                            .frame(height: 225)
                        
                        VStack {
                            
                            PrisEnCharge()
                            
                            Spacer()
                                .frame(height: 45)
                            
                            PretsAEtreExpedie()
                            
                            Spacer()
                                .frame(height: 45)
                            
                            EnCoursDExpedition()
                            
                        }.frame(width: UIScreen.main.bounds.width)
                        
                        Spacer()
                            .frame(height: 45)
                                        
                        ZStack {
                            
                            Spacer()
                                .frame(height: 45)
                            
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(width: UIScreen.main.bounds.width)
                            
                            VStack {
                                
                                Spacer()
                                    .frame(height: 30)
                                
                                Livre()
                                
                                Spacer()
                                
                            }
                        
                        }
                    }
            
                }.background(Color.black)
                .padding(EdgeInsets(top: -8, leading: 0, bottom: -8, trailing: 0))
                .edgesIgnoringSafeArea(.all)
            
            }//acolade fermante du 1er if
            
            if model.status == "En cours d'expedition" {
                
                VStack {
                
                        Spacer()
                        .frame(height: 150)
                    
                        VStack {
                            
                            
                            VStack {
                                Text("Suivi")
                                    .font(.system(size: 40, weight: .bold, design: .default))
                                    .foregroundColor(Color.white)
                                        
                                Text("de colis en temps réel")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 25, weight: .semibold, design: .default))
                            }
                            
                            Spacer()
                                .frame(height: 225)
                            
                            VStack {
                                
                                PrisEnCharge()
                                
                                Spacer()
                                    .frame(height: 45)
                                
                                PretsAEtreExpedie()
                                
                            }.frame(width: UIScreen.main.bounds.width)
                            
                            Spacer()
                                .frame(height: 45)
                                            
                            ZStack {
                                
                                Spacer()
                                    .frame(height: 45)
                                
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .frame(width: UIScreen.main.bounds.width)
                                
                                VStack {
                                    
                                    Spacer()
                                        .frame(height: 30)
                                    
                                    EnCoursDExpedition()
                                    
                                    Spacer()
                                        .frame(height: 45)
                                    
                                    Livre()
                                    
                                    Spacer()
                                    
                                }
                            
                            }
                        }
                
                    }.background(Color.black)
                    .padding(EdgeInsets(top: -8, leading: 0, bottom: -8, trailing: 0))
                    .edgesIgnoringSafeArea(.all)
                
                }//acolade fermante du 1er if
            
            if model.status == "Prets à être expédié" {
                
                VStack {
                
                        Spacer()
                        .frame(height: 150)
                    
                        VStack {
                            
                            
                            VStack {
                                Text("Suivi")
                                    .font(.system(size: 40, weight: .bold, design: .default))
                                    .foregroundColor(Color.white)
                                        
                                Text("de colis en temps réel")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 25, weight: .semibold, design: .default))
                            }
                            
                            Spacer()
                                .frame(height: 225)
                            
                            VStack {
                                
                                PrisEnCharge()
                                
                            }.frame(width: UIScreen.main.bounds.width)
                            
                            Spacer()
                                .frame(height: 45)
                                            
                            ZStack {
                                
                                Spacer()
                                    .frame(height: 45)
                                
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .frame(width: UIScreen.main.bounds.width)
                                
                                VStack {
                                    
                                    Spacer()
                                        .frame(height: 30)
                                    
                                    PretsAEtreExpedie()
                                    
                                    Spacer()
                                        .frame(height: 45)
                                    
                                    EnCoursDExpedition()
                                    
                                    Spacer()
                                        .frame(height: 45)
                                    
                                    Livre()
                                    
                                    Spacer()
                                    
                                }
                            
                            }
                        }
                
                    }.background(Color.black)
                    .padding(EdgeInsets(top: -8, leading: 0, bottom: -8, trailing: 0))
                    .edgesIgnoringSafeArea(.all)
                
                }//acolade fermante du 1er if
            
            if model.status == "Pris en charge" {
            
            VStack {
            
                    Spacer()
                    .frame(height: 150)
                
                    VStack {
                        
                        
                        VStack {
                            Text("Suivi")
                                .font(.system(size: 40, weight: .bold, design: .default))
                                .foregroundColor(Color.white)
                                    
                            Text("de colis en temps réel")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 25, weight: .semibold, design: .default))
                        }
                        
                        Spacer()
                            .frame(height: 225+45)
                                        
                        ZStack {
                            
                            Spacer()
                                .frame(height: 45)
                            
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(width: UIScreen.main.bounds.width)
                            
                            VStack {
                                
                                Spacer()
                                    .frame(height: 30)
                                
                                PrisEnCharge()
                                
                                Spacer()
                                    .frame(height: 45)
                                
                                PretsAEtreExpedie()
                                
                                Spacer()
                                    .frame(height: 45)
                                
                                EnCoursDExpedition()
                                
                                Spacer()
                                    .frame(height: 45)
                                
                                Livre()
                                
                                Spacer()
                                
                            }
                        
                        }
                    }
            
                }.background(Color.black)
                .padding(EdgeInsets(top: -8, leading: 0, bottom: -8, trailing: 0))
                .edgesIgnoringSafeArea(.all)
            
            }//acolade fermante du 1er if
            
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
            
             Text("Pris en charge")
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
        SuiviDeCommande(model: statusParcel()[2], statuus: "testtttt")
    }
}
