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
    @State var showPopup = false // BUG ici à régler. On ne peut pas utiliser BigModel() comme ça       !BigModel().isPersonChosen
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
    @State var neededMeasurements: [BigModel.NeededMeasurementsModel] = []
    
    @State var arrayOfFields: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    @State var measurementsTexts: [String] = []
    
    var db = Firestore.firestore()
    var user = BigModel.User.self
    var auth = Auth.auth()
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
        
        VStack(spacing: 20) {
            
            BackButtonModel(text: "measurements")
            
            VStack {
                                
                Text("measurements")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .fontWeight(.semibold)
                
                Text("all-values-in-millimeters")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 15, weight: .semibold, design: .default))
                
            }
            
            Spacer()
            
            VStack {
                
                
                if #available(iOS 15.0, *) {
                    
                    ScrollView {
                        
                        VStack(spacing: 20) {
                            
                            if bigModel.isMeasurements0Requested ||  bigModel.selectedProductId == nil {
                                
                                VStack {
                                    
                                    Spacer()
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        TextField(LocalizedStringKey(bigModel.allMeasurements[0].measurementName), text: $measurementText0)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    
                                    Spacer()
                                    
                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                    .cornerRadius(7)
                                    .frame(height: 30)
                                    .onAppear {
                                        if measurementText0 != "" {
                                            arrayOfFields[0] = 1
                                        }
                                    }
                                    .onChange(of: (measurementText0), perform: { value in
                                    perform: do {
                                        if measurementText0.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                            alertTF(title: "only-numbers-are-allowed", message: "plz-only-numbers", primaryTitle: "Ok") {
                                                
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
                            
                            if bigModel.isMeasurements1Requested ||  bigModel.selectedProductId == nil {
                                VStack {
                                    
                                    Spacer()
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        TextField(LocalizedStringKey(bigModel.allMeasurements[1].measurementName), text: $measurementText1)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    
                                    Spacer()
                                    
                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                    .cornerRadius(7)
                                    .frame(height: 30)
                                    .onAppear {
                                        if measurementText1 != "" {
                                            arrayOfFields[1] = 1
                                        }
                                    }
                                    .onChange(of: (measurementText1), perform: { value in
                                    perform: do {
                                        if measurementText1.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                            alertTF(title: "only-numbers-are-allowed", message: "plz-only-numbers", primaryTitle: "Ok") {
                                                
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
                            }
                            
                            if bigModel.isMeasurements2Requested ||  bigModel.selectedProductId == nil {
                                VStack {
                                    
                                    Spacer()
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        TextField(LocalizedStringKey(bigModel.allMeasurements[2].measurementName), text: $measurementText2)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    
                                    Spacer()
                                    
                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                    .cornerRadius(7)
                                    .frame(height: 30)
                                    .onAppear {
                                        if measurementText2 != "" {
                                            arrayOfFields[2] = 1
                                        }
                                    }
                                    .onChange(of: (measurementText2), perform: { value in
                                    perform: do {
                                        if measurementText2.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                            alertTF(title: "only-numbers-are-allowed", message: "plz-only-numbers", primaryTitle: "Ok") {
                                                
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
                            
                            if bigModel.isMeasurements3Requested ||  bigModel.selectedProductId == nil {
                                VStack {
                                    
                                    Spacer()
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        TextField(LocalizedStringKey(bigModel.allMeasurements[3].measurementName), text: $measurementText3)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    
                                    Spacer()
                                    
                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                    .cornerRadius(7)
                                    .frame(height: 30)
                                    .onAppear {
                                        if measurementText3 != "" {
                                            arrayOfFields[3] = 1
                                        }
                                    }
                                    .onChange(of: (measurementText3), perform: { value in
                                    perform: do {
                                        if measurementText3.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                            alertTF(title: "only-numbers-are-allowed", message: "plz-only-numbers", primaryTitle: "Ok") {
                                                
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
                            
                            if bigModel.isMeasurements4Requested ||  bigModel.selectedProductId == nil {
                                VStack {
                                    
                                    Spacer()
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        TextField(LocalizedStringKey(bigModel.allMeasurements[4].measurementName), text: $measurementText4)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    
                                    Spacer()
                                    
                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                    .cornerRadius(7)
                                    .frame(height: 30)
                                    .onAppear {
                                        if measurementText4 != "" {
                                            arrayOfFields[4] = 1
                                        }
                                    }
                                    .onChange(of: (measurementText4), perform: { value in
                                    perform: do {
                                        if measurementText4.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                            alertTF(title: "only-numbers-are-allowed", message: "plz-only-numbers", primaryTitle: "Ok") {
                                                
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
                            
                            if bigModel.isMeasurements5Requested ||  bigModel.selectedProductId == nil {
                                VStack {
                                    
                                    Spacer()
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        TextField(LocalizedStringKey(bigModel.allMeasurements[5].measurementName), text: $measurementText5)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    
                                    Spacer()
                                    
                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                    .cornerRadius(7)
                                    .frame(height: 30)
                                    .onAppear {
                                        if measurementText5 != "" {
                                            arrayOfFields[5] = 1
                                        }
                                    }
                                    .onChange(of: (measurementText5), perform: { value in
                                    perform: do {
                                        if measurementText5.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                            alertTF(title: "only-numbers-are-allowed", message: "plz-only-numbers", primaryTitle: "Ok") {
                                                
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
                            
                            if bigModel.isMeasurements6Requested ||  bigModel.selectedProductId == nil {
                                
                                VStack {
                                    
                                    Spacer()
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        TextField(LocalizedStringKey(bigModel.allMeasurements[6].measurementName), text: $measurementText6)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    
                                    Spacer()
                                    
                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                    .cornerRadius(7)
                                    .frame(height: 30)
                                    .onAppear {
                                        if measurementText6 != "" {
                                            arrayOfFields[6] = 1
                                        }
                                    }
                                    .onChange(of: (measurementText6), perform: { value in
                                    perform: do {
                                        if measurementText6.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                            alertTF(title: "only-numbers-are-allowed", message: "plz-only-numbers", primaryTitle: "Ok") {
                                                
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
                            
                            VStack(spacing: 20) {
                                
                                if bigModel.isMeasurements7Requested ||  bigModel.selectedProductId == nil {
                                    
                                    VStack {
                                        
                                        Spacer()
                                        
                                        HStack {
                                            
                                            Spacer()
                                            
                                            TextField(LocalizedStringKey(bigModel.allMeasurements[7].measurementName), text: $measurementText7)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        
                                        Spacer()
                                        
                                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                        .cornerRadius(7)
                                        .frame(height: 30)
                                        .onAppear {
                                            if measurementText7 != "" {
                                                arrayOfFields[7] = 1
                                            }
                                        }
                                        .onChange(of: (measurementText7), perform: { value in
                                        perform: do {
                                            if measurementText7.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                alertTF(title: "only-numbers-are-allowed", message: "plz-only-numbers", primaryTitle: "Ok") {
                                                    
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
                                
                                if bigModel.isMeasurements8Requested ||  bigModel.selectedProductId == nil {
                                    
                                    VStack {
                                        
                                        Spacer()
                                        
                                        HStack {
                                            
                                            Spacer()
                                            
                                            TextField(LocalizedStringKey(bigModel.allMeasurements[8].measurementName), text: $measurementText8)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        
                                        Spacer()
                                        
                                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                        .cornerRadius(7)
                                        .frame(height: 30)
                                        .onAppear {
                                            if measurementText8 != "" {
                                                arrayOfFields[8] = 1
                                            }
                                        }
                                        .onChange(of: (measurementText8), perform: { value in
                                        perform: do {
                                            if measurementText8.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                alertTF(title: "only-numbers-are-allowed", message: "plz-only-numbers", primaryTitle: "Ok") {
                                                    
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
                                
                                if bigModel.isMeasurements9Requested ||  bigModel.selectedProductId == nil {
                                    
                                    VStack {
                                        
                                        Spacer()
                                        
                                        HStack {
                                            
                                            Spacer()
                                            
                                            TextField(LocalizedStringKey(bigModel.allMeasurements[9].measurementName), text: $measurementText9)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        
                                        Spacer()
                                        
                                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                        .cornerRadius(7)
                                        .frame(height: 30)
                                        .onAppear {
                                            if measurementText9 != "" {
                                                arrayOfFields[9] = 1
                                            }
                                        }
                                        .onChange(of: (measurementText9), perform: { value in
                                        perform: do {
                                            if measurementText9.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                alertTF(title: "only-numbers-are-allowed", message: "plz-only-numbers", primaryTitle: "Ok") {
                                                    
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
                                
                                if bigModel.isMeasurements10Requested ||  bigModel.selectedProductId == nil {
                                    
                                    VStack {
                                        
                                        Spacer()
                                        
                                        HStack {
                                            
                                            Spacer()
                                            
                                            TextField(LocalizedStringKey(bigModel.allMeasurements[10].measurementName), text: $measurementText10)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        
                                        Spacer()
                                        
                                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                        .cornerRadius(7)
                                        .frame(height: 30)
                                        .onAppear {
                                            if measurementText10 != "" {
                                                arrayOfFields[10] = 1
                                            }
                                        }
                                        .onChange(of: (measurementText10), perform: { value in
                                        perform: do {
                                            if measurementText10.rangeOfCharacter(from: CharacterSet.letters) != nil {
                                                alertTF(title: "only-numbers-are-allowed", message: "plz-only-numbers", primaryTitle: "Ok") {
                                                    
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
                                
                                if bigModel.isMeasurements11Requested ||  bigModel.selectedProductId == nil {
                                    
                                    
                                    VStack {
                                        
                                        Spacer()
                                        
                                        HStack {
                                            
                                            Spacer()
                                            
                                            TextField(LocalizedStringKey(bigModel.allMeasurements[11].measurementName), text: $measurementText11)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        
                                        Spacer()
                                        
                                    }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                        .cornerRadius(7)
                                        .frame(height: 30)
                                        .onAppear {
                                            if measurementText11 != "" {
                                                arrayOfFields[11] = 1
                                            }
                                        }
                                        .onChange(of: (measurementText11), perform: { value in
                                        perform: do {
                                            if measurementText11.rangeOfCharacter(from: CharacterSet.symbols) != nil || measurementText11.rangeOfCharacter(from: CharacterSet.letters) != nil  {
                                                alertTF(title: "only-numbers-are-allowed", message: "plz-only-numbers", primaryTitle: "Ok") {
                                                    
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
                            
                        }
                    }
                    
                }
                
                /*} else {
                 
                 }*/
                
                Spacer()
                
            }
            
            Spacer()
            
            VStack {
                
                HStack {
                    VStack {
                        Image(systemName: "chevron.down")
                        Image(systemName: "chevron.down")
                    }
                    Text("scroll-down-to-see-all-measurements")
                }
                
                HStack {
                    Image(systemName: "questionmark.video")
                        .foregroundColor(.blue)
                    Text("how-to-take-your-measurements")
                        .foregroundColor(.blue)
                        .font(.body)
                        .underline()
                        .onTapGesture {
                            bigModel.lastViews.append(.Measurement_Mensurations)
                            bigModel.currentview = .Measurement_MeasurementsTut
                        }
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
                        
                        print(arrayOfFields)
                        
                        if (sum(array: arrayOfFields) == bigModel.neededMeasurements.count || bigModel.selectedProductId == nil) && (measurementText0 != "") && (measurementText1 != "") && (measurementText2 != "") && (measurementText3 != "") && (measurementText4 != "") && (measurementText5 != "") && (measurementText6 != "") && (measurementText7 != "") && (measurementText8 != "") && (measurementText9 != "") && (measurementText10 != "") && (measurementText11 != "") {
                            
                            guard let userId = auth.currentUser?.uid else { return }
                            let docRef = db.collection("users").document("user\(userId)").collection("persons").document(bigModel.currentPersonId).collection("Measurements").document(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.id ?? "nil")
                            
                            do {
                                try docRef.setData(from: BigModel.Measurements(measurements: [
                                    BigModel.MeasurementModel(id: 0, measurementName: "Armpits measurement", measurementValue: measurementText0),
                                    BigModel.MeasurementModel(id: 1, measurementName: "Arms length", measurementValue: measurementText1),
                                    BigModel.MeasurementModel(id: 2, measurementName: "Head measurement", measurementValue: measurementText2),
                                    BigModel.MeasurementModel(id: 3, measurementName: "Pelvis measurement", measurementValue: measurementText3),
                                    BigModel.MeasurementModel(id: 4, measurementName: "Pelvis Knee", measurementValue: measurementText4),
                                    BigModel.MeasurementModel(id: 5, measurementName: "Shoulders measurement", measurementValue: measurementText5),
                                    BigModel.MeasurementModel(id: 6, measurementName: "Shoulders pelvis", measurementValue: measurementText6),
                                    BigModel.MeasurementModel(id: 7, measurementName: "Tour de poitrine", measurementValue: measurementText7),
                                    BigModel.MeasurementModel(id: 8, measurementName: "Entrejambe", measurementValue: measurementText8),
                                    BigModel.MeasurementModel(id: 9, measurementName: "Aisselles-Tetons", measurementValue: measurementText9),
                                    BigModel.MeasurementModel(id: 10, measurementName: "Teton-Nombril", measurementValue: measurementText10),
                                    BigModel.MeasurementModel(id: 11, measurementName: "Teton-Hanches", measurementValue: measurementText11)
                                ]))
                            } catch {
                                print(error)
                            }
                            
                            Task {
                                await bigModel.fetchMeasurements()
                                bigModel.currentview = .Measurement_RecapMensurations
                                self.bigModel.lastViews.append(.Measurement_Mensurations)
                            }
                            
                        } else {
                            
                            if !(sum(array: arrayOfFields) == bigModel.neededMeasurements.count || bigModel.selectedProductId == nil) {
                                alertTF(title: "Some fields are empty", message: "Please fill all the fields", primaryTitle: "Ok") {}
                            }
                            if (measurementText0 != "") && (measurementText1 != "") && (measurementText2 != "") && (measurementText3 != "") && (measurementText4 != "") && (measurementText5 != "") && (measurementText6 != "") && (measurementText7 != "") && (measurementText8 != "") && (measurementText9 != "") && (measurementText10 != "") && (measurementText11 != "") {
                                alertTF(title: "Only numbers are allowed", message: "Please enter only numbers in the text fields (enter all measurements in millimeters)", primaryTitle: "Ok") {}
                            }
                            
                        }
                        
                        
                        
                    }
                
            }
            
        }.padding(20)
            .onAppear {
                measurementText0 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[0].measurementValue ?? ""
                measurementText1 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[1].measurementValue ?? ""
                measurementText2 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[2].measurementValue ?? ""
                measurementText3 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[3].measurementValue ?? ""
                measurementText4 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[4].measurementValue ?? ""
                measurementText5 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[5].measurementValue ?? ""
                measurementText6 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[6].measurementValue ?? ""
                measurementText7 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[7].measurementValue ?? ""
                measurementText8 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[8].measurementValue ?? ""
                measurementText9 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[9].measurementValue ?? ""
                measurementText10 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[10].measurementValue ?? ""
                measurementText11 = bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[11].measurementValue ?? ""
                
                if measurementText0 != "" && bigModel.isMeasurements0Requested {
                    arrayOfFields[0] = 1
                }
                if measurementText1 != "" && bigModel.isMeasurements1Requested {
                    arrayOfFields[1] = 1
                }
                if measurementText2 != "" && bigModel.isMeasurements2Requested {
                    arrayOfFields[2] = 1
                }
                if measurementText3 != "" && bigModel.isMeasurements3Requested {
                    arrayOfFields[3] = 1
                }
                if measurementText4 != "" && bigModel.isMeasurements4Requested {
                    arrayOfFields[4] = 1
                }
                if measurementText5 != "" && bigModel.isMeasurements5Requested {
                    arrayOfFields[5] = 1
                }
                if measurementText6 != "" && bigModel.isMeasurements6Requested {
                    arrayOfFields[6] = 1
                }
                if measurementText7 != "" && bigModel.isMeasurements7Requested {
                    arrayOfFields[7] = 1
                }
                if measurementText8 != "" && bigModel.isMeasurements8Requested {
                    arrayOfFields[8] = 1
                }
                if measurementText9 != "" && bigModel.isMeasurements9Requested {
                    arrayOfFields[9] = 1
                }
                if measurementText10 != "" && bigModel.isMeasurements10Requested {
                    arrayOfFields[10] = 1
                }
                if measurementText11 != "" && bigModel.isMeasurements11Requested {
                    arrayOfFields[11] = 1
                }
                
                /*Task {
                 do {
                 self.neededMeasurements = try await bigModel.fetchNeededMeasurementsInfo()
                 }
                 catch {
                 print(error)
                 }
                 }*/
                
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
