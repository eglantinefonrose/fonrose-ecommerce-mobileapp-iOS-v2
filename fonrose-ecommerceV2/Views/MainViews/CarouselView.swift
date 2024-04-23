//
//  About us.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct CarouselView: View {
    
    @Environment(\.colorScheme) var theColorScheme
    @EnvironmentObject var bigModel: BigModel
    @State var index = 0
    @State var isFetchingNeededMeasurementsInfo = false

    var body: some View {
        
        VStack {
            
            ZStack {
                
                if #available(iOS 14.0, *) {
                        
                        VStack {
                            TabView(selection: $index) {
                                ForEach((0..<bigModel.dressPictures[bigModel.selectedProductId ?? 0].carouselProductPictures.count), id: \.self) { index in
                                    ProductCardView(imageName: bigModel.dressPictures[bigModel.selectedProductId ?? 0].carouselProductPictures[index])
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        }.edgesIgnoringSafeArea(.all)
                        
                }
                
                VStack {
                    BackButtonModel(text: "")
                    Spacer()
                }.padding(20)
                
                VStack {
                    Spacer()
                    Text(bigModel.dressPictures[bigModel.selectedProductId ?? 0].productName)
                        .font(.system(size: 35, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                        .frame(width: 200)
                    Spacer()
                }
                
            }
            
            //VStack {
                //Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(theColorScheme == .dark ? .white : .black, lineWidth: 2)
                        .foregroundColor(theColorScheme == .dark ? .black : .white)
                        .frame(height: 40)
                    Text("buy")
                        .foregroundColor(theColorScheme == .dark ? .white : .black)
                        .onTapGesture {
                            
                            isFetchingNeededMeasurementsInfo = true
                            
                            self.bigModel.lastViews.append(.MeasurementCarouselView)    // On gère le back à la main (car on n'utilise pas de NavigationView)
                            
                            if bigModel.selectedProductId != nil {
                                
                                print("bigModel.selectedProductId != nil")
                                DispatchQueue.main.async {
                                    Task {
                                        await bigModel.getRequestedMeasurements()
                                        bigModel.updateTotal()
                                    }
                                }
                                
                            } else {
                                print("bigModel.selectedProductId = nil")
                            }
                            
                        }.disabled(isFetchingNeededMeasurementsInfo)

                }.padding(10)
            //}
            
        }
            
    }
}
    
struct ProductCardView: View {
    
    //var text: String
    var imageName: String
    
    var body: some View{
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
        }.edgesIgnoringSafeArea(.all)
    }
}

struct CarouselView_Previews: PreviewProvider {
     
    static var previews: some View {
        CarouselView()
            .environmentObject(BigModel.shared)
    }
}
