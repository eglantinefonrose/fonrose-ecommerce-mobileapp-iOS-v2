//
//  Mensurations.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 25/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import AVKit

struct Mensurations: View {
    
    @State var value : CGFloat = 0
    @State var button1 = false
    @State var button2 = false
    @State var button3 = false
    @State var button4 = false
    @State var button5 = false
    @State var button6 = false
    @State var button7 = false
    @State var video = false
    
    var model: MeasurementInfos
    
    var body: some View {
                
        VStack {
            
            Spacer()
            
            VStack {
                
                                         
                    HStack {
                        
                        VStack {
                        
                            Text("Mensurations")
                                .font(.system(size: 35, weight: .bold, design: .default))
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width)
                            
                        }
                        
                    }
                    
                    Spacer()
                        .frame(height: 120)
                    
                VStack {
                        
                        
                         //MARK: Armpits Measurement
                        
                        VStack {
                            MeasurementValue(MeasurementName: model.ArmpitsMeasurement, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Armpits Measurement")
                             
                            Spacer()
                                .frame(height: 30)
                        }
                        
                        //MARK: Arms Length
                        VStack {
                            MeasurementValue(MeasurementName: model.ArmsLength, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Arms Length")
                             
                            Spacer()
                                .frame(height: 30)
                        }
                        
                        //MARK: Head Measurement
                        VStack {
                            MeasurementValue(MeasurementName: model.HeadMeasurement, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Head Measurement")
                             
                            Spacer()
                                .frame(height: 30)
                        }
                        
                        //MARK: Pelvis knee
                        VStack {
                            MeasurementValue(MeasurementName: model.PelvisKnee, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Pelvis Knee")
                             
                            Spacer()
                                .frame(height: 30)
                        }
                        
                        //MARK: Pelvis Measurement
                        VStack {
                            MeasurementValue(MeasurementName: model.PelvisMeasurement, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Pelvis Measurement")
                             
                            Spacer()
                                .frame(height: 30)
                        }
                        
                        //MARK: Shoulders Measurement
                        VStack {
                            MeasurementValue(MeasurementName: model.ShouldersMeasurement, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Shoulders Measurement")
                             
                            Spacer()
                                .frame(height: 30)
                        }
                       
                        //MARK: Shouders Pelvis
                        MeasurementValue(MeasurementName: model.ShouldersPelvis, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Shoulders Pelvis")

                
                    }
                    
                
                
                
                
                }//acolade fermante de la big VStack + button
                
                Spacer()
                
                .offset(y: -self.value)
                 .animation(.spring())
                 .onAppear() {
                     
                     NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                         
                         let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                         let height = value.height
                         
                         self.value = height*2/3
                     }
                     
                     NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                         
                         self.value = 0
                }
            }
            
            VStack {
                                        
                Text("rjoirl")
                    .foregroundColor(.blue)
                
            }
            
            Spacer()
            .frame(height: 30)
            
        }.background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
        }
    }

struct ButtonModel: View {
    
    @State var buttonName: Bool
    var videoPlayerName: String
    
    var body: some View {
        
        ZStack {
            Button(action: {
                self.buttonName.toggle()
            }) {
                Text("？")
                    .foregroundColor(.blue)
                    .frame(width: 30, height: 30)
            }
            
            if buttonName == true {
                
                VStack {
                    
                    Text("fjlr")
                    
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(Color.black)
                
            }
            
        }
    }
}




struct Mensurations_Previews: PreviewProvider {
    static var previews: some View {
        Mensurations(model: Measurement[0])
    }
}
