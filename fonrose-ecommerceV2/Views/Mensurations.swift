//
//  Mensurations.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 25/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct Mensurations: View {
    
    /*@State var ArmpitsMeasurement = ""
    @State var ArmsLength = ""
    @State var HeadMeasurement = ""
    @State var PelvisMeasurement = ""
    @State var PelvisKnee = ""
    @State var ShouldersMeasurement = ""
    @State var ShouldersPelvis = ""*/
    
    var test: MeasurementInfos
    
    //@State var value : CGFloat = 0
    
    
    var body: some View {
        
        //HStack {
            
            //Spacer()
            
            //VStack {
            
            //Spacer()
            
            //VStack {
                
        Text(test.ArmpitsMeasurement)
                
            //}
            
            //Spacer()
                //.frame(height: 80)
            
            /*VStack {
                 
                 //MARK: Armpits Measurement
                 VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                     TextField("Armpits Measurement", text: $ArmpitsMeasurement)
                     .background(Color.gray)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 //MARK: Arms Length
                 VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                     TextField("Arms Length", text: $ArmsLength)
                     .background(Color.gray)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 //MARK: Head Measurement
                 VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                     TextField("Head Measurement", text: $HeadMeasurement)
                     .background(Color.gray)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 //MARK: Pelvis Measurement
                 VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                     TextField("Pelvis Measurement", text: $PelvisMeasurement)
                     .background(Color.gray)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 //MARK: Pelvis Knee
                 VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                     TextField("PelvisKnee", text: $PelvisKnee)
                     .background(Color.gray)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 //MARK: Shoulders Measurement
                 VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                     TextField("Shoulders Measurement", text: $ShouldersMeasurement)
                     .background(Color.gray)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 //MARK: ShouldersPelvis
                 VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                     TextField("Shoulders Pelvis", text: $ShouldersPelvis)
                     .background(Color.gray)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 }//acolade fermante big VStack
                 
                Spacer()
                
                 }.offset(y: -self.value)
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
                }*/
            //}
            //.edgesIgnoringSafeArea(.all)
            
            
            
            //Spacer()
            
        //}//.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        //.background(Color.black)
        //.padding(.vertical, -44)
    }
}


struct Mensurations_Previews: PreviewProvider {
    static var previews: some View {
        Mensurations(test: Measurement[0])
    }
}
