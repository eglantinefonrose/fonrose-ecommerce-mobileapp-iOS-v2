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
    
    @State var MeasurementName: String
    @State var text: String = ""
    @Environment(\.colorScheme) var theColorScheme
    var textContentType: UITextContentType!
    //@State var textFieldColor: Bool = true
    //@State var MeasurementName: String
    //@State var showingSecondView: Bool = false
    var MeasurementVideoName: String!
    @State var textFieldText: String
    
    @available(iOS 14.0, *)
    var body: some View {

        VStack {
         
         Spacer()
         
         HStack {
                                             
             Spacer()
             
             TextField(textFieldText, text: $MeasurementName)
                 .disableAutocorrection(true)
                 .autocapitalization(.none)
         }
         
         Spacer()

        }.background(theColorScheme == .dark ? Color.gray : Color.white)
        .cornerRadius(7)
        .frame(height: 30)
        .padding(10)
        .onChange(of: (MeasurementName), perform: { value in
            perform: do {
                if MeasurementName.rangeOfCharacter(from: CharacterSet.letters) != nil {
                    alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                        
                    }
                } else {}
            }
        })
        
        /*TextFieldModel(title: textFieldText, text: $MeasurementName)
            .onChange(of: (MeasurementName), perform: { value in
                perform: do {
                    if MeasurementName.rangeOfCharacter(from: CharacterSet.letters) != nil {
                        alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                            
                        }
                    } else {}
                }
            })*/
                
    }
}

/*struct MeasurementValue_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            MeasurementValue(MeasurementName: "edef", textFieldText: "")
        } else {
            // Fallback on earlier versions
        }
    }
}*/


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
