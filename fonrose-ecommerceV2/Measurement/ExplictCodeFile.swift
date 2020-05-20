//
//  ExplictCodeFile.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 18/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct MeasurementValue: View {
    
    @State var MeasurementName: String
    @State var showingSecondView: Bool = false
    let MeasurementVideoName: String
    let textFieldText: String
    
    var body: some View {

        VStack {
            HStack {
                
                Spacer()
                    .frame(width: 30)
                
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                       TextField(textFieldText, text: $MeasurementName)
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
                       self.showingSecondView.toggle()
                   }){
                    Image(systemName: "info.circle")
                        .resizable()
                        .foregroundColor(.blue)
                        .frame(width: 20, height: 20)
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
