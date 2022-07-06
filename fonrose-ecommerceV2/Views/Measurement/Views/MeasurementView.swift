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
    @State var showPopup = !BigModel().isPersonChosen
    
    var body: some View {
        
        if #available(iOS 14.0, *) {
            
            if !bigModel.isPersonChosen {
    
                AuthView()
                
            } else {

                HomeView(measurementText1: bigModel.persons[bigModel.currentPersonIndex].measurements?.ArmpitsMeasurement ?? "nil",
                             measurementText2: bigModel.persons[bigModel.currentPersonIndex].measurements?.ArmsLength ?? "nil",
                             measurementText3: bigModel.persons[bigModel.currentPersonIndex].measurements?.HeadMeasurement ?? "nil",
                             measurementText4: bigModel.persons[bigModel.currentPersonIndex].measurements?.PelvisKnee ?? "nil",
                             measurementText5: bigModel.persons[bigModel.currentPersonIndex].measurements?.PelvisMeasurement ?? "nil",
                             measurementText6: bigModel.persons[bigModel.currentPersonIndex].measurements?.ShouldersMeasurement ?? "nil",
                             measurementText7: bigModel.persons[bigModel.currentPersonIndex].measurements?.ShouldersPelvis ?? "nil")

            }
            
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
        
        ZStack {
            
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
                
                    VStack {
                    
                    Button(action: {
                        self.bigModel.lastViews.append(.Measurement_Mensurations)
                        
                        print("previous View = \(String(describing: self.bigModel.lastViews.last))")
                        
                        print(self.bigModel.lastViews.count)
                        
                        db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.currentPersonIndex+1)").collection("Mensurations").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(bigModel.currentPersonIndex+1)-Mensurations").setData(["ArmpitsMeasurement": self.measurementText1, "ArmsLength": self.measurementText2, "HeadMeasurement": self.measurementText3, "PelvisMeasurement": self.measurementText4, "PelvisKnee": self.measurementText5, "ShouldersMeasurement": self.measurementText6, "ShouldersPelvis": self.measurementText7])
                        
                        if bigModel.currentPersonIndex+1 < 10 {
                            db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.currentPersonIndex+1)").collection("Mensurations").getDocuments { snapshot, error in
                                guard error == nil else {
                                    print(error!.localizedDescription)
                                    return
                                }
                                
                                if let snapshot = snapshot {
                                    for document in snapshot.documents {
                                        let dbArmpitsMeasurement = document.data()["ArmpitsMeasurement"] as? String ?? ""
                                        let dbArmsLength = document.data()["ArmsLength"] as? String ?? ""
                                        let dbHeadMeasurement = document.data()["HeadMeasurement"] as? String ?? ""
                                        let dbPelvisMeasurement = document.data()["PelvisMeasurement"] as? String ?? ""
                                        let dbPelvisKnee = document.data()["PelvisKnee"] as? String ?? ""
                                        let dbShouldersMeasurement = document.data()["ShouldersMeasurement"] as? String ?? ""
                                        let dbShouldersPelvis = document.data()["ShouldersPelvis"] as? String ?? ""
                                        
                                        bigModel.persons[bigModel.currentPersonIndex].measurements = Measurements(ArmpitsMeasurement: dbArmpitsMeasurement, ArmsLength: dbArmsLength, HeadMeasurement: dbHeadMeasurement, PelvisMeasurement: dbPelvisMeasurement, PelvisKnee: dbPelvisKnee, ShouldersMeasurement: dbShouldersMeasurement, ShouldersPelvis: dbShouldersPelvis)
                                        
                                    }
                                }
                                
                                bigModel.currentview = ViewEnum.FinalizeOrderViews_RecapMensurations
                                
                            }
                            
                        }
                        
                        else {
                            db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(bigModel.currentPersonIndex+1)").collection("Mensurations").getDocuments { snapshot, error in
                                guard error == nil else {
                                    print(error!.localizedDescription)
                                    return
                                }
                                
                                if let snapshot = snapshot {
                                    for document in snapshot.documents {
                                        let dbArmpitsMeasurement = document.data()["ArmpitsMeasurement"] as? String ?? ""
                                        let dbArmsLength = document.data()["ArmsLength"] as? String ?? ""
                                        let dbHeadMeasurement = document.data()["HeadMeasurement"] as? String ?? ""
                                        let dbPelvisMeasurement = document.data()["PelvisMeasurement"] as? String ?? ""
                                        let dbPelvisKnee = document.data()["PelvisKnee"] as? String ?? ""
                                        let dbShouldersMeasurement = document.data()["ShouldersMeasurement"] as? String ?? ""
                                        let dbShouldersPelvis = document.data()["ShouldersPelvis"] as? String ?? ""
                                        
                                        bigModel.persons[bigModel.currentPersonIndex].measurements = Measurements(ArmpitsMeasurement: dbArmpitsMeasurement, ArmsLength: dbArmsLength, HeadMeasurement: dbHeadMeasurement, PelvisMeasurement: dbPelvisMeasurement, PelvisKnee: dbPelvisKnee, ShouldersMeasurement: dbShouldersMeasurement, ShouldersPelvis: dbShouldersPelvis)
                                        
                                    }
                                }
                                
                                bigModel.currentview = ViewEnum.FinalizeOrderViews_RecapMensurations
                                
                            }
                        }
                        
                        print("recap")
                        
                        }) {
                        //Spacer()
                            
                        HStack {
                                
                            Spacer()
                                
                            HStack {
                                
                                Spacer()
                                Text("Save")
                                    .foregroundColor(Color.white)
                                    .fontWeight(.semibold)
                                Spacer()
                            
                            }.background(Color.blue)
                            .frame(width: 150)
                            .cornerRadius(5)
                            
                            Spacer()
                            
                        }.frame(width: UIScreen.main.bounds.width - 50, height: 35)
                        .background(Color.blue)
                        .cornerRadius(15)
                        
                    //Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 25)
                    
                }
                            
            }.background(Color.black)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    
                    Spacer()
                        .frame(width: 20)
                    
                    
                    Text("Back")
                        .foregroundColor(Color.blue)
                        .fontWeight(.semibold)
                        .onTapGesture {
                            if !self.bigModel.lastViews.isEmpty {
                                print("back")
                                self.bigModel.currentview = self.bigModel.lastViews.last ?? .AboutUsScreen
                                self.bigModel.lastViews.removeLast()
                                print("previous View = \(String(describing: self.bigModel.lastViews.last))")
                            } else { print("array empty") }
                        }
                    
                    Spacer()
                    
                    Image(systemName: "house")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.bigModel.currentview = .Home_homeFeed
                        }
                    
                    Spacer()
                        .frame(width: 20)
                    
                }.frame(width: UIScreen.main.bounds.width)
                
                Spacer()
                
            }
            
        }
    }
    
}

struct MeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementView()
            .environmentObject(BigModel())
    }
}
