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
    
    var body: some View {
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack() {
                
                BackButtonModel(text: "products", viewName: .ProductsView)
                                               
                Text("products")
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
                                    bigModel.lastViews.append(.ProductsView)
                                    bigModel.fullViewHistory.append(.ProductsView)
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
                    Text("scroll-down-to-see-all-products")
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
