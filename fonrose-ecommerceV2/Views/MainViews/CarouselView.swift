//
//  About us.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct CarouselView: View {
    
    @EnvironmentObject var bigModel: BigModel
    @State var index = 0
    @State var isFetchingNeededMeasurementsInfo = false

    var body: some View {
        
        VStack() {
            
            BackButtonModel(text: "")
                .padding(20)
            Spacer()
            
            if #available(iOS 14.0, *) {
                VStack {
                    TabView(selection: $index) {
                        ForEach((0..<bigModel.dressPictures[bigModel.selectedProductId ?? 0].carouselProductPictures.count), id: \.self) { index in
                            ProductCardView(text:                             bigModel.dressPictures[bigModel.selectedProductId ?? 0].productName, imageName: bigModel.dressPictures[bigModel.selectedProductId ?? 0].carouselProductPictures[index])
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.black, lineWidth: 2)
                    .foregroundColor(.white)
                    .frame(height: 40)
                Text("buy")
                    .foregroundColor(.black)
                    .onTapGesture {
                        
                        isFetchingNeededMeasurementsInfo = true
                        
                        self.bigModel.lastViews.append(.MeasurementCarouselView)    // On gère le back à la main (car on n'utilise pas de NavigationView)
                        
                        if bigModel.selectedProductId != nil {
                            
                            print("bigModel.selectedProductId != nil")
                            DispatchQueue.main.async {
                                Task {
                                    await bigModel.getRequestedMeasurements()
                                    
                                }
                            }
                            
                        } else {
                            print("bigModel.selectedProductId = nil")
                        }
                        
                    }.disabled(isFetchingNeededMeasurementsInfo)

            }.padding(20)
            
        }
            
    }
}
    
struct ProductCardView: View {
    
    var text: String
    var imageName: String
    
    var body: some View{
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
            Text(text)
                .font(.system(size: 35, weight: .bold, design: .default))
                .foregroundColor(Color.white)
                .frame(width: 200)
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
     
    static var previews: some View {
        CarouselView()
            .environmentObject(BigModel(shouldInjectMockedData: true))
    }
}
