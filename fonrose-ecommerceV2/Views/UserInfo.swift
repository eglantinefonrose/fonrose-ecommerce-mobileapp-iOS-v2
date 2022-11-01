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
            
            Color("Background")
            
            VStack {
                                    
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    
                    Text("Back")
                        .foregroundColor(Color.blue)
                        .fontWeight(.semibold)
                        .onTapGesture {
                            if !self.bigModel.authLastViews.isEmpty {
                                print("back")
                                self.bigModel.authCurrentView = self.bigModel.authLastViews.last ?? .AboutUsScreen
                                self.bigModel.authLastViews.removeLast()
                                print("previous View = \(String(describing: self.bigModel.authLastViews.last))")
                            } else { print("array empty") }
                        }
                    
                    Spacer()
                    
                    Text("User Info")
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "house")
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            self.bigModel.currentview = .Home_homeFeed
                        }
                    
                }.padding(20)
                
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        
                        Spacer()
                        
                        Text("your email is \(auth.currentUser?.email ?? "nil")")
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Text("Sign out")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                bigModel.signOut()
                                print("\(bigModel.$authCurrentView)")
                            }
                        
                        Spacer()
                        
                        if bigModel.signedIn {
                            Text("the current person is \(bigModel.user.persons[bigModel.currentPersonIndex].name)")
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Text("change person")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                bigModel.authCurrentView = .Auth_PersonPickerView
                                print("change person")
                            }
                        
                        Spacer()
                            .frame(height: 50)
                        
                    }
                    
                    Spacer()
                    
                }
                .edgesIgnoringSafeArea(.all)
            }
                
        }
    }
}

struct UserInfo_Previews: PreviewProvider {
    static var previews: some View {
        UserInfo()
            .environmentObject(BigModel())
    }
}
