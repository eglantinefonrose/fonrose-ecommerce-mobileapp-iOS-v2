//
//  MeasurementsTut.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 19/04/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI
import AVKit

struct MeasurementTut: Identifiable, Hashable {
    var id: Int
    var measurement: String
    var imagesNames: [String]
    var explenations: String
}

@available(iOS 14.0, *)
struct MeasurementsTut: View {
    
    @Environment(\.colorScheme) var theColorScheme
    @EnvironmentObject var bigModel: BigModel
    @State private var orientation = UIDeviceOrientation.portrait
    @Environment(\.presentationMode) var presentationMode
    
    let measurementsTut = [MeasurementTut(id: 0, measurement: "All measurements", imagesNames: [], explenations: ""),
                           MeasurementTut(id: 1, measurement: "armpits-measurement", imagesNames: ["armpits-size-1", "armpit-measurement"], explenations: "armpits-measurement-explenations"),
       MeasurementTut(id: 2, measurement: "arms-length", imagesNames: [], explenations: "arms-length-explenations"),
       MeasurementTut(id: 3, measurement: "head-measurement", imagesNames: [], explenations: "head-measurement-explenations"),
       MeasurementTut(id: 4, measurement: "pelvis-measurement", imagesNames: ["hips-size", "hips-size-2"], explenations: "pelvis-measurement-explenations"),
       MeasurementTut(id: 5, measurement: "pelvis-knee", imagesNames: [], explenations: "pelvis-knee-explenations"),
       MeasurementTut(id: 6, measurement: "shoulders-measurement", imagesNames: ["shoulders-size"], explenations: "shoulders-measurement-explenations"),
       MeasurementTut(id: 7, measurement: "shoulders-pelvis", imagesNames: [], explenations: "shoulders-pelvis-explenations"),
       MeasurementTut(id: 8, measurement: "waist-size", imagesNames: ["waist-size", "waist-size2"], explenations: "waist-size-explenations"),
       MeasurementTut(id: 9, measurement: "armpits-tits", imagesNames: ["armpit-nipple"], explenations: "armpits-tits-explenations"),
       MeasurementTut(id: 10, measurement: "tits-belly-button", imagesNames: ["nipple-navel"], explenations: "tits-belly-button-explenations"),
       MeasurementTut(id: 11, measurement: "hips-navel", imagesNames: ["nipple-hips"], explenations: "hips-navel-explenations"),
       MeasurementTut(id: 12, measurement: "waist-navel", imagesNames: ["nipple-waist"], explenations: "waist-navel-explenations"),
       MeasurementTut(id: 13, measurement: "tits-middle-of-breasts", imagesNames: ["mid-tit"], explenations: "tits-middle-of-breasts-explenations")
    ]
    
