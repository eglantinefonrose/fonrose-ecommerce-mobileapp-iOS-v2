//
//  About us.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct PagingView<Content>: View where Content: View {

    @EnvironmentObject var bigModel: BigModel
    @Binding var index: Int
    let maxIndex: Int
    let content: () -> Content

    @State private var offset = CGFloat.zero
    @State private var dragging = false

    init(index: Binding<Int>, maxIndex: Int, @ViewBuilder content: @escaping () -> Content) {
        self._index = index
        self.maxIndex = maxIndex
        self.content = content
    }
    
    @State var isFetchingNeededMeasurementsInfo = false
    
    //var model: MeasurementInfos
    
    var body: some View {
                 
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            BackButtonModel(text: "")
            
            VStack {
                
                ZStack {
                    
                    ZStack {
                        
                        ZStack(alignment: .bottomTrailing) {
                            GeometryReader { geometry in
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 0) {
                                        self.content()
                                            .frame(width: geometry.size.width, height: geometry.size.height)
                                            .clipped()
                                    }
                                }
                                .content.offset(x: self.offset(in: geometry), y: 0)
                                .frame(width: geometry.size.width, alignment: .leading)
                                .gesture(
                                    DragGesture().onChanged { value in
                                        self.dragging = true
                                        self.offset = -CGFloat(self.index) * geometry.size.width + value.translation.width
                                    }
                                    .onEnded { value in
                                        let predictedEndOffset = -CGFloat(self.index) * geometry.size.width + value.predictedEndTranslation.width
                                        let predictedIndex = Int(round(predictedEndOffset / -geometry.size.width))
                                        self.index = self.clampedIndex(from: predictedIndex)
                                        withAnimation(.easeOut) {
                                            self.dragging = false
                                        }
                                    }
                                )
                            }
                            .clipped()

                            PageControl(index: $index, maxIndex: maxIndex)
                            
                        }//.frame(height: UIScreen.main.bounds.height-150)
                        
                        VStack {
                                                        
                            Text(bigModel.dressPictures[bigModel.selectedProductId ?? 0].productName)
                                .font(.system(size: 35, weight: .bold, design: .default))
                                .foregroundColor(Color.white)
                                .frame(width: 200)
                                
                            Spacer()
                                .frame(height: 30)
                            
                            Text(bigModel.dressPictures[bigModel.selectedProductId ?? 0].price)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 25, weight: .semibold, design: .default))
                                                        
                        }
                        
                    }
                    
                    VStack {
                        
                        BackButtonModel(text: "")
                        
                    }
                    
                }
                
                VStack {
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("Acheter")
                        .foregroundColor(.blue)
                        .font(.system(size: 17, weight: .bold, design: .default))
                        .onTapGesture {
                            
                            isFetchingNeededMeasurementsInfo = true
                            
                            self.bigModel.lastViews.append(.MeasurementCarouselView)    // On gère le back à la main (car on n'utilise pas de NavigationView)
                            
                            if bigModel.selectedProductId != nil {
                                
                                if bigModel.selectedProductId != nil {
                                    Task {
                                        
                                        await bigModel.getRequestedMeasurements()
                                        
                                        bigModel.currentview = .Measurement_Mensurations
                                        
                                    }
                                }
                                /*Task {
                                    
                                    if bigModel.currentPersonIndex != nil {
                                        try await
                                        if bigModel.isMeasurementModelUpdated {
                                            
                                        }
                                    }
                                    
                                    isFetchingNeededMeasurementsInfo = false
                                }*/
                            } else {
                                
                            }
                            
                        }.disabled(isFetchingNeededMeasurementsInfo)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("About us")
                        .foregroundColor(.blue)
                        .font(.system(size: 17, weight: .bold, design: .default))
                        .onTapGesture {
                            self.bigModel.currentview = .AboutUsScreen
                            self.bigModel.lastViews.append(.MeasurementCarouselView)
                        }
                                        
                    Spacer()
                        .frame(height: 20)
                
                }
                                
            }//.edgesIgnoringSafeArea(.all)
            
        }
        
    }//acolade fermante body

    func offset(in geometry: GeometryProxy) -> CGFloat {
        if self.dragging {
            return max(min(self.offset, 0), -CGFloat(self.maxIndex) * geometry.size.width)
        } else {
            return -CGFloat(self.index) * geometry.size.width
        }
    }

    func clampedIndex(from predictedIndex: Int) -> Int {
        let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
        guard newIndex >= 0 else { return 0 }
        guard newIndex <= maxIndex else { return maxIndex }
        return newIndex
    }
}

struct PageControl: View {
    @Binding var index: Int
    let maxIndex: Int

    var body: some View {
        
        HStack {
            Spacer()
            HStack(spacing: 8) {
                ForEach(0...maxIndex, id: \.self) { index in
                    Circle()
                        .fill(index == self.index ? Color.white : Color.gray)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(15)
            Spacer()
        }
        
    }
}


struct CarouselView: View {
    
    @EnvironmentObject var bigModel: BigModel
    @State var index = 0

    var body: some View {
        
        VStack(spacing: 20) {
            PagingView(index: $index.animation(), maxIndex: bigModel.dressPictures[bigModel.selectedProductId ?? 0].carouselProductPictures.count - 1) {
                ForEach(bigModel.dressPictures[bigModel.selectedProductId ?? 0].carouselProductPictures, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(alignment: .top)
                }
            }
            .aspectRatio(contentMode: .fill)

        }
            
    }
}
    

struct CarouselView_Previews: PreviewProvider {
     
    static var previews: some View {
        CarouselView()
            .environmentObject(BigModel())
    }
}
