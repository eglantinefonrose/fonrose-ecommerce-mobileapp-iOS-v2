//
//  ExplictCodeFile.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 18/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

/*#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif*/
@available(iOS 14.0, *)
struct MeasurementValue: View {
    
    @State var textFieldColor: Bool = true
    var buttonCurrentSize: CGFloat
    @Binding var MeasurementName: String
    @State var showingSecondView: Bool = false
    var MeasurementVideoName: String!
    @State var textFieldText: String
    
    @available(iOS 14.0, *)
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
                                
                                let lettersCharacters = CharacterSet.letters
                                let lettersRange = MeasurementName.rangeOfCharacter(from: lettersCharacters)
                                
                                Spacer()
                                    //.frame(width: 5)
                                
                                TextField("text", text: $MeasurementName)
                                    .background(Color.white)
                                    .onChange(of: (MeasurementName), perform: { value in
                                        perform: do {
                                            if MeasurementName.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                    
                                                }
                                            } else {}
                                        }
                                    })
                            }
                            
                            Spacer()
                        
                        }.background(Color.white)
                        .cornerRadius(7)
                        .frame(height: 30)
                    
                }.background(Color.white)
                .cornerRadius(7)
                .frame(width: UIScreen.main.bounds.width*(3/4))
                
                Spacer()
                
                 /*VStack {
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
                    .frame(width: 30)*/
                
            }.frame(width: UIScreen.main.bounds.width)
            
        }
                
    }
}

extension View {
    func alertTF(title: String, message: String, primaryTitle: String, action: @escaping ()->()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: primaryTitle, style: .cancel, handler: { _ in
            action()
        }))
        
        rootController().present(alert, animated: true, completion: nil)
        
    }
    
    func rootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
    
}
