//
//  FinDeCommande.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 10/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import AVFoundation

struct FinDeCommande : View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var seconds: Int = 0
    
    var body : some View {
        
        VStack {
            
            Spacer()
            
            HStack {
                
                Spacer()
                ZStack {
                    
                    Spacer()
                    
                    Text("\(seconds)").onReceive(timer) { input in
                        self.seconds += 1
                    }
                    
                    //PlayerView()
                    
                    VStack {//élement 1
                              
                        if seconds < 4 {
                            Text("Félicitations")
                                .font(.system(size: 45, weight: .bold, design: .default))
                                .foregroundColor(Color.white)
                        } else {
                            Text("Merci")
                            .font(.system(size: 45, weight: .bold, design: .default))
                            .foregroundColor(Color.white)
                        }
                        
                        if seconds < 4 {
                            Text("pour votre achat")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 30, weight: .semibold, design: .default))
                            
                        } else {
                            
                        }
                              
                    }
                
                    }
                Spacer()
                
            }
            
            Spacer()
            
        }.background(Color.black)
            .edgesIgnoringSafeArea(.all)
        
    }
}

struct FinDeCommande_Previews: PreviewProvider {
    static var previews: some View {
        FinDeCommande()
    }
}
