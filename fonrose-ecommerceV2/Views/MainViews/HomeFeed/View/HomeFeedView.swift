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
    @State var productImages: [Image] = []
    @State var images: [Image] = []
    @State var mainArrayInfos: [BigModel.MainViewArrayElements] = []
    @State var productMainArrayInfos: [BigModel.DressPictures] = []

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
                                
                                List {
                                    ForEach(productMainArrayInfos.indices, id: \.self) { index in
                                        PostStack(image: productImages[index], cellText: productMainArrayInfos[index].productName)
                                            .id(productMainArrayInfos[index].id)
                                            .onTapGesture {
                                                
                                                bigModel.selectedProductId = productMainArrayInfos[index].id
                                                bigModel.fetchAllMeasurementInfo()
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
                                    
                                    ForEach(mainArrayInfos.indices, id: \.self) { index in
                                        PostStack(image: images[index], cellText: mainArrayInfos[index].text)
                                            .buttonStyle(PlainButtonStyle())
                                            .navigationBarTitle("")
                                            .navigationBarHidden(true)
                                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    }
                                    
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
                            do {
                                
                                mainArrayInfos = try await bigModel.fetchMainViewArrayInfos()
                                for i in try await 0..<bigModel.fetchMainViewArrayInfos().count {
                                    let image = try await bigModel.fetchImage(url: bigModel.fetchMainViewArrayInfos()[i].imageName)
                                    images.append(image)
                                }
                                
                            } catch {
                                print("Error fetching image: \(error.localizedDescription)")
                            }
                            
                            do {
                                
                                productMainArrayInfos = try await bigModel.fetchProductInfo()
                                for i in try await 0..<bigModel.fetchProductInfo().count {
                                    let image = try await bigModel.fetchImage(url: bigModel.fetchProductInfo()[i].pictureName)
                                    productImages.append(image)
                                }
                                
                            } catch {
                                print("Error fetching image: \(error.localizedDescription)")
                            }
                            
                            
                            DispatchQueue.main.async {
                                withAnimation {
                                    bigModel.isItFirstTime = false
                                }
                            }
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.opacity = 1.0
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