    @State var show = false
    @State var currentTutId: Int = 0
    @State private var index = 0
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            if show {
                
                ZStack {
                    
                    //Color("Tut-blue")
                        //.edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        BackButtonModel(text: measurementsTut[currentTutId].measurement)
                            .padding(20)
                        
                        ZStack {
                            
                            Color("Tut-blue")
                                .edgesIgnoringSafeArea(.all)
                            
                            VStack {
                                
                                ZStack {
                                    
                                    Color(.white)
                                    
                                    VStack {
                                        
                                        HStack {
                                            Spacer()
                                            Image(systemName: "x.circle")
                                                .foregroundColor(.blue)
                                                .onTapGesture {
                                                    show.toggle()
                                                }
                                        }.padding(20)
                                        
                                        TabView(selection: $index) {
                                            ForEach((0..<measurementsTut[currentTutId].imagesNames.count), id: \.self) { index in
                                                ZStack {
                                                    Image(measurementsTut[currentTutId].imagesNames[index])
                                                        .resizable()
                                                        .scaledToFit()
                                                }
                                            }
                                        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                    }
                                    
                                    if measurementsTut[currentTutId].imagesNames.count > 1 {
                                        VStack {
                                            Spacer()
                                            HStack(spacing: 15) {
                                                ForEach((0..<measurementsTut[currentTutId].imagesNames.count), id: \.self) { index in
                                                    Circle()
                                                        .fill(index == self.index ? Color.gray : Color.gray.opacity(0.5))
                                                        .frame(width: 10, height: 10)

                                                }
                                            }
                                            .padding()
                                        }
                                    }
                                    
                                }
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(LocalizedStringKey(measurementsTut[currentTutId].measurement))
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                        
                                        Text(LocalizedStringKey(measurementsTut[currentTutId].explenations))
                                            .foregroundColor(.white)
                                    }.padding(20)
                                    
                                
                            }
                            
                        }
                        
                    
                        
                }
                    
                }
                
            }
            
            if !show {
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    VStack {
                                                                
                        Text("Tutoriels")
                            .font(.system(size: 35, weight: .bold, design: .default))
                            .fontWeight(.semibold)
                        
                        Text("Comment prendre ses mensurations")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 15, weight: .semibold, design: .default))
                                                
                        }
                    
                    Spacer()
                    
                    if #available(iOS 14.0, *) {
                        
                        let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
                        
                        ScrollView {
                            
                            LazyVGrid(columns: columns) {
                                
                                ForEach(measurementsTut, id: \.self) { measurement in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(height: 150)
                                            .foregroundColor(.blue)
                                        VStack(alignment: .leading) {
                                            
                                            Image(theColorScheme == .light ? "meter-icon" : "meter-icon-white")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                            
                                            Text(LocalizedStringKey(measurement.measurement))
                                                .fontWeight(.semibold)
                                        }
                                    }.onTapGesture {
                                        print(measurement.measurement)
                                        show = true
                                        currentTutId = measurement.id
                                    }
                                }
                            }
                            
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            VStack {
                                Image(systemName: "chevron.down")
                                Image(systemName: "chevron.down")
                            }
                            Text("Scroll down to see every tutorials")
                        }
                        
                        HStack {
                            Spacer()
                            Text("Take my measurements")
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                                .padding(10)
                            Spacer()
                        }.background(Color.blue)
                        .cornerRadius(15)
                        .onTapGesture {
                            self.bigModel.authLastViews.append(.Measurement_MeasurementsTut)
                            bigModel.currentview = .Measurement_Mensurations
                        }
                    }
                    
                }.padding(20)
            }
            
            if !show {
                VStack {
                    BackButtonModel(text: "Measurements Tutorials")
                    Spacer()
                }.padding(20)
                /*VStack {
                    HStack {
                        
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
                        
                    }
                    Spacer()
                }.padding(20)*/
            }
            
        }
    }
}

struct MeasurementPlayerView: View {
    
    @EnvironmentObject var bigModel: BigModel
    @State private var orientation = UIDeviceOrientation.portrait
    @Environment(\.presentationMode) var presentationMode
    @State var showExplanations = false
    var explanations: String
    var url: URL
    var measurementText: String
    @State var show: Bool = true
    
    var body : some View {
        
        ZStack {
             if #available(iOS 14.0, *) {
                VideoPlayer(player: AVPlayer(url: url))
            } else {
                // Fallback on earlier versions
            }
            
            VStack {
                HStack {
                    
                    if #available(iOS 16.0, *) {
                        Image(systemName: "x.circle")
                            .foregroundColor(.blue)
                            .bold()
                            .onTapGesture {
                                self.show = false
                            }
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    Spacer()
                    
                    Text(measurementText)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "house")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            //bigModel.currentview = .Home_homeFeed0
                        }
                    
                }.onRotate { newOrientation in orientation = newOrientation }
                    .padding(20)
                .frame(width: UIScreen.main.bounds.width)
                
                Spacer()
                
                //ZStack(alignment: .leading) {
                    //RoundedRectangle(cornerRadius: 20)
                        //.foregroundColor(.black)
                        //.opacity(0.7)
                    Text(explanations)
                //}
                
                HStack {
                    
                    Spacer()
                    
                    if #available(iOS 14.0, *) {
                        Image(systemName: "text.bubble")
                            .font(.title3)
                            .foregroundColor(Color.blue)
                            .onTapGesture {
                                //bigModel.currentview = .Home_homeFeed0
                            }
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }.onRotate { newOrientation in orientation = newOrientation }
                    .padding(20)
                .frame(width: UIScreen.main.bounds.width)
                
            }.padding(20)
        }
        
    }
}

@available(iOS 14.0, *)
struct MeasurementsTut_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementsTut()
    }
}
