//
//  CarouselViewTesf.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 08/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI

struct CarouselViewTesf: View {
    
    
    var body: some View {
        
        Home(model: Measurement[0])
        
    }
}

//code source du tuto de kavsoft

struct Home : View {
    
    @State var hiddingNavBar = true
    @State var goToSecondView = false
    @State var x : CGFloat = 0
    @State var count : CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    @State var op : CGFloat = 0
    var model: MeasurementInfos
    
    @State var data = [

        Card(id: 0, img: "IMG_0858(1) copy", show: false),
        Card(id: 1, img: "PHOTO DOS", show: false),
        Card(id: 2, img: "IMG_1019 copy", show: false),
        Card(id: 3, img: "IMG_0869(1) copy", show: false),
        Card(id: 4, img: "IMG_0854(2)", show: false),
        Card(id: 5, img: "IMG_1033", show: false)

    ]
    
    var body : some View{
        
        NavigationView{
            
            VStack{
                
                ZStack{
                    HStack {
                        ForEach(data){i in
                               
                               CardView(data: i)
                               .offset(x: self.x)
                               .highPriorityGesture(DragGesture()
                               
                                   .onChanged({ (value) in
                                       
                                       if value.translation.width > 0{
                                           
                                           self.x = value.location.x
                                       }
                                       else{
                                           
                                           self.x = value.location.x - self.screen
                                       }
                                       
                                   })
                                   .onEnded({ (value) in

                                       if value.translation.width > 0{
                                           
                                           
                                           if value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != 0{
                                               
                                               
                                               self.count -= 1
                                               self.updateHeight(value: Int(self.count))
                                               self.x = -((self.screen+37) * self.count)
                                           }
                                           else{
                                               
                                               self.x = -((self.screen+37) * self.count)
                                           }
                                       }
                                       else{
                                           
                                           
                                       if -value.translation.width > ((self.screen - 80) / 2) && Int(self.count) !=  (self.data.count - 1){
                                               
                                           self.count += 1
                                           self.updateHeight(value: Int(self.count))
                                           self.x = -((self.screen+37) * self.count)
                                       }
                                           else{
                                               
                                                   self.x = -((self.screen+37) * self.count)
                                               }
                                           }
                                       })
                                   )
                               }//forEach
                    }.offset(x: self.op)
                    .padding(.leading, 430)
                        
                VStack {
                    Text("La robe")
                        .font(.system(size: 35, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                        .frame(alignment: .center)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Text("85€")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 25, weight: .semibold, design: .default))
                        }
                
                }
                        
                        
                Spacer()
                
                VStack {
                    
                    NavigationLink(destination: Mensurations(model: model)) {
                        Text("Acheter")
                    }
                    
                    Spacer()
                        .frame(height: 30)
                    
                    NavigationLink(destination: About_us()) {
                        Text("About us")
                    }
                    
                }
                
                Spacer()
                
            }//acolade fermante HStack
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .animation(.spring())
            .padding(.top, -44)
            .onAppear {
                
                self.op = ((self.screen + 15) * CGFloat(self.data.count / 2)) - (self.data.count % 2 == 0 ? ((self.screen + 15) / 2) : 0)
                
                //self.data[0].show = true
            }
        }
    }
    
    func updateHeight(value : Int){
        
        
        for i in 0..<data.count{
            
            data[i].show = false
        }
        
        data[value].show = true
    }
}

struct CardView : View {
    
    var data : Card
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 0){
            
            Image(data.img)
            .resizable()
                .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-150)
            
        }.background(Color.white)
    }
}

struct Card : Identifiable {
    
    var id : Int
    var img : String
    var show : Bool
}


