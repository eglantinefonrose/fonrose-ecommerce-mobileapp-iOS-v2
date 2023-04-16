//
//  Sandbox-TextFields.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 13/04/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI

struct Sandbox_TextFields: View {
    @State var basement: String = ""
    @State var show = false

    var body: some View {
            
            ZStack {
                
                if #available(iOS 14.0, *) {
                    TextField("Basement", text: $basement)
                        .onChange(of: basement) { newValue in
                            show = true
                            print("chage")
                        }
                } else {
                    // Fallback on earlier versions
                }
                
                if show {
                    VStack {
                        
                        TextField("Basement", text: $basement)
                        List {
                            Text("5")
                                .onTapGesture {
                                    show.toggle()
                                }
                            }
                            
                        }
                        
                    }
                }
                
            }
            
        }

struct Sandbox_TextFields_Previews: PreviewProvider {
    static var previews: some View {
        Sandbox_TextFields()
    }
}
