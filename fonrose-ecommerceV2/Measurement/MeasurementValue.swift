//
//  ExplictCodeFile.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 18/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct MeasurementValue: View {
    
    @State var textFieldColor: Bool = true
    var buttonCurrentSize: CGFloat
    @Binding var MeasurementName: String
    @State var showingSecondView: Bool = false
    var MeasurementVideoName: String!
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
                            
                            HStack {
                                Spacer()
                                    //.frame(width: 5)
                                TextField("\(textFieldText) in mm", text: $MeasurementName)
                                .keyboardType(.decimalPad)
                                Spacer()
                            }
                            
                            Spacer()
                        
                        }.background(Color.white)
                        .cornerRadius(7)
                        .frame(height: 30)
                    
                }.background(Color.white)
                .cornerRadius(7)
                .frame(width: UIScreen.main.bounds.width*(3/4))
                
                Spacer()
                
                 VStack {
                   Button(action: {
                        hideKeyboard()
                   }){
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .foregroundColor(.blue)
                        .frame(width: 20, height: 20)
                        .offset(x: self.buttonCurrentSize)
                   }
               }
                
                Spacer()
                    .frame(width: 30)
                
               
                
            }.frame(width: UIScreen.main.bounds.width)
            
        }
                
    }
}


