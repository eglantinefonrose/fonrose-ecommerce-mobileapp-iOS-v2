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
    var url: URL
    var explanations: String?
}

struct MeasurementsTut: View {
    
    @Environment(\.colorScheme) var theColorScheme
    @EnvironmentObject var bigModel: BigModel
    @State private var orientation = UIDeviceOrientation.portrait
    @Environment(\.presentationMode) var presentationMode
    
    let measurementsTut = [MeasurementTut(id: 0, measurement: "All measurements", url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!),
       MeasurementTut(id: 1, measurement: "Armpits", url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!, explanations: "Levez légèrement votre bras et repérez le creux à coté de la bosse de l’os de l’épaule, puis enroulez le mètre ruban autour de ce point en passant sous l’aisselle"),
       MeasurementTut(id: 2, measurement: "Arms", url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!),
       MeasurementTut(id: 3, measurement: "Head", url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!),
       MeasurementTut(id: 4, measurement: "Pelvis", url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!),
       MeasurementTut(id: 5, measurement: "Pelvis to knee", url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!),
       MeasurementTut(id: 6, measurement: "Shoulders", url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!),
       MeasurementTut(id: 7, measurement: "Shoulders to pelvis", url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!)
    ]
    
    @State var show = false
    @State var currentTutId: Int = 0
    
    var body: some View {
        
        ZStack {
            
            Color("Black")
                .edgesIgnoringSafeArea(.all)
            
            if show {
                ZStack {
                     if #available(iOS 14.0, *) {
                         VideoPlayer(player: AVPlayer(url: measurementsTut[currentTutId].url))
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
                            
                            Text(measurementsTut[currentTutId].measurement)
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Image(systemName: "house")
                                .foregroundColor(Color.blue)
                                .onTapGesture {
                                    bigModel.currentview = .Home_homeFeed0
                                }
                            
                        }.onRotate { newOrientation in orientation = newOrientation }
                            .padding(20)
                        .frame(width: UIScreen.main.bounds.width)
                        Spacer()
                        Text(measurementsTut[currentTutId].explanations ?? "")
                        Spacer()
                        
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
                                            Image("meter-icon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                            Text(measurement.measurement)
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

struct MeasurementsTut_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementPlayerView(explanations: "Repérez votre taille (l’endroit le moins large verticalement entre votre poitrine et vos hanches) et entourez le mètre ruban autour de votre corps à cet endroit, en faisant attention à garder le mètre au même niveau sur l’ensemble de votre corps", url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!, measurementText: "")
        MeasurementsTut()
    }
}
