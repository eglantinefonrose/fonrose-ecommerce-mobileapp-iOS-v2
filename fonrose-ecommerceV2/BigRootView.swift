//
//  BigRootView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 22/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct BigRootView: View {
    
    @EnvironmentObject var bigModel: BigModel
    //var model: ParcelInfos
    
    var body: some View {
        
        VStack {
            
            //MARK: Main views
            
            VStack {
                
                if (self.bigModel.currentview == .Home_homeFeed) {
                    homeFeed(model: Measurement[0])
                }
                
                if (self.bigModel.currentview == .MeasurementCarouselView) {
                    CarouselView()
                }
                
                if (self.bigModel.currentview == .Measurement_Mensurations) {
                    Mensurations(armpitsNewValue: bigModel.armpitsMeasurement)
                    
                }
                
                if (self.bigModel.currentview == .VideoPlayer_trailerPlayer) {
                    TrailerPlayer()
                }
                
                if (self.bigModel.currentview == .AboutUsScreen) {
                    AboutUs()
                }
                
            }
            
            //MARK: Service client
            
            VStack {
                
                if (self.bigModel.currentview == .ServiceClient_ServiceClientInfos) {
                    ServiceClientInfos()
                }
                
                if (self.bigModel.currentview == .ServiceClient_showDelivery) {
                    ShowDeliveryView()
                }
                
                if (self.bigModel.currentview == .ServiceClient_showReturn) {
                    showReturnView()
                }
                
                if (self.bigModel.currentview == .ServiceClient_showCard) {
                    showCardView()
                }
                
                if (self.bigModel.currentview == .ServiceClient_showServices) {
                    ShowServicesView()
                }
            }
            
            //MARK: Finalize order
            
            VStack {
                
                if (self.bigModel.currentview == .FinalizeOrderViews_PaymentScreen) {
                    PaymentScreen()
                }
                
                if (self.bigModel.currentview == .FinalizeOrderViews_RecapMensurations) {
                    RecapMensurations()
                }
                
            }
            
        }
    }
}
