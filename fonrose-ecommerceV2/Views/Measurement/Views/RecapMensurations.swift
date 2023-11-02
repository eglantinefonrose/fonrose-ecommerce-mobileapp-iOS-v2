//
//  RecapMensurations.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 10/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@available(iOS 15.0, *)
struct RecapMensurations: View {
    
    @EnvironmentObject var bigModel: BigModel
    var auth = Auth.auth()
    var db = Firestore.firestore()
    
    var body: some View {
                                
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                BackButtonModel(text: "recap")
                
                Spacer()
                    
                    HStack {
                        
                        Text("recap")
                            .font(.system(size: 45, weight: .bold, design: .default))
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                ScrollView {
                    VStack {
                             
                            VStack {
                                if bigModel.isMeasurements0Requested ||  bigModel.selectedProductId == nil {
                                    RecapMensurationsTextStruct(recapMeasurementText: "armpits-measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[0].measurementValue) ?? "nil")
                                }
                                
                                if bigModel.isMeasurements1Requested ||  bigModel.selectedProductId == nil {
                                    RecapMensurationsTextStruct(recapMeasurementText: "arms-length", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[1].measurementValue) ?? "nil")
                                }
                                
                                if bigModel.isMeasurements2Requested ||  bigModel.selectedProductId == nil {
                                    RecapMensurationsTextStruct(recapMeasurementText: "head-measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[2].measurementValue) ?? "nil")
                                }
                                
                                if bigModel.isMeasurements3Requested ||  bigModel.selectedProductId == nil {
                                    RecapMensurationsTextStruct(recapMeasurementText: "pelvis-measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[3].measurementValue) ?? "nil")
                                }
                                
                                if bigModel.isMeasurements4Requested ||  bigModel.selectedProductId == nil {
                                    RecapMensurationsTextStruct(recapMeasurementText: "pelvis-knee", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[4].measurementValue) ?? "nil")
                                }
                                
                                if bigModel.isMeasurements5Requested ||  bigModel.selectedProductId == nil {
                                    RecapMensurationsTextStruct(recapMeasurementText: "shoulders-measurement", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[5].measurementValue) ?? "nil")
                                }
                                
                                if bigModel.isMeasurements6Requested ||  bigModel.selectedProductId == nil {
                                    RecapMensurationsTextStruct(recapMeasurementText: "shoulders-pelvis", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[6].measurementValue) ?? "nil")
                                }
                                
                                if bigModel.isMeasurements7Requested ||  bigModel.selectedProductId == nil {
                                    RecapMensurationsTextStruct(recapMeasurementText: "chest-size", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[7].measurementValue) ?? "nil")
                                }
                                
                                if bigModel.isMeasurements8Requested ||  bigModel.selectedProductId == nil {
                                    RecapMensurationsTextStruct(recapMeasurementText: "crotch", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[8].measurementValue) ?? "nil")
                                    
                                }
                                
                            }
                            
                            if bigModel.isMeasurements9Requested ||  bigModel.selectedProductId == nil {
                                RecapMensurationsTextStruct(recapMeasurementText: "armpits-tits", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[9].measurementValue) ?? "nil")
                            }
                            
                            if bigModel.isMeasurements10Requested ||  bigModel.selectedProductId == nil {
                                RecapMensurationsTextStruct(recapMeasurementText: "tits-belly-button", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[10].measurementValue) ?? "nil")
                            }
                            
                            if bigModel.isMeasurements11Requested ||  bigModel.selectedProductId == nil {
                                RecapMensurationsTextStruct(recapMeasurementText: "tits-hips", recapMeasurementText2: (bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[11].measurementValue) ?? "nil")
                            }
                                
                    }
                }
                    
                        Spacer()
                    
                    VStack {
                        
                        HStack {
                            VStack {
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.blue)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.blue)
                            }
                            Text(LocalizedStringKey("scroll-down-to-see-all-measurements"))
                                .foregroundColor(.blue)
                        }
                        
                        HStack {
                            Spacer()
                            Text("save")
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                                .padding(10)
                            Spacer()
                        }.background(Color.blue)
                        .cornerRadius(15)
                        .onTapGesture {
                            
                            Task {
                                
                                self.bigModel.lastViews.append(.Measurement_RecapMensurations)
                                
                                if bigModel.selectedProductId != nil {
                                    
                                    await bigModel.fetchLocation()
                                    
                                    if bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location == nil {
                                        
                                        Task {
                                            await bigModel.initializeLocation()
                                            await bigModel.fetchLocation()
                                        }
                                        bigModel.currentview = .LivraisonViews_Livraison
                                        bigModel.lastViews.append(.Measurement_RecapMensurations)
                                        
                                    } else {bigModel.currentview = .LivraisonViews_Livraison
                                        bigModel.lastViews.append(.Measurement_RecapMensurations)
                                    }
                                } else {
                                    bigModel.currentview = .Home_homeFeed0
                                }
                                
                                print("previous View = \(String(describing: self.bigModel.lastViews.last))")
                                print(self.bigModel.lastViews.count)
                                print("location")
                                
                            }
                            
                        }
                           
                        
                    Text("edit-measurements")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.bigModel.currentview = .Measurement_Mensurations
                            bigModel.lastViews.append(.Measurement_RecapMensurations)
                        }
                    }
                                
            }.padding(20)
            
        }
    }
        
}

struct RecapMensurationsTextStruct: View {
    
    var recapMeasurementText: String
    var recapMeasurementText2: String
    
    var body : some View {
        
        VStack {
            HStack {
                Text(recapMeasurementText)
                    .font(.system(size: 20, design: .default))
                    .frame(height: 50, alignment: .leading)
                               
                Spacer()
                               
                Text(recapMeasurementText2)
                    .foregroundColor(Color.gray)
                    .font(.system(size: 20, design: .default))
                    .frame(height: 50, alignment: .leading)
            }
            
            Spacer()
                .frame(height: 7)
        }
        
    }
    
}

struct RecapMensurations_Previews: PreviewProvider {
    static var previews: some View {
        RecapMensurations()
            .environmentObject(BigModel.init(shouldInjectMockedData: true))
    }
}
