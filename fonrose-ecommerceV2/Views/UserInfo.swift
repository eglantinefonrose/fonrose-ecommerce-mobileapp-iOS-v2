//
//  UserInfo.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 22/06/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct UserInfo: View {
    
    var auth = Auth.auth()
    @EnvironmentObject var bigModel: BigModel
    
    var body: some View {
        
        ZStack {
            
            HStack {
                
                Spacer()
                
                VStack {
                    
                    Spacer()
                    
                    Text("your email is \(auth.currentUser?.email ?? "nil")")
                        .foregroundColor(.white)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("Sign out")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            bigModel.signOut()
                        }
                    
                    Spacer()
                    
                    Text("the current person is \(bigModel.persons[bigModel.currentPersonIndex].name)")
                        .foregroundColor(.white)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("change person")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            bigModel.currentview = .Auth_PersonPickerView
                        }
                    
                    Spacer()
                        .frame(height: 50)
                    
                }
                
                Spacer()
                
            }.background(Color.black)
            .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        
                        Spacer()
                            .frame(width: 20)
                        
                        
                        Text("Back")
                            .foregroundColor(Color.blue)
                            .fontWeight(.semibold)
                            .onTapGesture {
                                if !self.bigModel.lastViews.isEmpty {
                                    print("back")
                                    self.bigModel.currentview = self.bigModel.lastViews.last ?? .AboutUsScreen
                                    self.bigModel.lastViews.removeLast()
                                    print("previous View = \(String(describing: self.bigModel.lastViews.last))")
                                } else { print("array empty") }
                            }
                        
                        Spacer()
                        
                        Image(systemName: "house")
                            .foregroundColor(Color.blue)
                            .onTapGesture {
                                self.bigModel.currentview = .Home_homeFeed
                            }
                        
                        Spacer()
                            .frame(width: 20)
                        
                    }.frame(width: UIScreen.main.bounds.width)
                    
                    Spacer()
                    
                }
                
                Spacer()
                
        }
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        UserInfo()
            .environmentObject(BigModel())
    }
}
