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
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var offset: CGFloat = -UIScreen.main.bounds.width/4
    @EnvironmentObject var bigModel: BigModel
    @StateObject var mapData = LocationViewModel()
    @State private var opacity = 1.0
    var db = Firestore.firestore()
    

    @available(iOS 14.0, *)
    var body: some View {
        
        VStack {
            if !bigModel.isItFirstTime {
                ScrollViewReader { proxy in
                    ZStack {
                        HStack(spacing: 0) {
                            
                            HStack {
                                
                                BurgerMenu(proxy: proxy)
                                    .environmentObject(bigModel)
                                
                            }
                            
                            ZStack {
                                
                                /*List {
                                    
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color.blue)
                                            .frame(height: UIScreen.main.bounds.height)
                                        Text("0")
                                    }.id(0)
                                    
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color.red)
                                            .frame(height: UIScreen.main.bounds.height)
                                        Text("1")
                                    }.id(1)
                                    
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color.gray)
                                            .frame(height: UIScreen.main.bounds.height)
                                        Text("2")
                                    }.id(2)
                                    
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color.yellow)
                                            .frame(height: UIScreen.main.bounds.height)
                                        Text("3")
                                    }.id(3)
                                    
                                }*/
                                
                                List {
                                    
                                    ForEach(bigModel.productMainArrayInfos.indices, id: \.self) { index in
                                        PostStack(image: bigModel.productImages[index], cellText: bigModel.productMainArrayInfos[index].productName)
                                            .id(bigModel.productMainArrayInfos[index].id)
                                            .onTapGesture {
                                                
                                                bigModel.selectedProductId = bigModel.productMainArrayInfos[index].id
                                                self.bigModel.currentview = .VideoPlayer_trailerPlayer
                                                self.bigModel.lastViews.append(.Home_homeFeed0)
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
                                    
                                    ForEach(bigModel.mainArrayInfos.indices, id: \.self) { index in
                                        PostStack(image: bigModel.images[index], cellText: bigModel.mainArrayInfos[index].text)
                                            .id(bigModel.mainArrayInfos[index].id + 2)
                                            .buttonStyle(PlainButtonStyle())
                                            .navigationBarTitle("")
                                            .navigationBarHidden(true)
                                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                            .onTapGesture {
                                                bigModel.currentview = bigModel.mainArrayInfos[index].nextScreen
                                            }
                                    }
                                    .buttonStyle(PlainButtonStyle())
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
                                    if bigModel.user.persons[bigModel.currentPersonIndex ?? 0].id != "" {
                                        
                                        Text(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].name)
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
                }.environment(\.colorScheme, .dark)
            } else {
                VStack {
                    if #available(iOS 15.0, *) {
                        VStack {
                            //GifImage(name: "simpson")
                                //.frame(height: 300)
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color.blue)
                                Text("ecommerce")
                                    .font(.title)
                            }
                        }
                        .opacity(opacity)
                        .task {
                                                            
                                bigModel.fetchAllMeasurementInfo()
                            
                                do {
                                    bigModel.dressPictures = try await bigModel.fetchProductInfo()
                                }
                                catch {
                                    print("Error fetching image: \(error.localizedDescription)")
                                }
                                
                                do {
                                    try await bigModel.fetchArrayOfImages()
                                } catch {
                                    print("Error fetching image: \(error.localizedDescription)")
                                }
                                
                            /*do {
                                    
                                    bigModel.productMainArrayInfos = try await bigModel.fetchProductInfo()
                                    for i in try await 0..<bigModel.fetchProductInfo().count {
                                        let image = try await bigModel.fetchImage(url: bigModel.fetchProductInfo()[i].pictureName)
                                        
                                        DispatchQueue.main.async {
                                            bigModel.productImages.append(image)
                                        }
                                        
                                        
                                    }
                                    
                                } catch {
                                    print("Error fetching image: \(error.localizedDescription)")
                                }*/
                                
                                
                            DispatchQueue.main.async {

                                    //withAnimation {
                                        bigModel.isItFirstTime = false
                                    //}
                                //withAnimation(.easeIn(duration: 1.2)) {
                                    //self.opacity = 1.0
                                //}
                            }
                            
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
        
    }
            
}


#if DEBUG
/*struct homeFeed_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            HomeFeedView()
                .environmentObject(BigModel())
        } else {
            // Fallback on earlier versions
        }
    }
        
}*/
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

