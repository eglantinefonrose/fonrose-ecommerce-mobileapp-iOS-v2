//
//  homeFeed.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 20/10/2019.
//  Copyright © 2019 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import MapKit
import WebKit

@available(iOS 14.0, *)
struct HomeFeedView: View {
   
    @State var offset: CGFloat = -UIScreen.main.bounds.width/4
    @EnvironmentObject var bigModel: BigModel
    @StateObject var mapData = LocationViewModel()
    @State private var isActive = false
    @State private var opacity = 1.0
    var db = Firestore.firestore()

    @available(iOS 14.0, *)
    var body: some View {
        
        if isActive {
            ScrollViewReader { proxy in
                ZStack {
                    HStack(spacing: 0) {
                        
                        HStack {
                            
                            BurgerMenu(proxy: proxy)
                                .environmentObject(bigModel)
                            
                        }
                        
                        ZStack {
                            
                            List {
                                ForEach(dressPictures) { picture in
                                    PostStack(picture: picture)
                                        .id(picture.id)
                                        .onTapGesture {
                                            
                                            self.bigModel.currentview = picture.navigationViewName
                                            self.bigModel.lastViews.append(picture.viewName)
                                            print(picture.viewName)
                                            print("append")
                                            
                                            if !bigModel.showMenu {
                                            } else {
                                                bigModel.showMenu.toggle()
                                            }
                                        }
                                    
                                } .buttonStyle(PlainButtonStyle())
                                    .navigationBarTitle("")
                                    .navigationBarHidden(true)
                                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            }.listStyle(PlainListStyle())
                            
                            if bigModel.showMenu {
                                VStack {
                                    
                                    HStack {
                                        
                                        Image(systemName: "text.justify")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .padding(20)
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
                                        
                                    }.frame(width: UIScreen.main.bounds.width)
                                    Spacer()
                                }.padding(10)
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
                            
                            Image(systemName: "text.justify")
                                .opacity(bigModel.showMenu ? 0 : 1)
                                .font(.system(size: 20))
                                .padding(20)
                                .onTapGesture {
                                    bigModel.showMenu.toggle()
                                    if bigModel.showMenu {
                                        print("menu")
                                    } else {
                                        print("no menu")
                                    }
                                }
                            
                            Spacer()
                            
                            if bigModel.user.id != "" {
                                if bigModel.user.persons[bigModel.currentPersonIndex].id != "" {
                                    
                                    Text(bigModel.user.persons[bigModel.currentPersonIndex].name)
                                        .opacity(bigModel.showMenu ? 0 : 1)
                                        .foregroundColor(.white)
                                        .font(.system(size: 17, weight: .bold, design: .default))
                                    
                                }
                            }
                            
                            Spacer()
                            
                            Image(systemName: "person.circle")
                                .padding(20)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .onTapGesture {
                                    bigModel.lastViews.append(.Home_homeFeed0)
                                    self.bigModel.currentview = .Auth_AuthView
                                    print(bigModel.user.id)
                                    print(bigModel.user.email)
                                    //.standard ? "network" : "map"
                                    withAnimation {
                                        if bigModel.showMenu {
                                            print("menu")
                                        } else {
                                            print("no menu")
                                        }
                                    }
                                    
                                }
                            
                        }.frame(width: UIScreen.main.bounds.width)
                        Spacer()
                    }.padding(10)
                }
            } .environment(\.colorScheme, .dark)
        } else {
            VStack {
                VStack {
                    GifImage(name: "simpson")
                        .frame(height: 300)
                    Text("ecommerce")
                        .font(.title)
                }
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.opacity = 1.0
                    }
                }
                
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
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

struct GifImage: UIViewRepresentable {
    private let name : String
    
    init(name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: "simpson", withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        
        webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent()
        )
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
    
    typealias UIViewType = WKWebView
}

