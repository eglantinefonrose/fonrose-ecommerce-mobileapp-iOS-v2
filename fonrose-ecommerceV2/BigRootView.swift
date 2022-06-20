//
//  BigRootView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 22/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct BigRootView: View {
    
    @EnvironmentObject var bigModel: BigModel
    //var model: ParcelInfos
    
    @available(iOS 14.0, *)
    var body: some View {
        
        VStack {
            
            //MARK: Main views
            
            VStack {
                
                if (self.bigModel.currentview == .Home_homeFeed) {
                    HomeFeedView()
                }
                
                if (self.bigModel.currentview == .MeasurementCarouselView) {
                    CarouselView()
                }
                
                if (self.bigModel.currentview == .Measurement_Mensurations) {
                    MeasurementView()
                    
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
                
                if (self.bigModel.currentview == .FinalizeOrderViews_Livraison) {
                    LocationHome()
                }
                
                if (self.bigModel.currentview == .FinalizeOrderViews_FinDeCommande) {
                    FinDeCommande()
                }
                
            }
            
            //MARK: Auth
            
            VStack {
                
                if (self.bigModel.currentview == .Auth_SignInView) {
                    SignInView()
                }
                
                if (self.bigModel.currentview == .Auth_SignUpView) {
                    SignUpView()
                }
                
                if (self.bigModel.currentview == .Auth_LogInNewUserView) {
                    LogInNewUser()
                }
                
                if (self.bigModel.currentview == .Auth_PersonPickerView) {
                    PersonPickerView()
                }
                
            }
            
        }
    }
}
