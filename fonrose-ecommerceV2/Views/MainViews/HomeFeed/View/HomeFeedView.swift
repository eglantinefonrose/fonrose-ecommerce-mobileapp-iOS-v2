//
//  homeFeed.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 20/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth

@available(iOS 14.0, *)
struct HomeFeedView: View {
   
    @State var offset: CGFloat = -UIScreen.main.bounds.width/4
    @EnvironmentObject var bigModel: BigModel

    @available(iOS 14.0, *)
    var body: some View {
        
            ScrollViewReader { proxy in
                ZStack {
                    HStack(spacing: 0) {
                                        
                        HStack {
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
                                            .onTapGesture {
                                                proxy.scrollTo(0)
                                                self.bigModel.showMenu = false
                                            }
                                        
                                        Text("The dress")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .onTapGesture {
                                                proxy.scrollTo(1)
                                                self.bigModel.showMenu = false
                                            }
                                        
                                        Text("About us")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .onTapGesture {
                                                proxy.scrollTo(2)
                                                self.bigModel.showMenu = false
                                            }
                                    }
                                    
                                    Text("Customer service")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .onTapGesture {
                                            proxy.scrollTo(3)
                                            self.bigModel.showMenu = false
                                        }
                                    
                                    Text("Measurement")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .onTapGesture {
                                            if !bigModel.signedIn {
                                                bigModel.currentview = ViewEnum.Auth_SignInView
                                            } else {
                                                bigModel.currentview = ViewEnum.Measurement_Mensurations
                                            }
                                            bigModel.lastViews.append(.Home_homeFeed)
                                        }
                                    
                                    Text("Location")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .onTapGesture {
                                            bigModel.currentview = ViewEnum.FinalizeOrderViews_Livraison
                                            bigModel.lastViews.append(.Home_homeFeed)
                                        }
                                    
                                    Spacer()
                                    
                                }
                            }
                            
                        }
                        
                        ZStack {
                            
                            List {
                                ForEach(dressPictures) { picture in
                                    PostStack(picture: picture)
                                        .id(picture.id)
                                        .onTapGesture {
                                        }
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
                                                bigModel.showMenu.toggle()
                                                if bigModel.showMenu {
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
                    .onChange(of: bigModel.showMenu, perform: { value in
                        //le menu n'est pas affiché
                        if bigModel.showMenu == false {
                            offset = -UIScreen.main.bounds.width/4
                        }
                        //le menu est affiché
                        if bigModel.showMenu {
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
                                bigModel.lastViews.append(.Home_homeFeed)
                                self.bigModel.currentview = .Auth_SignInView
                                withAnimation {
                                    bigModel.showMenu.toggle()
                                    if bigModel.showMenu {
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
        }
        
    }
            
}


#if DEBUG
struct homeFeed_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            HomeFeedView()
                .environmentObject(BigModel())
        } else {
            // Fallback on earlier versions
        }
    }
        
}
#endif


