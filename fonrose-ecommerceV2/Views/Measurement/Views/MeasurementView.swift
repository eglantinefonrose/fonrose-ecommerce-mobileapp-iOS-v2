//
//  MeasurementView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 20/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct MeasurementView: View {
    
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        if #available(iOS 14.0, *) {
            HomeView(measurementText1: bigModel.persons[bigModel.currentPersonIndex].measurements?.ArmpitsMeasurement ?? "nil",
                     measurementText2: bigModel.persons[bigModel.currentPersonIndex].measurements?.ArmsLength ?? "nil",
                     measurementText3: bigModel.persons[bigModel.currentPersonIndex].measurements?.HeadMeasurement ?? "nil",
                     measurementText4: bigModel.persons[bigModel.currentPersonIndex].measurements?.PelvisKnee ?? "nil",
                     measurementText5: bigModel.persons[bigModel.currentPersonIndex].measurements?.PelvisMeasurement ?? "nil",
                     measurementText6: bigModel.persons[bigModel.currentPersonIndex].measurements?.ShouldersMeasurement ?? "nil",
                     measurementText7: bigModel.persons[bigModel.currentPersonIndex].measurements?.ShouldersPelvis ?? "nil")
        } else {
            // Fallback on earlier versions
        }
        
    }
    
}

@available(iOS 14.0, *)
struct HomeView: View {
    
    @EnvironmentObject var bigModel: BigModel
    @State var measurementText1: String
    @State var measurementText2: String
    @State var measurementText3: String
    @State var measurementText4: String
    @State var measurementText5: String
    @State var measurementText6: String
    @State var measurementText7: String
    var db = Firestore.firestore()
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            VStack {
                
                Text("Mensurations")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width)
                    
                Spacer()
                    .frame(height: 10)
                    
                Text("all values in millimeters")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 15, weight: .semibold, design: .default))
                    
                }
                
            Spacer()
                .frame(height: 50)
            
            VStack {
                
                VStack {
                    
                    MeasurementValue(MeasurementName: $measurementText1, textFieldText: "Armpits Measurement")
                    
                    Spacer()
                        .frame(height: 15)
                }
                
                
                //MARK: Arms Length
                VStack {
                    
                    MeasurementValue(MeasurementName: $measurementText2, textFieldText: "Arms Length")
                    
                    Spacer()
                        .frame(height: 15)
                }
                
                //MARK: Head Measurement
                VStack {
                    MeasurementValue(MeasurementName: $measurementText3, textFieldText: "Head Measurement")
                    
                    Spacer()
                        .frame(height: 15)
                }
                
                //MARK: Pelvis knee
                VStack {
                    MeasurementValue(MeasurementName: $measurementText4, textFieldText: "Pelvis Knee")
                    
                    Spacer()
                        .frame(height: 15)
                }
                
                //MARK: Pelvis Measurement
                VStack {
                    MeasurementValue(MeasurementName: $measurementText5, textFieldText: "Pelvis Measurement")
                    
                    Spacer()
                        .frame(height: 15)
                }
                
                //MARK: Shoulders Measurement
                VStack {
                    MeasurementValue(MeasurementName: $measurementText6, textFieldText: "Shoulders Measurement")
                    
                    Spacer()
                        .frame(height: 15)
                }
               
                //MARK: Shouders Pelvis
                 VStack {
                    MeasurementValue(MeasurementName: $measurementText7, textFieldText: "Shoulders Pelvis")
                     
                     Spacer()
                         .frame(height: 15)
                 }
                
            }
            
            
            Spacer()
            
            Text("Save")
                .foregroundColor(.blue)
                .onTapGesture {
                    db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.currentPersonIndex+1)").collection("Mensurations").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(bigModel.currentPersonIndex+1)-Mensurations").setData(["ArmpitsMeasurement": measurementText1, "ArmsLength": measurementText2, "HeadMeasurement": measurementText3, "PelvisKnee": measurementText4, "PelvisMeasurement": measurementText5, "ShouldersMeasurement": measurementText6, "ShouldersPelvis": measurementText7])
                    print("save")
                    print(measurementText1)
                    print(measurementText2)
                    print(measurementText3)
                    print(measurementText4)
                    print(measurementText5)
                    print(measurementText6)
                    print(measurementText7)
                    
                    bigModel.currentview = ViewEnum.FinalizeOrderViews_RecapMensurations
                    
                    bigModel.getCurrentPersonMeasurement()
                    
                }
            
            Spacer()
                .frame(height: 50)
            
        }.edgesIgnoringSafeArea(.all)
        .background(Color.black)
    }
    
}

//bigModel.persons[bigModel.currentPersonIndex].mensurations?.measurementText1 ?? "nil"

struct MeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementView()
    }
}
