//
//  ProductsScreen.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 11/05/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI

struct ProductsScreen: View {
    
    @EnvironmentObject var bigModel: BigModel
    let dressPic: [BigModel.DressPictures] = [BigModel.DressPictures(id: 0, pictureName: "IMG_5141", productName: "The dress", videoURL: "", price: "", carouselProductPictures: []),
        BigModel.DressPictures(id: 0, pictureName: "60511853694__59B14B15-472E-4D34-A312-FB963FEDA4D8", productName: "Le serpent", videoURL: "", price: "", carouselProductPictures: [])]
    
    var body: some View {
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack() {
                
                BackButtonModel(text: "Products")
                                               
                Text("Products")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                if #available(iOS 14.0, *) {
                    
                    let columns = [ GridItem(.flexible()) ]
                    
                    ScrollView {
                        LazyVGrid(columns: columns) {
                                
                            ForEach(bigModel.dressPictures.indices, id: \.self) { index in
                                ZStack {
                                    bigModel.productImages[index]
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(20)
                                    
                                    Text("\(bigModel.productMainArrayInfos[index].productName), \(bigModel.productMainArrayInfos[index].id)")
                                        .font(.title)
                                        .foregroundColor(.white)
                                    
                                }
                                .onTapGesture {
                                    bigModel.selectedProductId = index
                                    bigModel.currentview = .MeasurementCarouselView
                                }
                            }
                        }
                    }
                } else {
                    // Fallback on earlier versions
                }
                HStack {
                    VStack {
                        Image(systemName: "chevron.down")
                        Image(systemName: "chevron.down")
                    }
                    Text("Scroll down to see all products")
                }
                
            }.padding(20)
            
        }
    }
}

struct ProductsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductsScreen()
            .environmentObject(BigModel(shouldInjectMockedData: true))
    }
}
