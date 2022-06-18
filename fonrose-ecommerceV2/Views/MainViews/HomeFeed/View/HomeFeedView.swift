//
//  homeFeed.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 20/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct HomeFeedView: View {
   
    @State var showMenu: Bool = false
    @State var offset: CGFloat = -UIScreen.main.bounds.width/4
    @EnvironmentObject var bigModel: BigModel
    var model: MeasurementInfos

    @available(iOS 14.0, *)
    var body: some View {
        
        if #available(iOS 14.0, *) {
            ZStack {
                HStack(spacing: 0) {
                                    
                    HStack {
                        SideMenu()
                        
                    }
                    
                    ZStack {
                        
                        List {
                            ForEach(dressPictures) { picture in
                                PostView(picture: picture)
                            } .buttonStyle(PlainButtonStyle())
                            .frame(width: UIScreen.main.bounds.width)
                            .edgesIgnoringSafeArea(.all)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }.onAppear(perform: {
                            UITableView.appearance().contentInset.top = -47
                        })
                        
                        VStack {
                            HStack {
                                
                                Spacer()
                                    .frame(width: 20)
                                
                                Image(systemName: "text.justify")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                                    .onTapGesture {
                                        withAnimation {
                                            showMenu.toggle()
                                            if showMenu {
                                                print("menu")
                                            } else {
                                                print("no menu")
                                            }
                                        }
                                    }
                                
                                
                                Spacer()
                            }
                            Spacer()
                        }
                        
                    }
                }.frame(width: UIScreen.main.bounds.width/2 + UIScreen.main.bounds.width)
                .animation(.easeOut, value: offset == -UIScreen.main.bounds.width/4)
                .offset(x: offset)
                .onChange(of: showMenu, perform: { value in
                    //le menu n'est pas affiché
                    if showMenu == false {
                        offset = -UIScreen.main.bounds.width/4
                    }
                    //le menu est affiché
                    if showMenu {
                        offset = UIScreen.main.bounds.width/4
                    }
            })
                
            VStack {
                HStack {
                    
                    Spacer()
                    
                    Image(systemName: "person.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation {
                                showMenu.toggle()
                                if showMenu {
                                    print("menu")
                                } else {
                                    print("no menu")
                                }
                            }
                        }
                    
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width/4 + 20)
                    
                }
                Spacer()
            }
                
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
            
}

struct SideMenu: View {
        
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(Color.primary.opacity(0.4))
                .edgesIgnoringSafeArea(.all)
            .frame(width: UIScreen.main.bounds.width/2)
            
            VStack(alignment: .leading, spacing: 20) {
                
                Spacer()
                    .frame(height: 0)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Watch the clip")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Text("The dress")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Text("About us")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                
                Text("Customer service")
                    .foregroundColor(.white)
                    .font(.headline)
                
                Text("Measurement")
                    .foregroundColor(.white)
                    .font(.headline)
                
                Text("Location")
                    .foregroundColor(.white)
                    .font(.headline)
                
                Spacer()
                
            }
        }
        
    }
    
}

#if DEBUG
struct homeFeed_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            HomeFeedView(model: Measurement[0])
                .environmentObject(UserData())
        } else {
            // Fallback on earlier versions
        }
    }
        
}
#endif


