//
//  LocationHome.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 27/03/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import CoreLocation
import FirebaseAuth
import FirebaseFirestore

@available(iOS 14.0, *)
struct LocationHome: View {
    
    @available(iOS 14.0, *)
    @EnvironmentObject var bigModel: BigModel
    @StateObject var mapData = LocationViewModel()
    @State var locationManager = CLLocationManager()
    @State var currentLocation: CLPlacemark?
    @State var isHomeSelected: Bool = false
    @State var isLocationSelected: Bool = false
    var db = Firestore.firestore()
    @State var disablePopUp: Bool = false
    @State var isAlertPresented: Bool = false
    @State var previousLocationKept = false
    @State var adressName: String = "No location selected"
    
    var body: some View {
        
        let homeCoordinateLat = mapData.locationLat ?? 40
        let homeCoordinateLong = mapData.locationLong ?? 40
        let homeCoordinateName = mapData.placemarkName ?? ""
        
        ZStack {
            
            LocationMapView()
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                
                VStack {
                    VStack {
                        
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
                            
                        }
                        
                        HStack {
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search your delivery location", text: $mapData.searchTxt)
                            
                        }.padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(20)
                        .frame(width: UIScreen.main.bounds.width-20, height: 50)
                        
                    }
                    
                    //&& renvoie la scrollView que si mapData.places et mapData.searchTxt n'est pas vide
                    // rappel : "places" est un tableau d'objets de type "Place" (placemark avec UUID)
                    // place est de type "Place"
                    if !mapData.places.isEmpty && mapData.searchTxt != "" {
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(mapData.places) { place in
                                    Text(place.placemark.name ?? "")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .onTapGesture {
                                            
                                            mapData
                                                .selectPlace(place: place)
                                            //bigModel.selectedPlacemark = place.placemark
                                            self.adressName = "\(place.placemark.name ?? ""), \(place.placemark.postalCode ?? "")"
                                            isHomeSelected = false
                
                                        }
                                    Divider()
                                }
                            }
                        }.background(Color.white)
                    }
                
                }.padding()
                
                Spacer()
                
                VStack {
                    
                    Button {
                        
                        mapData.pinSelectedPlace(pointSelectedPlaceLat: CGFloat(Int(CGFloat(CLLocationDegrees(25.276987)))), pointSelectedPlaceLong: CGFloat(Int(CGFloat(CLLocationDegrees(55.296249)))))
                        
                    } label: {
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    }
                    
                    Button(action: mapData.updateMapType, label: {
                        Image(systemName: mapData.mapType == .standard ? "network" : "map")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    
                }.frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                
                VStack {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.blue)
                            .frame(width: UIScreen.main.bounds.width-20, height: 50)
                        Text("Select your current location")
                            .foregroundColor(.white)
                            .font(.headline)
                            .onTapGesture {
                                isHomeSelected = true
                                self.adressName = homeCoordinateName
                                mapData.pinHome(pointSelectedPlaceLat: CGFloat(CLLocationDegrees(homeCoordinateLat)), pointSelectedPlaceLong: CGFloat(CLLocationDegrees(homeCoordinateLong)))
                                print(homeCoordinateLat)
                                print(homeCoordinateLong)
                                print(homeCoordinateName)
                            }
                    }
                    
                    HStack {
                        
                        Spacer()
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .frame(width: 300, height: 50)

                            if bigModel.isPersonChosen {
                                
                                /*if !isHomeSelected {
                                    Text("\(bigModel.selectedPlacemark?.name ?? (bigModel.user.persons[bigModel.currentPersonIndex].location?.adressName != "" && previousLocationKept ? bigModel.user.persons[bigModel.currentPersonIndex].location?.adressName ?? "" : "No location selected"))")
                                        .foregroundColor(.black)
                                        .font(.callout)
                                } else {
                                    Text(homeCoordinateName)
                                        .foregroundColor(.black)
                                        .font(.callout)
                                }*/
                                
                                Text(adressName)
                                    .foregroundColor(.black)
                                    .font(.callout)
                                
                            }
                                
                        }
                        
                        Spacer()
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.gray)
                                .frame(width: 65, height: 50)
                            Image(systemName: "checkmark")
                                .foregroundColor(adressName == "No location selected" ? .black : .white)
                                .font(adressName == "No location selected" ? .footnote : .headline)
                        }
                        .onTapGesture {
                            self.bigModel.currentview = .FinalizeOrderViews_PaymentScreen
                            self.bigModel.lastViews.append(.FinalizeOrderViews_Livraison)
                            isAlertPresented = true
                            isHomeSelected = false
                            
                            if bigModel.selectedPlacemark != nil {
                                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.currentPersonIndex+1)").collection("Location").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(bigModel.currentPersonIndex+1)-Location").setData(["adressName": bigModel.selectedPlacemark?.name ?? "", "adressLat": bigModel.selectedPlacemark?.location?.coordinate.latitude ?? 0, "adressLong": bigModel.selectedPlacemark?.location?.coordinate.longitude ?? 0])
                            } else {
                                
                            }
                            
                            if previousLocationKept {
                                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.currentPersonIndex+1)").collection("Location").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(bigModel.currentPersonIndex+1)-Location").setData(["adressName": bigModel.user.persons[bigModel.currentPersonIndex].location?.adressName ?? "", "adressLat": bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLat ?? 0, "adressLong": bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLong ?? 0])
                            }
                            
                            print("back")
                        }
                        
                        Spacer()
                        
                    }
                    
                }
                
            }
            
        Spacer()
            .frame(height: 40)
            
        }
        .onAppear(perform: {
                        
            locationManager.delegate = mapData
            //le delegate est le LocationViewModel
            locationManager.requestWhenInUseAuthorization()
            isAlertPresented = true
            
        })
        //if permission is denied
        .alert(isPresented: $mapData.permissionDenied, content: {
            Alert(title: Text("Permission Denied"), message: Text("Please enable permission in App settings"), dismissButton: .default(Text("Goto Settings"),action: {
                //Redirecting user to settings
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
        .alert(isPresented: $isAlertPresented, content: {
            
            Alert(title: Text("Previous location data"), message: Text("Do you want to keep your saved location ?"), primaryButton: .default(Text("Change")) {
            
            }, secondaryButton: .default(Text("Keep").font(.system(.caption))) {
                
                mapData.pinSelectedPlace(pointSelectedPlaceLat: !bigModel.isPersonChosen ? 0 : bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLat ?? 0, pointSelectedPlaceLong: !bigModel.isPersonChosen ? 0 : bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLong ?? 0)
                self.previousLocationKept = true
                adressName = bigModel.user.persons[bigModel.currentPersonIndex].location?.adressName ?? ""
            
            })
            
        })
        
        .onChange(of: mapData.searchTxt, perform: { value in
            
            let delay = 0.3
            
            // On se sert de DispatchQueue pour ne pas faire freezer le reste de l'appli
            // je ne comprends pas pourquoi mais value a la valeur de mapData.searchTxt donc quand on tape qqch dans le TextField, la recherche se met en route instantanement (utilisation de la fonction self.mapData.searchQuery() )
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value == mapData.searchTxt {
                    self.mapData.searchQuery()
                }
            }
            
            
            
        })
    }
}

@available(iOS 14.0, *)
struct LocationHome_Previews: PreviewProvider {
    @available(iOS 14.0, *)
    static var previews: some View {
        LocationHome()
            .environmentObject(BigModel())
    }
}
