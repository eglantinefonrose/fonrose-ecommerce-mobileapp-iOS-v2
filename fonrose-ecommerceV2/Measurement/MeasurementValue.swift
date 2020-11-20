//
//  ExplictCodeFile.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 18/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct MeasurementValue: View {
    
    var buttonCurrentSize: CGFloat
    @Binding var MeasurementName: String
    @State var showingSecondView: Bool = false
    let MeasurementVideoName: String
    @State var textFieldText: String
    
    var body: some View {

        VStack {
            HStack {
                
                Spacer()
                    .frame(width: 30)
                
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                        
                        TextField("\(textFieldText) in mm", text: $MeasurementName)
                            .keyboardType(.decimalPad)
                        
                        Spacer()
                    }.background(Color.white)
                    .cornerRadius(7)
                    //.padding(10)
                    .frame(height: 30)
                    
                }.background(Color.white)
                .cornerRadius(7)
                .frame(width: UIScreen.main.bounds.width*(3/4))
                
                Spacer()
                
                 VStack {
                   Button(action: {
                       self.showingSecondView = true
                   }){
                    Image(systemName: "info.circle")
                        .resizable()
                        .foregroundColor(.blue)
                        .frame(width: 20, height: 20)
                        .offset(x: self.buttonCurrentSize)
                   }
               }.sheet(isPresented: $showingSecondView, onDismiss: {
               print("frkl")
               }) {
                home(isPresented: self.$showingSecondView, CPSMVideoName: self.MeasurementVideoName)
               }
                
                Spacer()
                    .frame(width: 30)
                
               
                
            }.frame(width: UIScreen.main.bounds.width)
            
        }
                
    }
}
