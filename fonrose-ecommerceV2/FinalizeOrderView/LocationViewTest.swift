//
//  LocationView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 14/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

/*import SwiftUI

struct LocationViewTest: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    @State var ssize1 : CGFloat = 0
    @State var ssize2 : CGFloat = 0
    @State var ssize3 : CGFloat = 0
    @State var ssize4 : CGFloat = 0
    @State var ssize5 : CGFloat = 0
    @State var ssize6 : CGFloat = 0
    @State var ssize7 : CGFloat = 0
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var seconds: Float = 0.0
    @State var currentTime: Int = 0
    
    var body: some View {
        
        GeometryReader { reader in
            
            VStack {
                
                CircleModel(currentSize3: self.ssize1)
                CircleModel(currentSize3: self.ssize2)
                CircleModel(currentSize3: self.ssize3)
                CircleModel(currentSize3: self.ssize4)
                CircleModel(currentSize3: self.ssize5)
                CircleModel(currentSize3: self.ssize6)
                CircleModel(currentSize3: self.ssize7)
                    
                Spacer()
                
                Button(action: {
                                        
                    self.ssize1 = reader.size.width / 15
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.ssize2 = reader.size.width / 15
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                        self.ssize3 = reader.size.width / 15
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        self.ssize4 = reader.size.width / 15
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.ssize5 = reader.size.width / 15
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                        self.ssize6 = reader.size.width / 15
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                        self.ssize7 = reader.size.width / 15
                    }
                    
                }) {
                    Image(systemName: "tray.and.arrow.down")
                }
                
                Spacer()
                    .frame(height: 20)
                
            }
            
        }.animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))

    }
}

struct CircleModel: View {
    
    var currentSize3: CGFloat
    
    var body: some View {
        
        VStack {
            
            Spacer()
                .frame(height: 50)
            
            Circle()
                .fill(Color.blue)
                .frame(width: 50, height: 50)
                .offset(x: self.currentSize3)
            
        }
        
    }
}

struct LocationViewTest_Previews: PreviewProvider {
    static var previews: some View {
        LocationViewTest()
    }
}*/
