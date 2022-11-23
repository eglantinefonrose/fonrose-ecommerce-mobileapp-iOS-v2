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
    @State var isLocationSelected: Bool = false
    var db = Firestore.firestore()
    var auth = Auth.auth()
    @State var disablePopUp: Bool = false
    @State var isAlertPresented: Bool = false
    @State var adressStreet: String = "No location selected"
    @State var adressPostalCode: String = ""
    @State var adressCity: String = ""
    @State var adressLat: CGFloat = 0
    @State var adressLong: CGFloat = 0
    
    var body: some View {
        
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
                                            self.adressStreet = place.placemark.name ?? ""
                                            self.adressPostalCode = place.placemark.postalCode ?? ""
                                            self.adressLat = CGFloat(place.placemark.location?.coordinate.latitude ?? 0)
                                            self.adressLong = CGFloat(place.placemark.location?.coordinate.longitude ?? 0)
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
                        
                        //bouton permet de centrer la map sur sa loc
                        
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
                                print("currentPersonIndex = \(bigModel.currentPersonIndex)")
                                mapData.pinHome(pointSelectedPlaceLat: CGFloat(CLLocationDegrees(mapData.locationLat ?? 40)), pointSelectedPlaceLong: CGFloat(CLLocationDegrees(mapData.locationLong ?? 40)))
                                self.adressStreet = mapData.placemarkStreet ?? ""
                                self.adressPostalCode = mapData.placemarkPostalCode ?? ""
                                self.adressLat = CGFloat(mapData.locationLat ?? 40)
                                self.adressLong = CGFloat(mapData.locationLong ?? 40)
                                print(mapData.locationLat ?? 40)
                                print(mapData.locationLong ?? 40)
                                print(mapData.placemarkStreet ?? "")
                            }
                    }
                    
                    HStack {
                        
                        Spacer()
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .frame(width: 300, height: 50)

                            if bigModel.currentPersonId != "" {
                                
                                Text("\(adressStreet) \(adressPostalCode)")
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
                                .foregroundColor(adressStreet == "No location selected" ? .black : .white)
                                .font(adressStreet == "No location selected" ? .footnote : .headline)
                        }
                        .onTapGesture {
                            /*self.bigModel.lastViews.append(.LivraisonViews_Livraison)
                            
                            if self.adressStreet != "No location selected" {
                                    
                                db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.currentPersonId).collection("Location").document(bigModel.user.persons[bigModel.currentPersonIndex].location?.id ?? "").setData(["civility": "", "firstName": "", "lastName": "", "emailAdress": bigModel.user.persons[bigModel.currentPersonIndex].email, "phoneNumber": "", "adressPostalCode": "", "adressCity": "", "adressStreet": "", "adressMailBox": "", "adressBasement": "", "adressStage": "", "adressLat": adressLat, "adressLong": adressLong]) { _ in
                                    
                                    db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.currentPersonId).collection("Location").getDocuments { snapshot, error in
                                           guard error == nil else {
                                               print(error!.localizedDescription)
                                               return
                                           }
                                           
                                           if let snapshot = snapshot {
                                               for document in snapshot.documents {
                                                
                                                print("doc snapshot")
                                                
                                                let dbCivility = document.data()["civility"] as? String ?? ""
                                                let dbFirstName = document.data()["firstName"] as? String ?? ""
                                                let dbLastName = document.data()["lastName"] as? String ?? ""
                                                let dbEmailAdress = document.data()["emailAdress"] as? String ?? ""
                                                let dbPhoneNumber = document.data()["phoneNumber"] as? String ?? ""
                                                let dbAdressCountry = document.data()["adressCountry"] as? String ?? ""
                                                let dbAdressPostalCode = document.data()["adressPostalCode"] as? String ?? ""
                                                let dbAdressCity = document.data()["adressCity"] as? String ?? ""
                                                let dbAdressStreet = document.data()["adressStreet"] as? String ?? ""
                                                let dbAdressMailBox = document.data()["adressMailBox"] as? String ?? ""
                                                let dbAdressBasement = document.data()["adressBasement"] as? String ?? ""
                                                let dbAdressStage = document.data()["adressStage"] as? String ?? ""
                                                let dbAdressLat = document.data()["adressLat"] as? CGFloat ?? 44
                                                let dbAdressLong = document.data()["adressLong"] as? CGFloat ?? 44
                                                   
                                                bigModel.user.persons[bigModel.currentPersonIndex].location = BigModel.Location(id: document.documentID, civility: dbCivility, firstName: dbFirstName, lastName: dbLastName, emailAdress: dbEmailAdress, phoneNumber: dbPhoneNumber, adressCountry: dbAdressCountry, adressPostalCode: dbAdressPostalCode, adressCity: dbAdressCity, adressStreet: dbAdressStreet, adressMailBox: dbAdressMailBox, adressBasement: dbAdressBasement, adressStage: dbAdressStage, adressLat: dbAdressLat, adressLong: dbAdressLong)
                                                   
                                                   
                                               }
                                           }
                                           
                                        self.bigModel.currentview = .LivraisonViews_RecapLivraison
                                        isAlertPresented = true
                                           
                                       }
                                    
                                }
                                
                            } else {
                                
                            }
                            
                            print("back")*/
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
            if bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLat ?? 0 != 0 && bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLat ?? 0 != 0 {
                isAlertPresented = true
            } else {
                
            }
            
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
                
                mapData.pinSelectedPlace(pointSelectedPlaceLat: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLat ?? 0, pointSelectedPlaceLong: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLong ?? 0)
                adressStreet = bigModel.user.persons[bigModel.currentPersonIndex].location?.adressStreet ?? ""
                adressPostalCode = bigModel.user.persons[bigModel.currentPersonIndex].location?.adressPostalCode ?? ""
                adressLat = CGFloat(bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLat ?? 0)
                adressLong = CGFloat(bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLong ?? 0)
            
            })
            
        })
        
        .onChange(of: mapData.searchTxt, perform: { value in
            
            let delay = 0.3
            
            // On se sert de DispatchQueue pour ne pas faire freezer le reste de l'appli
            // je ne comprends pas pourquoi mais value a la valeur de mapData.searchTxt donc quand on tape qqch dans le TextField, la recherche se met en route instantanement (utilisation de la fonction self.mapData.searchQuery() )
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value == mapData.searchTxt {
                    self.mapData.searchQuery(searchTxt: mapData.searchTxt)
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
