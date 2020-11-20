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
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
            
        // MARK: Livré
                    
        VStack {
            
            if model.status == .Livré {
            
            VStack {
                    
                    Spacer()
                        .frame(height: 40)
                        
                    HStack {
                    
                        Spacer()
                            .frame(width: 30)
                        
                        Button(action: {
                            self.bigModel.currentview = .ServiceClient_ServiceClientInfos
                        }) {
                            Text("Back")
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                    }
                        
                    
                        Spacer()
                            .frame(height: 100)
                    
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
                            .frame(height: 150)
                        
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
                            .frame(height:  22.5)
                        
                        ZStack {
                            
                            
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(width: UIScreen.main.bounds.width)
                            
                            VStack {
                                
                                Spacer()
                                    .frame(height: 22.5)
                                
                                Livre()
                                                                
                                Spacer()
                                
                            }
                        
                        }
                    
                    }
                
                }
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
                
                }//acolade fermante du 1er if
                
                // MARK: En cours d'expedition
            
                if model.status == .EnCoursDExpedition {
                
                    VStack {
                               
                        Spacer()
                            .frame(height: 40)
                            
                        HStack {
                        
                            Spacer()
                                .frame(width: 30)
                            
                            Button(action: {
                                self.bigModel.currentview = .ServiceClient_ServiceClientInfos
                            }) {
                                Text("Back")
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                            
                        }
                            
                        
                            Spacer()
                                .frame(height: 100)
                        
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
                            .frame(height: 150)
                            
                            VStack {
                                
                                PrisEnCharge()
                                
                                Spacer()
                                    .frame(height: 45)
                                
                                PretsAEtreExpedie()
                                
                                
                                
                            }.frame(width: UIScreen.main.bounds.width)
                            
                            Spacer()
                                .frame(height:  22.5)
                            
                            ZStack {
                                
                                
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .frame(width: UIScreen.main.bounds.width)
                                
                                VStack {
                                    
                                    Spacer()
                                        .frame(height: 22.5)
                                    
                                    EnCoursDExpedition()
                                    
                                    Spacer()
                                        .frame(height: 45)
                                    
                                    Livre()
                                                                    
                                    Spacer()
                                    
                                }
                            
                            }
                        
                        }
                    
                        
                    
                    }
                    .background(Color.black)
                    .edgesIgnoringSafeArea(.all)
                
                }//acolade fermante du 1er if
                
                        
                    if model.status == .PretsAEtreExpédié {
                    
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
                                    .frame(height: 100)
                                
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
                                    .frame(height: 150)
                                
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
                        .edgesIgnoringSafeArea(.all)
                
                    
             
                if model.status == .PrisEnCharge {
                            
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
                                .frame(height: 100)
                            
                            VStack {
                                
                                
                               VStack {
                                   Text("Suivax")
                                       .font(.system(size: 40, weight: .bold, design: .default))
                                       .foregroundColor(Color.white)
                                           
                                   Text("de colis en temps réel")
                                       .foregroundColor(Color.gray)
                                       .font(.system(size: 25, weight: .semibold, design: .default))
                               }
                                
                                Spacer()
                                .frame(height: 150)
                                            
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
                    .edgesIgnoringSafeArea(.all)
                }//acolade fermante du if "Pris en charge"
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

/*struct SuiviDeCommande_Previews: PreviewProvider {
    static var previews: some View {
        SuiviDeCommande(mamamia: true)
    }
}*/

}
