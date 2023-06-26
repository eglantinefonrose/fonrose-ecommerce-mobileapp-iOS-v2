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

func sum(array: [Int]) -> Int {
    var s = 0
    for i in 0..<array.count {
        s = s + array[i]
    }
    return s
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
                
                HomeView()
                
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
    @Environment(\.colorScheme) var theColorScheme
    
    @State var measurementText0: String = ""
    @State var measurementText1: String = ""
    @State var measurementText2: String = ""
    @State var measurementText3: String = ""
    @State var measurementText4: String = ""
    @State var measurementText5: String = ""
    @State var measurementText6: String = ""
    @State var measurementText7: String = ""
    @State var measurementText8: String = ""
    @State var measurementText9: String = ""
    @State var measurementText10: String = ""
    @State var measurementText11: String = ""
    @State var measurementText12: String = ""
    @State var measurementText13: String = ""
    @State var arrayOfFields: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    @State var measurementsTexts: [String] = []
    
    var db = Firestore.firestore()
    var user = BigModel.User.self
    var auth = Auth.auth()
    
    var body: some View {
                    
    VStack {
                
        Spacer()
         
        BackButtonModel(text: "Measurements")
                   
        VStack {
            
            Spacer()
                                
            Text("Mensurations")
                .font(.system(size: 35, weight: .bold, design: .default))
                .fontWeight(.semibold)
            
            Text("all values in millimeters")
                .foregroundColor(Color.gray)
                .font(.system(size: 15, weight: .semibold, design: .default))
                
            Spacer()
            
            }
                
            VStack {
                
                Spacer()
                    
                    if #available(iOS 15.0, *) {
                        
                        ScrollView {
                            
                            if bigModel.currentPersonIndex != nil {
                                VStack {
                                    
                                    Text(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[0].measurementName ?? "nil")
                                    Text(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[1].measurementName ?? "nil")
                                }.frame(height: orientation == .portrait || orientation == .portraitUpsideDown ? 400 : 100)
                                    .onRotate { newOrientation in orientation = newOrientation }
                            }
                                
                        }
                            
                            /*VStack(spacing: 20) {
                                    
                                Spacer()
                                
                                if bigModel.isMeasurementRequested(measurementName: "Armpits measurement") {
                                    VStack {
                                     
                                     Spacer()
                                     
                                     HStack {
                                                                         
                                         Spacer()
                                         
                                         TextField("Armpits measurement", text: $measurementText0)
                                             .disableAutocorrection(true)
                                             .autocapitalization(.none)
                                     }
                                     
                                     Spacer()

                                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                    .cornerRadius(7)
                                    .frame(height: 30)
                                    .onChange(of: (measurementText0), perform: { value in
                                        perform: do {
                                            if measurementText0.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                    
                                                }
                                            } else {}
                                            
                                            if measurementText0 == "" {
                                                arrayOfFields[0] = 0
                                            } else {
                                                arrayOfFields[0] = 1
                                            }
                                            
                                        }
                                    })
                                } else {
                                    
                                    if bigModel.currentPersonIndex != nil {
                                        Text(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[0].measurementName ?? "rien")
                                    }
                                    
                                }
                                
                                if bigModel.isMeasurementRequested(measurementName: bigModel.allMeasurements[1].measurementName) {
                                    VStack {
                                     
                                     Spacer()
                                     
                                     HStack {
                                                                         
                                         Spacer()
                                         
                                         TextField(bigModel.allMeasurements[1].measurementName, text: $measurementText1)
                                             .disableAutocorrection(true)
                                             .autocapitalization(.none)
                                     }
                                     
                                     Spacer()

                                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                    .cornerRadius(7)
                                    .frame(height: 30)
                                    .onChange(of: (measurementText1), perform: { value in
                                        perform: do {
                                            if measurementText1.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                    
                                                }
                                            } else {}
                                            
                                            if measurementText1 == "" {
                                                arrayOfFields[1] = 0
                                            } else {
                                                arrayOfFields[1] = 1
                                            }
                                            
                                        }
                                    })
                                } else {
                                    Text("0")
                                }
                                
                                if bigModel.isMeasurementRequested(measurementName: bigModel.allMeasurements[2].measurementName) {
                                    VStack {
                                        
                                        Spacer()
                                        
                                        HStack {
                                            
                                            Spacer()
                                            
                                            TextField(bigModel.allMeasurements[2].measurementName, text: $measurementText2)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        
                                        Spacer()
                                        
                                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                        .cornerRadius(7)
                                        .frame(height: 30)
                                        .onChange(of: (measurementText2), perform: { value in
                                        perform: do {
                                            if measurementText2.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                    
                                                }
                                            } else {}
                                            
                                            if measurementText2 == "" {
                                                arrayOfFields[2] = 0
                                            } else {
                                                arrayOfFields[2] = 1
                                            }
                                            
                                        }
                                    })
                                } else {
                                    Text("0")
                                }
                                
                                if bigModel.isMeasurementRequested(measurementName: bigModel.allMeasurements[3].measurementName) {
                                    VStack {
                                        
                                        Spacer()
                                        
                                        HStack {
                                            
                                            Spacer()
                                            
                                            TextField(bigModel.allMeasurements[3].measurementName, text: $measurementText3)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        
                                        Spacer()
                                        
                                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                        .cornerRadius(7)
                                        .frame(height: 30)
                                        .onChange(of: (measurementText3), perform: { value in
                                        perform: do {
                                            if measurementText3.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                    
                                                }
                                            } else {}
                                            
                                            if measurementText3 == "" {
                                                arrayOfFields[3] = 0
                                            } else {
                                                arrayOfFields[3] = 1
                                            }
                                            
                                        }
                                    })
                                } else {
                                    Text("0")
                                }
                                
                                if bigModel.isMeasurementRequested(measurementName: bigModel.allMeasurements[4].measurementName) {
                                    VStack {
                                        
                                        Spacer()
                                        
                                        HStack {
                                            
                                            Spacer()
                                            
                                            TextField(bigModel.allMeasurements[4].measurementName, text: $measurementText4)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        
                                        Spacer()
                                        
                                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                        .cornerRadius(7)
                                        .frame(height: 30)
                                        .onChange(of: (measurementText4), perform: { value in
                                        perform: do {
                                            if measurementText4.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                    
                                                }
                                            } else {}
                                            
                                            if measurementText4 == "" {
                                                arrayOfFields[4] = 0
                                            } else {
                                                arrayOfFields[4] = 1
                                            }
                                            
                                        }
                                    })
                                }
                                
                                if bigModel.isMeasurementRequested(measurementName: bigModel.allMeasurements[5].measurementName) {
                                    VStack {
                                        
                                        Spacer()
                                        
                                        HStack {
                                            
                                            Spacer()
                                            
                                            TextField(bigModel.allMeasurements[5].measurementName, text: $measurementText5)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        
                                        Spacer()
                                        
                                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                        .cornerRadius(7)
                                        .frame(height: 30)
                                        .onChange(of: (measurementText5), perform: { value in
                                        perform: do {
                                            if measurementText5.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                    
                                                }
                                            } else {}
                                            
                                            if measurementText5 == "" {
                                                arrayOfFields[5] = 0
                                            } else {
                                                arrayOfFields[5] = 1
                                            }
                                            
                                        }
                                    })
                                }
                                
                                if bigModel.isMeasurementRequested(measurementName: bigModel.allMeasurements[6].measurementName) {
                                    
                                    VStack {
                                        
                                        Spacer()
                                        
                                        HStack {
                                            
                                            Spacer()
                                            
                                            TextField(bigModel.allMeasurements[6].measurementName, text: $measurementText6)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        
                                        Spacer()
                                        
                                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                        .cornerRadius(7)
                                        .frame(height: 30)
                                        .onChange(of: (measurementText6), perform: { value in
                                        perform: do {
                                            if measurementText6.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                    
                                                }
                                            } else {}
                                            
                                            if measurementText6 == "" {
                                                arrayOfFields[6] = 0
                                            } else {
                                                arrayOfFields[6] = 1
                                            }
                                            
                                        }
                                    })
                                }
                                
                                VStack {
                                    
                                    if bigModel.isMeasurementRequested(measurementName: bigModel.allMeasurements[7].measurementName) {
                                        
                                        VStack {
                                            
                                            Spacer()
                                            
                                            HStack {
                                                
                                                Spacer()
                                                
                                                TextField(bigModel.allMeasurements[7].measurementName, text: $measurementText7)
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(.none)
                                            }
                                            
                                            Spacer()
                                            
                                        }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                            .cornerRadius(7)
                                            .frame(height: 30)
                                            .onChange(of: (measurementText7), perform: { value in
                                            perform: do {
                                                if measurementText7.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                    alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                        
                                                    }
                                                } else {}
                                                
                                                if measurementText7 == "" {
                                                    arrayOfFields[7] = 0
                                                } else {
                                                    arrayOfFields[7] = 1
                                                }
                                                
                                            }
                                        })
                                    }
                                    
                                    if bigModel.isMeasurementRequested(measurementName: bigModel.allMeasurements[8].measurementName) {
                                        
                                        VStack {
                                            
                                            Spacer()
                                            
                                            HStack {
                                                
                                                Spacer()
                                                
                                                TextField(bigModel.allMeasurements[8].measurementName, text: $measurementText8)
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(.none)
                                            }
                                            
                                            Spacer()
                                            
                                        }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                            .cornerRadius(7)
                                            .frame(height: 30)
                                            .onChange(of: (measurementText6), perform: { value in
                                            perform: do {
                                                if measurementText8.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                    alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                        
                                                    }
                                                } else {}
                                                
                                                if measurementText8 == "" {
                                                    arrayOfFields[8] = 0
                                                } else {
                                                    arrayOfFields[8] = 1
                                                }
                                                
                                            }
                                        })
                                    }
                                    
                                    if bigModel.isMeasurementRequested(measurementName: bigModel.allMeasurements[9].measurementName) {
                                        
                                        VStack {
                                            
                                            Spacer()
                                            
                                            HStack {
                                                
                                                Spacer()
                                                
                                                TextField(bigModel.allMeasurements[9].measurementName, text: $measurementText9)
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(.none)
                                            }
                                            
                                            Spacer()
                                            
                                        }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                            .cornerRadius(7)
                                            .frame(height: 30)
                                            .onChange(of: (measurementText9), perform: { value in
                                            perform: do {
                                                if measurementText9.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                    alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                        
                                                    }
                                                } else {}
                                                
                                                if measurementText9 == "" {
                                                    arrayOfFields[9] = 0
                                                } else {
                                                    arrayOfFields[9] = 1
                                                }
                                                
                                            }
                                        })
                                    }
                                    
                                    if bigModel.isMeasurementRequested(measurementName: bigModel.allMeasurements[10].measurementName) {
                                        
                                        VStack {
                                            
                                            Spacer()
                                            
                                            HStack {
                                                
                                                Spacer()
                                                
                                                TextField(bigModel.allMeasurements[10].measurementName, text: $measurementText10)
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(.none)
                                            }
                                            
                                            Spacer()
                                            
                                        }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                            .cornerRadius(7)
                                            .frame(height: 30)
                                            .onChange(of: (measurementText10), perform: { value in
                                            perform: do {
                                                if measurementText10.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                    alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                        
                                                    }
                                                } else {}
                                                
                                                if measurementText10 == "" {
                                                    arrayOfFields[10] = 0
                                                } else {
                                                    arrayOfFields[10] = 1
                                                }
                                                
                                            }
                                        })
                                    }
                                    
                                    if bigModel.isMeasurementRequested(measurementName: bigModel.allMeasurements[11].measurementName) {
                                        
                                        VStack {
                                            
                                            Spacer()
                                            
                                            HStack {
                                                
                                                Spacer()
                                                
                                                TextField(bigModel.allMeasurements[11].measurementName, text: $measurementText10)
                                                    .disableAutocorrection(true)
                                                    .autocapitalization(.none)
                                            }
                                            
                                            Spacer()
                                            
                                        }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                            .cornerRadius(7)
                                            .frame(height: 30)
                                            .onChange(of: (measurementText11), perform: { value in
                                            perform: do {
                                                if measurementText11.rangeOfCharacter(from: CharacterSet.symbols) != nil || measurementText11.rangeOfCharacter(from: CharacterSet.letters) != nil  {
                                                    alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {
                                                        
                                                    }
                                                } else {}
                                                
                                                if measurementText11 == "" {
                                                    arrayOfFields[11] = 0
                                                } else {
                                                    arrayOfFields[11] = 1
                                                }
                                                
                                            }
                                        })
                                    }

                                    
                                }

                                
                                Spacer()
                                                                   
                                }*/
                                                        
                        }
                        
                    /*} else {
                        
                    }*/
                
                Spacer()
                        
                }
                                            
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "questionmark.video")
                            .foregroundColor(.blue)
                        Text("Comment prendre ses mensurations ?")
                            .foregroundColor(.blue)
                            .font(.body)
                            .underline()
                            .onTapGesture {
                                bigModel.currentview = .Measurement_MeasurementsTut
                            }
                    }
                                        
                    HStack {
                        Spacer()
                        Text("Save")
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                            .padding(10)
                        Spacer()
                    }.background(Color.blue)
                    .cornerRadius(15)
                    .onTapGesture {
                        
                        print(measurementText1)
                        print(measurementText2)
                        print(measurementText3)
                        print(measurementText4)
                        
                        if sum(array: arrayOfFields) == bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements.count {
                            
                            let docRef = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements
                            self.db.collection("q").document().setData(["name": "name"])
                            
                            bigModel.currentview = .Measurement_RecapMensurations
                        } else {
                            alertTF(title: "Some fields are empty", message: "Please fill all the fields", primaryTitle: "Ok") {
                            }
                        }
                            
                        /*if measurementText1 != "" && measurementText2 != "" && measurementText3 != "" && measurementText4 != "" && measurementText5 != "" && measurementText6 != "" && measurementText7 != "" {
                            
                            /*self.bigModel.lastViews.append(.Measurement_Mensurations)
                            
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
                                
                            }*/
                            
                        } else {
                            
                            alertTF(title: "Some fields are empty", message: "Please fill all the fields", primaryTitle: "Ok") {
                                
                            }
                            
                        }*/
                                                    
                    }
                
            }
                            
    }.padding(20)
            .onAppear {
                measurementText1 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[0].measurementValue ?? "nil"
                measurementText2 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[1].measurementValue ?? "nil"
                measurementText3 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[2].measurementValue ?? "nil"
                measurementText4 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[3].measurementValue ?? "nil"
                measurementText5 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[4].measurementValue ?? "nil"
                measurementText6 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[5].measurementValue ?? "nil"
                measurementText7 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[6].measurementValue ?? "nil"
                self.measurementsTexts = [measurementText1, measurementText2, measurementText3, measurementText4, measurementText5, measurementText6, measurementText7]
            }
        
    }
    
}

struct MeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementView()
            .environmentObject(BigModel(shouldInjectMockedData: true))
    }
}
