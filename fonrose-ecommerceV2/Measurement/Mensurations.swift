//
//  Mensurations.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 25/04/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct Mensurations: View {
    
    @EnvironmentObject var userData: UserData
    @State var value : CGFloat = 0
    
    var model: MeasurementInfos
    var body: some View {
        
        NavigationView {
                
        /*HStack {
            
            Spacer()
            
            VStack {
            
            Spacer()
            
            VStack {
                
                Text("Mensurations")
                    .font(.system(size: 35, weight: .bold, design: .default))
                    .foregroundColor(Color.white)
                    .frame(alignment: .center)
                
            }
            
            Spacer()
                .frame(height: 80)*/
                            
            //VStack {
                 
                 //MARK: Armpits Measurement
                 VStack {
                     
                    TextField("Armpits Measurement", text: model.$ArmpitsMeasurement)
                    
                    NavigationLink(destination: About_us(model: model)) {
                        Text("Validax")
                            .foregroundColor(.blue)
                    }
                     /*.background(Color.gray)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .frame(width: UIScreen.main.bounds.width*3/4)*/
                                         
                 }
                 
                 //MARK: Arms Length
                 /*VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                     TextField("Arms Length", text: test.$ArmsLength)
                     .background(Color.gray)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 //MARK: Head Measurement
                 VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                    TextField("Head Measurement", text: test.$HeadMeasurement)
                     .background(Color.gray)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 //MARK: Pelvis Measurement
                 VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                    TextField("Pelvis Measurement", text: test.$PelvisMeasurement)
                     .background(Color.gray)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 //MARK: Pelvis Knee
                 VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                    TextField("PelvisKnee", text: test.$PelvisKnee)
                         .background(Color.gray)
                         .textFieldStyle(RoundedBorderTextFieldStyle())
                         .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 //MARK: Shoulders Measurement
                 VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                    TextField("Shoulders Measurement", text: test.$ShouldersMeasurement)
                         .background(Color.gray)
                         .textFieldStyle(RoundedBorderTextFieldStyle())
                         .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 //MARK: ShouldersPelvis
                 VStack {
                     
                     Spacer()
                         .frame(height: 20)
                     
                    TextField("Shoulders Pelvis", text: test.$ShouldersPelvis)
                     .background(Color.gray)
                     .textFieldStyle(RoundedBorderTextFieldStyle())
                     .frame(width: UIScreen.main.bounds.width*3/4)
                     
                 }
                 
                 }
                //acolade fermante big VStack
                 
                Spacer()
                
                 }
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
            
                //Spacer()
            
                }.edgesIgnoringSafeArea(.all)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .background(Color.black)
                .padding(.vertical, -44)*/
            }
            //.edgesIgnoringSafeArea(.all)
            
        }
            
            //Spacer()
            
    }//.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        //.background(Color.black)
        //.padding(.vertical, -44)


struct Mensurations_Previews: PreviewProvider {
    static var previews: some View {
        Mensurations(model: Measurement[0])
    }
}
