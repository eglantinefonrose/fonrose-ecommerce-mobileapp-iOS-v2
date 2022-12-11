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

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

struct MeasurementView: View {
    
    @Environment(\.colorScheme) var theColorScheme
    @EnvironmentObject var bigModel: BigModel
    @State var showPopup = !BigModel().isPersonChosen
    var user = BigModel.User.self
    
    var body: some View {
        
        if #available(iOS 14.0, *) {

            ZStack {
                
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                HomeView(measurementText1: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.ArmpitsMeasurement ?? "nil",
                             measurementText2: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.ArmsLength ?? "nil",
                             measurementText3: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.HeadMeasurement ?? "nil",
                             measurementText4: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.PelvisKnee ?? "nil",
                             measurementText5: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.PelvisMeasurement ?? "nil",
                             measurementText6: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.ShouldersMeasurement ?? "nil",
                         measurementText7: bigModel.user.persons[bigModel.currentPersonIndex].measurements?.ShouldersPelvis ?? "nil")
            }
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    
}

@available(iOS 14.0, *)
struct HomeView: View {
    
    @EnvironmentObject var bigModel: BigModel
    @State private var orientation = UIDeviceOrientation.portrait
    
    @State var measurementText1: String
    @State var measurementText2: String
    @State var measurementText3: String
    @State var measurementText4: String
    @State var measurementText5: String
    @State var measurementText6: String
    @State var measurementText7: String
    
    var db = Firestore.firestore()
    var user = BigModel.User.self
    var auth = Auth.auth()
    
    var body: some View {
                    
    VStack {
                
        Spacer()
         
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
                    self.bigModel.currentview = .Home_homeFeed0
                }
            
            Spacer()
                .frame(width: 20)
            
        }
                   
        VStack {
            
            Spacer()
                                
            Text("Mensurations")
                .font(.system(size: 35, weight: .bold, design: .default))
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text("all values in millimeters")
                .foregroundColor(Color.gray)
                .font(.system(size: 15, weight: .semibold, design: .default))
                
            Spacer()
            
            }
                
            VStack {
                
                Spacer()
                    
                    if #available(iOS 15.0, *) {
                        ScrollView {
                            
                                LazyVStack {
                                    
                                    MeasurementValue(MeasurementName: measurementText1, textFieldText: "Armpits Measurement")
                                        .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                        .listRowSeparator(.hidden)
                                    
                                    
                                    MeasurementValue(MeasurementName: measurementText2, textFieldText: "Arms Length")
                                        .listRowBackground(Color.black)
                                        .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                        .listRowSeparator(.hidden)
                                    
                                    MeasurementValue(MeasurementName: measurementText3, textFieldText: "Head Measurement")
                                        .listRowBackground(Color.black)
                                        .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                        .listRowSeparator(.hidden)
                                    
                                    
                                    MeasurementValue(MeasurementName: measurementText4, textFieldText: "Pelvis Knee")
                                        .listRowBackground(Color.black)
                                        .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                        .listRowSeparator(.hidden)
                                    
                                    MeasurementValue(MeasurementName: measurementText5, textFieldText: "Pelvis Measurement")
                                        .listRowBackground(Color.black)
                                        .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                        .listRowSeparator(.hidden)
                                    
                                    MeasurementValue(MeasurementName: measurementText6, textFieldText: "Shoulders Measurement")
                                        .listRowBackground(Color.black)
                                        .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                        .listRowSeparator(.hidden)
                                    
                                    MeasurementValue(MeasurementName: measurementText7, textFieldText: "Shoulders Pelvis")
                                        .listRowBackground(Color.black)
                                        .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                        .listRowSeparator(.hidden)
                                                                   
                                }
                                                        
                        }.frame(height: orientation == .portrait || orientation == .portraitUpsideDown ? 400 : 100)
                        .onRotate { newOrientation in orientation = newOrientation }
                        
                    } else {
                        
                    }
                
                Spacer()
                        
                }
                                            
                VStack {
                    
                    Spacer()
                                        
                    HStack {
                        Spacer()
                        Text("Save")
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                            .padding(10)
                        Spacer()
                    }.background(Color.blue)
                    .cornerRadius(15)
                    .padding(20)
                    .onTapGesture {
                        
                        if measurementText1 != "" && measurementText2 != "" && measurementText3 != "" && measurementText4 != "" && measurementText5 != "" && measurementText6 != "" && measurementText7 != "" {
                            
                            self.bigModel.lastViews.append(.Measurement_Mensurations)
                            
                            print("previous View = \(String(describing: self.bigModel.lastViews.last))")
                            
                            print(self.bigModel.lastViews.count)
                            
                            db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.currentPersonId).collection("Measurements").document(bigModel.user.persons[bigModel.currentPersonIndex].measurements?.id ?? "").setData(["ArmpitsMeasurement": measurementText1, "ArmsLength": measurementText2, "HeadMeasurement": measurementText3, "PelvisMeasurement": measurementText4, "PelvisKnee": measurementText5, "ShouldersMeasurement": measurementText6, "ShouldersPelvis": measurementText7]) { _ in
                                
                                db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.currentPersonId).collection("Measurements").getDocuments { snapshot, error in
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
                                               
                                               bigModel.user.persons[bigModel.currentPersonIndex].measurements = BigModel.Measurements(id: document.documentID, ArmpitsMeasurement: dbArmpitsMeasurement, ArmsLength: dbArmsLength, HeadMeasurement: dbHeadMeasurement, PelvisMeasurement: dbPelvisMeasurement, PelvisKnee: dbPelvisKnee, ShouldersMeasurement: dbShouldersMeasurement, ShouldersPelvis: dbShouldersPelvis)
                                               
                                               
                                           }
                                       }
                                       
                                    bigModel.currentview = .Measurement_RecapMensurations
                                    
                                   }
                                
                            }
                            
                        } else {
                            
                            alertTF(title: "Some fields are empty", message: "Please fill all the fields", primaryTitle: "Ok") {
                                
                            }
                            
                        }
                                                    
                    }
                
            }
                            
        }
        
    }
    
}

struct MeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementView()
            .environmentObject(BigModel(shouldInjectMockedData: true))
    }
}
