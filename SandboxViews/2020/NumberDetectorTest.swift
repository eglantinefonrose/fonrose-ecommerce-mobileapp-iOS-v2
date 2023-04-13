//
//  NumberDetectorTest.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 01/05/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct NumberDetectorTest: View {
    
    @State var str: String = ""
    
    @available(iOS 14.0, *)
    var body: some View {
        
        VStack {
            
            TextField("text", text: $str)
                //str.rangeOfCharacter(from: CharacterSet.letters) sert à savoir le nombre de lettres qu'il y a dans la chaîne de carctère str
                .background((str.rangeOfCharacter(from: CharacterSet.letters) == nil) ? Color.white : Color.red)
                
                .onChange(of: (str), perform: { value in
                    perform: do {
                        if str.rangeOfCharacter(from: CharacterSet.letters) != nil {
                            alertTF(title: "Alert", message: "string containts letters", primaryTitle: "Ok") {
                                
                            }
                        } else {}
                    }
                })
            }
    }
}

/*struct NumberDetectorTest_Previews: PreviewProvider {
    @available(iOS 14.0, *)
    static var previews: some View {
        NumberDetectorTest(str: "")
    }
}*/

/*extension View {
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
    
}*/
