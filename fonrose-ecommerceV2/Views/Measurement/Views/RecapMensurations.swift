//
//  RecapMensurations.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 10/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct RecapMensurations: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
                                
            VStack {
                
                Spacer()
                    .frame(height: 100)
                
                HStack {
                    Spacer()
                        .frame(width: 50)
                    
                    Text("Recap")
                        .font(.system(size: 45, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                                        
                    RecapMensurationsTextStruct(recapMeasurementText: "Armpits Measurement", recapMeasurementText2: bigModel.armpitsMeasurement)
                        
                    RecapMensurationsTextStruct(recapMeasurementText: "Arms Length", recapMeasurementText2: bigModel.armsLength)
                    
                    RecapMensurationsTextStruct(recapMeasurementText: "Head Measurement", recapMeasurementText2: bigModel.headMeasurement)
                    
                    RecapMensurationsTextStruct(recapMeasurementText: "Pelvis knee", recapMeasurementText2: bigModel.pelvisKnee)
                    
                    RecapMensurationsTextStruct(recapMeasurementText: "Pelvis Measurement", recapMeasurementText2: bigModel.pelvisMeasurement)
                    
                    RecapMensurationsTextStruct(recapMeasurementText: "Shoulders measurement", recapMeasurementText2: bigModel.shouldersMeasurement)
                    
                    RecapMensurationsTextStruct(recapMeasurementText: "Shoulders Pelvis", recapMeasurementText2: bigModel.shouldersPelvis)
                        
                    }
                
                    Spacer()
                
                    VStack {
                    
                    Button(action: {
                        self.bigModel.currentview = .FinalizeOrderViews_Livraison
                        }) {
                            //Spacer()
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    HStack {
                                        
                                        Spacer()
                                        Text("Location")
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
                            
                        //Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 20)
                       
                    Button(action: {
                        self.bigModel.currentview = .Measurement_Mensurations
                    }) {
                        Text("Edit measurements")
                            .foregroundColor(Color.blue)
                    }
                    
                    Spacer()
                        .frame(height: 25)
                    
                }
                            
            }.background(Color.black)
                .edgesIgnoringSafeArea(.all)
    }
        
}

struct RecapMensurationsTextStruct: View {
    
    var recapMeasurementText: String
    var recapMeasurementText2: String
    
    var body : some View {
        
        VStack {
            HStack {
                
            Spacer()
                .frame(width: 50)
                               
                Text(recapMeasurementText)
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, design: .default))
                    .frame(height: 50, alignment: .leading)
                               
                Spacer()
                               
                Text(recapMeasurementText2)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 20, design: .default))
                    .frame(height: 50, alignment: .leading)
                               
                Spacer()
                    .frame(width: 50)
            
            }
            
            Spacer()
                .frame(height: 7)
        }
        
    }
    
}

struct RecapMensurations_Previews: PreviewProvider {
    static var previews: some View {
        RecapMensurations()
    }
}
