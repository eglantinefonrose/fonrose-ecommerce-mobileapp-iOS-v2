//
//  PaymentScreen.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 10/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct PaymentScreen: View {

    @EnvironmentObject var bigModel: BigModel
    @State var isArmpitsMeasurementNil: Bool = false
    @State var isArmsLengthNil: Bool = false
    @State var isheadMeasurementNil: Bool = false
    @State var isPelvisKneeNil: Bool = false
    @State var isPelvisMeasurementNil: Bool = false
    @State var isShouldersMeasurementNil: Bool = false
    @State var isShouldersPelvisNil: Bool = false
    @State var isModifyMeasurementButtonBlue: Bool = false
    
    @available(iOS 14.0, *)
    var body: some View {
        
        ZStack {
            VStack {
                    
                VStack {
                                                
                    Spacer()
                        .frame(height: 80)
                        
                        HStack {
                            Spacer()
                                .frame(width: 50)
                            
                            Text("Paiement")
                                .font(.system(size: 45, weight: .bold, design: .default))
                                .foregroundColor(Color.white)
                            
                            Spacer()
                        }
                        
                    }
                
                    Spacer()
                    
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.width-20)
                        
                        Link("Pay", destination: URL(string: "https://www.jacquemus.com")!)
                            .foregroundColor(Color.white)
                    }
                        
                    Spacer()
                    
                //boutons "Entrez la totalité de vos mensurations pour pouvoir validerツ" et "Modifier mes mesures"

                    Button(action: {
                        
                        self.bigModel.currentview = .Measurement_Mensurations
                        //self.bigModel.commingFromMeasurement = true
                        
                        if self.isArmpitsMeasurementNil == true {
                            self.isModifyMeasurementButtonBlue = true
                        }
                        if self.isArmsLengthNil == true {
                            self.isModifyMeasurementButtonBlue = true
                        }
                        if self.isheadMeasurementNil == true {
                            self.isModifyMeasurementButtonBlue = true
                        }
                        if self.isPelvisKneeNil == true {
                            self.isModifyMeasurementButtonBlue = true
                        }
                        if self.isPelvisMeasurementNil == true {
                            self.isModifyMeasurementButtonBlue = true
                        }
                        if self.isShouldersMeasurementNil == true {
                            self.isModifyMeasurementButtonBlue = true
                        }
                        if self.isShouldersPelvisNil == true {
                            self.isModifyMeasurementButtonBlue = true
                        }
                        
                    }) {
                        VStack {
                            
                                Text("Entrez la totalité de vos mensurations pour pouvoir validerツ")
                                    .font(.system(size: 14))
                                    .italic()
                                    .foregroundColor(isModifyMeasurementButtonBlue ? .blue : .black)
                                    .multilineTextAlignment(.center)
                            
                            HStack {
                                
                                Spacer()
                                Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(isModifyMeasurementButtonBlue ? .blue : .black)
                                Text("Modifier mes mesures")
                                .foregroundColor(isModifyMeasurementButtonBlue ? .blue : .black)
                                Spacer()
                            
                            }
                            
                        }
                    }
                
                
                Spacer()
                .frame(height: 20)
                
                //bouton "Valider"
                
                /*VStack {
                    Button(action: {
                        
                    if self.bigModel.armpitsMeasurement == nil {
                        self.isArmpitsMeasurementNil = true
                    }
                    if self.bigModel.armsLength == nil {
                        self.isArmsLengthNil = true
                    }
                    if self.bigModel.headMeasurement == nil {
                        self.isheadMeasurementNil = true
                    }
                    if self.bigModel.pelvisKnee == nil {
                        self.isPelvisKneeNil = true
                    }
                    if self.bigModel.pelvisMeasurement == nil {
                        self.isPelvisMeasurementNil = true
                    }
                    if self.bigModel.shouldersMeasurement == nil {
                        self.isShouldersMeasurementNil = true
                    }
                    if self.bigModel.shouldersPelvis == nil {
                        self.isShouldersPelvisNil = true
                    }
                        
                    self.bigModel.currentview = .FinalizeOrderViews_FinDeCommande
                    
                    }) {
                            
                        HStack {
                                
                            Spacer()
                                
                            HStack {
                                    
                                Spacer()
                                Text("Valider")
                                    .foregroundColor(Color.white)
                                    .fontWeight(.semibold)
                                    .onTapGesture {
                                        self.bigModel.currentview = .FinalizeOrderViews_FinDeCommande
                                        self.bigModel.lastViews.append(.FinalizeOrderViews_PaymentScreen)
                                    }
                                Spacer()
                            
                            }.background(Color.blue)
                            .frame(width: 150)
                            .cornerRadius(5)
                            
                            Spacer()
                            
                        }.frame(width: 120, height: 35)
                        .background(Color.blue)
                        .cornerRadius(15)
                        
                    }
                    
                }*/
                
                Spacer()
                    .frame(height: 30)
                    
                }.background(Color.black)
            
            VStack {
                
                Spacer()
                    .frame(height: 50)
                
                HStack {
                    Spacer()
                        .frame(width: 20)
                    
                    Text("Back")
                        .foregroundColor(Color.blue)
                        .fontWeight(.semibold)
                        .onTapGesture {
                            if !self.bigModel.lastViews.isEmpty {
                                print("back")
                                self.bigModel.currentview = self.bigModel.lastViews.last ?? .AboutUsScreen
                                self.bigModel.lastViews.removeLast()
                                print("previous View = \(String(describing: self.bigModel.lastViews.last))")
                            } else { print("array empty") }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "house")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.bigModel.currentview = .Home_homeFeed
                        }
                    
                    Spacer()
                        .frame(width: 20)
                        
                    }
                
                Spacer()
                
            }
                
        }.background(Color.black)
        .edgesIgnoringSafeArea(.all)
            
        }
        
    }

/*
 
 */


@available(iOS 14.0, *)
struct PaymentScreen_Previews: PreviewProvider {
    @available(iOS 14.0, *)
    static var previews: some View {
        PaymentScreen()
    }
}
