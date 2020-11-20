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
    
    @State var armpitsNewValue: String = ""
    @State var armsNewValue: String = ""
    @State var headNewValue: String = ""
    @State var pelvisKneeNewValue: String = ""
    @State var pelvisNewValue: String = ""
    @State var shouldersNewValue: String = ""
    @State var shoudersPelvisNewValue: String = ""
    
    @EnvironmentObject var bigModel: BigModel
    
    @State var value : CGFloat = 0
    @State var button1 = false
    @State var button2 = false
    @State var button3 = false
    @State var button4 = false
    @State var button5 = false
    @State var button6 = false
    @State var button7 = false
    @State var video = false
    @State var isTrembling: Bool = false
    
    @State var size1 : CGFloat = 0
    @State var size2 : CGFloat = 0
    @State var size3 : CGFloat = 0
    @State var size4 : CGFloat = 0
    @State var size5 : CGFloat = 0
    @State var size6 : CGFloat = 0
    @State var size7 : CGFloat = 0
        
    var body: some View {
                        
        GeometryReader { reader in

            ZStack {
                
                VStack {

                    Spacer()
                        .frame(height: 50)

                    HStack {

                       Spacer()
                            .frame(width: 30)

                       Button(action: {
                           self.bigModel.currentview = .MeasurementCarouselView
                       }) {
                           Text("Back")
                       }

                       Spacer()

                    }.frame(width: UIScreen.main.bounds.width)

                    Spacer()

                }.frame(height: UIScreen.main.bounds.height)
                
                VStack {
                    
                    Spacer()
                        .frame(height: 150)
                    
                    VStack {
                        
                                                 
                            HStack {
                                
                                VStack {
                                
                                    Text("Mensurations")
                                        .font(.system(size: 35, weight: .bold, design: .default))
                                        .foregroundColor(Color.white)
                                        .frame(width: UIScreen.main.bounds.width)
                                    
                                    Spacer()
                                        .frame(height: 15)
                                    
                                    Text("all values in millimeters")
                                    .foregroundColor(Color.gray)
                                        .font(.system(size: 15, weight: .semibold, design: .default))
                                    
                                }
                                
                            }
                            
                        Spacer()
                            
                        VStack {
                                
                                
                                 //MARK: Armpits Measurement
                                
                                VStack {
                                    
                                    MeasurementValue(buttonCurrentSize: self.size1, MeasurementName: self.$armpitsNewValue, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Armpits Measurement")
                                    
                                    Spacer()
                                        .frame(height: 30)
                                }
                                
                                
                                //MARK: Arms Length
                                VStack {
                                    
                                    MeasurementValue(buttonCurrentSize: self.size2, MeasurementName: self.$armsNewValue, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Arms Length")
                                    
                                    Spacer()
                                        .frame(height: 30)
                                }
                                
                                //MARK: Head Measurement
                                VStack {
                                    MeasurementValue(buttonCurrentSize: self.size3, MeasurementName: self.$headNewValue, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Head Measurement")
                                    
                                    Spacer()
                                        .frame(height: 30)
                                }
                                
                                //MARK: Pelvis knee
                                VStack {
                                    MeasurementValue(buttonCurrentSize: self.size4, MeasurementName: self.$pelvisKneeNewValue, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Pelvis knee")
                                    
                                    Spacer()
                                        .frame(height: 30)
                                }
                                
                                //MARK: Pelvis Measurement
                                VStack {
                                    MeasurementValue(buttonCurrentSize: self.size5, MeasurementName: self.$pelvisNewValue, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Pelvis Measurement")
                                    
                                    Spacer()
                                        .frame(height: 30)
                                }
                                
                                //MARK: Shoulders Measurement
                                VStack {
                                    MeasurementValue(buttonCurrentSize: self.size6, MeasurementName: self.$shouldersNewValue, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Shoulders Measurement")
                                    
                                    Spacer()
                                        .frame(height: 30)
                                }
                               
                                //MARK: Shouders Pelvis
                            MeasurementValue(buttonCurrentSize: self.size7, MeasurementName: self.$shoudersPelvisNewValue, MeasurementVideoName: "https://www.jacquemus.com/content/uploads/2020/04/Jacquemus-SS20-Reimagined-Mobile.mp4.mp4", textFieldText: "Shoulders Measurement")
                                
                            }
                            
                        Spacer()
                        
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
                    
                    Spacer()
                    
                    VStack {
                        
                        Button(action: {

                            self.size1 = reader.size.width / 40
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                self.size2 = reader.size.width / 40
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                self.size3 = reader.size.width / 40
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                self.size4 = reader.size.width / 40
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                self.size5 = reader.size.width / 40
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                self.size6 = reader.size.width / 40
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                                self.size7 = reader.size.width / 40
                            }

                        }) {
                            Text("Comment prendre ses mesures ?")
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button(action: {
                            
                            if self.bigModel.commingFromMeasurement == false {
                                self.bigModel.currentview = .FinalizeOrderViews_RecapMensurations
                            }
                            else {
                                self.bigModel.currentview = .FinalizeOrderViews_PaymentScreen
                            }
                            
                            self.bigModel.armpitsMeasurement = self.armpitsNewValue
                            self.bigModel.armsLength = self.armsNewValue
                            self.bigModel.headMeasurement = self.headNewValue
                            self.bigModel.pelvisKnee = self.pelvisKneeNewValue
                            self.bigModel.pelvisMeasurement = self.pelvisNewValue
                            self.bigModel.shouldersMeasurement = self.shouldersNewValue
                            
                        }) {
                            
                        ZStack {
                            Rectangle()
                                .foregroundColor(.blue)
                                .cornerRadius(30)
                                .frame(width: 150, height: 30)
                                
                            Text("Valider")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            }
                        }
                    }
                    
                    Spacer()
                    .frame(height: 50)
                    
                }
            
            }.background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
        }
            
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
        Mensurations()
    }
}
