//
//  RecapMensurations.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 10/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct RecapMensurations: View {
    
    var model: MeasurementInfos
    var body: some View {
        
        VStack {
            
            Spacer()
            
            NavigationView {
                VStack {
                
                Spacer()
                    .frame(height: 120)
                
                HStack {
                    Spacer()
                        .frame(width: 50)
                    
                    Text("Renvoi")
                        .font(.system(size: 45, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            
                        Spacer()
                            .frame(width: 50)
                                           
                            Text("Armpits Measurement")
                                .foregroundColor(Color.white)
                                .font(.system(size: 20, design: .default))
                                .frame(height: 50, alignment: .leading)
                                           
                            Spacer()
                                           
                            Text(model.ArmpitsMeasurement)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 20, design: .default))
                                .frame(height: 50, alignment: .leading)
                                           
                            Spacer()
                                .frame(width: 50)
                        
                        }
                        
                        Spacer()
                            .frame(height: 7)
                    }
                    

                    
                    VStack {
                        
                        VStack {
                            HStack {
                            
                            Spacer()
                                .frame(width: 50)
                                               
                                Text("Arms Length")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, design: .default))
                                    .frame(height: 50, alignment: .leading)
                                               
                                Spacer()
                                               
                                Text(model.ArmsLength)
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 20, design: .default))
                                    .frame(height: 50, alignment: .leading)
                                               
                                Spacer()
                                    .frame(width: 50)
                            }
                            
                            Spacer()
                                .frame(height: 7)
                        }
                        
                        VStack {
                            HStack {
                            
                            Spacer()
                                .frame(width: 50)
                                               
                                Text("Head Measurement")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, design: .default))
                                    .frame(height: 50, alignment: .leading)
                                               
                                Spacer()
                                               
                                Text(model.HeadMeasurement)
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 20, design: .default))
                                    .frame(height: 50, alignment: .leading)
                                               
                                Spacer()
                                    .frame(width: 50)
                            }
                            
                            Spacer()
                                .frame(height: 7)
                        }
                        
                        
                        
                        VStack {
                            HStack {
                            
                            Spacer()
                                .frame(width: 50)
                                               
                                Text("Pelvis knee")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, design: .default))
                                    .frame(height: 50, alignment: .leading)
                                               
                                Spacer()
                                               
                                Text(model.PelvisKnee)
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 20, design: .default))
                                    .frame(height: 50, alignment: .leading)
                                               
                                Spacer()
                                    .frame(width: 50)
                            }
                            
                            Spacer()
                                .frame(height: 7)
                        }
                        
                        VStack {
                            HStack {
                            
                            Spacer()
                                .frame(width: 50)
                                               
                                Text("Pelvis Measurement")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, design: .default))
                                    .frame(height: 50, alignment: .leading)
                                               
                                Spacer()
                                               
                                Text(model.PelvisMeasurement)
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 20, design: .default))
                                    .frame(height: 50, alignment: .leading)
                                               
                                Spacer()
                                    .frame(width: 50)
                            }
                            
                            Spacer()
                                .frame(height: 7)
                        }
                        
                        VStack {
                            HStack {
                            
                            Spacer()
                                .frame(width: 50)
                                               
                                Text("Shoulders measurement")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, design: .default))
                                    .frame(height: 50, alignment: .leading)
                                               
                                Spacer()
                                               
                                Text(model.ShouldersMeasurement)
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 20, design: .default))
                                    .frame(height: 50, alignment: .leading)
                                               
                                Spacer()
                                    .frame(width: 50)
                            }
                            
                            Spacer()
                                .frame(height: 7)
                        }
                        
                        VStack {
                            HStack {
                            
                            Spacer()
                                .frame(width: 50)
                                               
                                Text("Shoulders Pelvis")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, design: .default))
                                    .frame(height: 50, alignment: .leading)
                                               
                                Spacer()
                                               
                                Text(model.ShouldersPelvis)
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 20, design: .default))
                                    .frame(height: 50, alignment: .leading)
                                               
                                Spacer()
                                    .frame(width: 50)
                            }
                            
                        }
                    }
                    
                    Spacer()
                        
                    }
                
                    VStack {
                    
                    NavigationLink(destination: LocationView()) {
                        
                    Spacer()
                        
                        HStack {
                            
                            Spacer()
                            
                            HStack {
                                
                                Spacer()
                                Text("Paiement")
                                    .foregroundColor(Color.white)
                                    .fontWeight(.semibold)
                                Spacer()
                            
                            }.background(Color.blue)
                            .frame(width: 150)
                            .cornerRadius(5)
                            
                            Spacer()
                            
                        }.frame(width: 120, height: 35)
                        .background(Color.blue)
                        .cornerRadius(15)
                    
                    Spacer()
                        
                    }
                    
                    Spacer()
                        .frame(height: 25)
                    
                    NavigationLink(destination: Mensurations(model: model)) {
                        Text("Modifier mes mesures")
                            .foregroundColor(.blue)
                    }
                }
                
                Spacer()
                .frame(height: 60)
                    
                }.edgesIgnoringSafeArea(.all)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .background(Color.black)
                //.padding(.vertical, -44)
            
            }.padding(.top, -16)
            
            Spacer()
            
        }
        
    }
        
}


struct RecapMensurations_Previews: PreviewProvider {
    static var previews: some View {
        RecapMensurations(model: Measurement[0])
    }
}
