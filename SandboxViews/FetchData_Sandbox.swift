//
//  FetchData_Sandbox.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 28/04/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI

struct FetchData_Sandbox: View {
    
    @EnvironmentObject var bigModel: BigModel
    var allMeasurements: [BigModel.MeasurementModel] = [BigModel.MeasurementModel(id: 0, measurementName: "TourDeTaille", measurementValue: ""),
    BigModel.MeasurementModel(id: 1, measurementName: "TourDeTaille", measurementValue: ""),
    BigModel.MeasurementModel(id: 2, measurementName: "TourDeHanches", measurementValue: ""),
    BigModel.MeasurementModel(id: 3, measurementName: "Shoulders", measurementValue: ""),
    BigModel.MeasurementModel(id: 4, measurementName: "PelvisKnee", measurementValue: ""),
    BigModel.MeasurementModel(id: 5, measurementName: "Nombril", measurementValue: ""),
    BigModel.MeasurementModel(id: 6, measurementName: "TourDeTete", measurementValue: ""),
    BigModel.MeasurementModel(id: 7, measurementName: "ArmsLength", measurementValue: ""),
    BigModel.MeasurementModel(id: 8, measurementName: "Entrejambe", measurementValue: ""),
    BigModel.MeasurementModel(id: 9, measurementName: "TourDePoitrine", measurementValue: ""),
    BigModel.MeasurementModel(id: 10, measurementName: "ShouldersPelvis", measurementValue: ""),
    BigModel.MeasurementModel(id: 11, measurementName: "PelvisMeasurement", measurementValue: "")]
    
    var body: some View {
        VStack {
            Text("🤪")
                .onTapGesture {
                    
                    //print("f")
                    
                    let storageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/fonrose-ecommerce-v2.appspot.com/o/NeededMeasurementsInfo.json?alt=media&token=bd0281da-b3c7-4c60-9e09-15160a1c6b54")!
                    let task = URLSession.shared.dataTask(with: storageURL) { data, response, error in
                        guard let data = data, error == nil else {
                            print("Une erreur est survenue : \(String(describing: error))")
                            return
                        }
                        do {
                            let decoder = JSONDecoder()
                            let measurInfo = try decoder.decode([BigModel.NeededMeasurementsModel].self, from: data)
                            //print("ff")
                            for neededMeasurementInfo in measurInfo {
                                
                                //print(neededMeasurementInfo.productName)
                                self.bigModel.neededMeasurement.append(BigModel.NeededMeasurementsModel(id: neededMeasurementInfo.id, productName: neededMeasurementInfo.productName, neededMeasurements: neededMeasurementInfo.neededMeasurements))
                                
                            }
                            
                            
                            
                        } catch {
                            print("Une erreur est survenue lors de l'analyse JSON :  \(String(describing: error))")
                        }
                        
                        for i in 0..<bigModel.neededMeasurement[2].neededMeasurements.count {
                            print(allMeasurements[bigModel.neededMeasurement[2].neededMeasurements[i]].measurementName)
                        }
                        
                    }
                    
                    task.resume()

            }
            Spacer()
            Text("😶‍🌫️")
                .onTapGesture {
                    for i in 0..<bigModel.neededMeasurement.count {
                        print(bigModel.neededMeasurement[i].productName)
                        print(bigModel.neededMeasurement[i].neededMeasurements)
                    }
                }
        }
    }
}

struct FetchData_Sandbox_Previews: PreviewProvider {
    static var previews: some View {
        FetchData_Sandbox()
            .environmentObject(BigModel())
    }
}
