//
//  LocationRecap.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 07/08/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import iPhoneNumberField

@available(iOS 14.0, *)
struct LocationView: View {
    
    @EnvironmentObject var bigModel: BigModel
    @available(iOS 14.0, *)
    @StateObject var mapData = LocationViewModel()
    var db = Firestore.firestore()
    var test: String = ""
    
    var body: some View {
        
        LocationTextField(civilityText: bigModel.user.persons[bigModel.currentPersonIndex].location?.civility ?? "",
                          firstNameText: bigModel.user.persons[bigModel.currentPersonIndex].location?.firstName ?? "",
                          lastNameText: bigModel.user.persons[bigModel.currentPersonIndex].location?.lastName ?? "",
                          emailAdressText: bigModel.user.persons[bigModel.currentPersonIndex].location?.emailAdress ?? "",
                          phoneNumberText: bigModel.user.persons[bigModel.currentPersonIndex].location?.phoneNumber ?? "",
                          adressCountryText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressCountry ?? "",
                          adressPostalCodeText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressPostalCode ?? "",
                          adressCityText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressCity ?? "",
                          adressStreetText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressStreet ?? "",
                          adressMailBoxText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressMailBox ?? "",
                          adressBasementText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressBasement ?? "",
                          adressStageText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressStage ?? "",
                          showPostalCodeCompletion: false,
                          showCountryCompletion: false,
                          showCityCompletion: false,
                          showStreetCompletion: false)
        
    }
}

@available(iOS 14.0, *)
struct LocationTextField: View {
    
    @available(iOS 14.0, *)
    @EnvironmentObject var bigModel: BigModel
    var db = Firestore.firestore()
    var auth = Auth.auth()
    @StateObject var mapData = LocationViewModel()
    @State private var orientation = UIDeviceOrientation.portrait
    
    @State var civilityText: String = ""
    @State var firstNameText: String = ""
    @State var lastNameText: String = ""
    @State var emailAdressText: String = ""
    @State var phoneNumberText: String = ""
    @State var adressCountryText: String = ""
    @State var adressPostalCodeText: String = ""
    @State var adressCityText: String = ""
    @State var adressStreetText: String = ""
    @State var adressMailBoxText: String = ""
    @State var adressBasementText: String = ""
    @State var adressStageText: String = ""
    @State var showPostalCodeCompletion: Bool = false
    @State var showCountryCompletion: Bool = false
    @State var showCityCompletion: Bool = false
    @State var showStreetCompletion: Bool = false
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                
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
                
                VStack {
                    
                    Spacer()
                    
                    Text("Mensurations")
                        .font(.system(size: 35, weight: .bold, design: .default))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("all values in millimeters")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 15, weight: .semibold, design: .default))
                    
                    Spacer()
                    
                }
                
                VStack {
                    
                    Spacer()
                    
                    if #available(iOS 15.0, *) {
                        ScrollView {
                            
                            LazyVStack {
                                
                                VStack {
                                    
                                    TextFieldModel(title: "Civility", text: civilityText)
                                    
                                    TextFieldModel(title: "First name", text: firstNameText)
                                    
                                    TextFieldModel(title: "Last name", text: lastNameText)
                                    
                                    TextFieldModel(title: "Email Adress", text: emailAdressText)
                                    
                                    TextFieldModel(title: "Phone", text: phoneNumberText)
                                    
                                }
                                
                                VStack {
                                    
                                    TextFieldModel(title: "Country", text: adressCountryText)
                                    //&& renvoie la scrollView que si mapData.places et mapData.searchTxt n'est pas vide
                                    // rappel : "places" est un tableau d'objets de type "Place" (placemark avec UUID)
                                    // place est de type "Place"
                                    if showCountryCompletion {
                                        ScrollView {
                                            VStack(spacing: 15) {
                                                ForEach(mapData.places) { place in
                                                    Text(place.placemark.country ?? "")
                                                        .foregroundColor(.black)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .onTapGesture {
                                                            self.adressCountryText = place.placemark.country ?? ""
                                                            if adressCountryText == place.placemark.country ?? "" {
                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                                    showCountryCompletion = false
                                                                }
                                                            }
                                                        }
                                                    Divider()
                                                }
                                            }.frame(height: 100)
                                        }.background(Color.white)
                                    }
                                }.onChange(of: adressCountryText, perform: { value in
                                    
                                    let delay = 0.3
                                    showCountryCompletion = true
                                    print("adressCountryText changed")
                                    
                                    // On se sert de DispatchQueue pour ne pas faire freezer le reste de l'appli
                                    // je ne comprends pas pourquoi mais value a la valeur de mapData.searchTxt donc quand on tape qqch dans le TextField, la recherche se met en route instantanement (utilisation de la fonction self.mapData.searchQuery() )
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                                        if value == adressCountryText {
                                            self.mapData.searchQuery(searchTxt: adressCountryText)
                                        }
                                    }
                                    
                                })
                                
                                VStack {
                                    
                                    TextFieldModel(title: "Postal code", text: adressPostalCodeText)
                                    
                                    //&& renvoie la scrollView que si mapData.places et mapData.searchTxt n'est pas vide
                                    // rappel : "places" est un tableau d'objets de type "Place" (placemark avec UUID)
                                    // place est de type "Place"
                                    if showPostalCodeCompletion {
                                        ScrollView {
                                            VStack(spacing: 15) {
                                                ForEach(mapData.places) { place in
                                                    Text(place.placemark.postalCode ?? "")
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .onTapGesture {
                                                            self.adressPostalCodeText = place.placemark.postalCode ?? ""
                                                            if adressPostalCodeText == place.placemark.postalCode ?? "" {
                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                                    showPostalCodeCompletion = false
                                                                }
                                                            }
                                                        }
                                                    Divider()
                                                }
                                            }.frame(height: 100)
                                        }.background(Color.white)
                                    }
                                }.onChange(of: adressPostalCodeText, perform: { value in
                                    
                                    let delay = 0.3
                                    showPostalCodeCompletion = true
                                    
                                    // On se sert de DispatchQueue pour ne pas faire freezer le reste de l'appli
                                    // je ne comprends pas pourquoi mais value a la valeur de mapData.searchTxt donc quand on tape qqch dans le TextField, la recherche se met en route instantanement (utilisation de la fonction self.mapData.searchQuery() )
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                                        if value == adressPostalCodeText {
                                            self.mapData.searchQuery(searchTxt: adressPostalCodeText)
                                        }
                                    }
                                    
                                })
                                
                                VStack {
                                    
                                    TextFieldModel(title: "City", text: adressCityText)
                                    
                                    //&& renvoie la scrollView que si mapData.places et mapData.searchTxt n'est pas vide
                                    // rappel : "places" est un tableau d'objets de type "Place" (placemark avec UUID)
                                    // place est de type "Place"
                                    if showCityCompletion {
                                        ScrollView {
                                            VStack(spacing: 15) {
                                                ForEach(mapData.places) { place in
                                                    Text(place.placemark.locality ?? "")
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .onTapGesture {
                                                            self.adressCityText = place.placemark.locality ?? ""
                                                            if adressCityText == place.placemark.locality ?? "" {
                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                                    showCityCompletion = false
                                                                }
                                                            }
                                                        }
                                                    Divider()
                                                }
                                            }.frame(height: 100)
                                        }.background(Color.white)
                                    }
                                }.onChange(of: adressCityText, perform: { value in
                                    
                                    let delay = 0.3
                                    showCityCompletion = true
                                    
                                    // On se sert de DispatchQueue pour ne pas faire freezer le reste de l'appli
                                    // je ne comprends pas pourquoi mais value a la valeur de mapData.searchTxt donc quand on tape qqch dans le TextField, la recherche se met en route instantanement (utilisation de la fonction self.mapData.searchQuery() )
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                                        if value == adressCityText {
                                            self.mapData.searchQuery(searchTxt: adressCityText)
                                        }
                                    }
                                    
                                })
                                
                                VStack {
                                    
                                    TextFieldModel(title: "Street", text: adressStreetText)
                                    
                                    //&& renvoie la scrollView que si mapData.places et mapData.searchTxt n'est pas vide
                                    // rappel : "places" est un tableau d'objets de type "Place" (placemark avec UUID)
                                    // place est de type "Place"
                                    if showStreetCompletion {
                                        ScrollView {
                                            VStack(spacing: 15) {
                                                ForEach(mapData.places) { place in
                                                    Text(place.placemark.name ?? "")
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .onTapGesture {
                                                            self.adressStreetText = place.placemark.name ?? ""
                                                            if adressStreetText == place.placemark.name ?? "" {
                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                                    showStreetCompletion = false
                                                                }
                                                            }
                                                        }
                                                    Divider()
                                                }
                                            }.frame(height: 100)
                                        }.background(Color.white)
                                    }
                                }.onChange(of: adressStreetText, perform: { value in
                                    
                                    let delay = 0.3
                                    showStreetCompletion = true
                                    
                                    // On se sert de DispatchQueue pour ne pas faire freezer le reste de l'appli
                                    // je ne comprends pas pourquoi mais value a la valeur de mapData.searchTxt donc quand on tape qqch dans le TextField, la recherche se met en route instantanement (utilisation de la fonction self.mapData.searchQuery() )
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                                        if value == adressStreetText {
                                            self.mapData.searchQuery(searchTxt: adressStreetText)
                                        }
                                    }
                                    
                                })
                                
                                VStack {
                                    
                                    TextFieldModel(title: "Mail box", text: adressMailBoxText)
                                    
                                    Spacer()
                                    
                                    TextFieldModel(title: "Basement", text: adressBasementText)
                                    
                                    Spacer()
                                    
                                    TextFieldModel(title: "Stage", text: adressStageText)
                                    
                                }
                                
                            }
                            
                        }.frame(height: orientation == .portrait || orientation == .portraitUpsideDown ? 400 : 100)
                        .onRotate { newOrientation in orientation = newOrientation }
                        
                    } else {
                        
                    }
                    
                }
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("Save")
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                            .padding(10)
                        Spacer()
                    }.background(Color.blue)
                        .cornerRadius(15)
                        .padding(20)
                        .onTapGesture {
                            
                            db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.currentPersonId).collection("Location").document(bigModel.user.persons[bigModel.currentPersonIndex].location?.id ?? "prout").setData(["civility": civilityText, "firstName": firstNameText, "lastName": lastNameText, "emailAdress": emailAdressText, "phoneNumber": phoneNumberText, "adressPostalCode": adressPostalCodeText, "adressCity": adressCityText, "adressStreet": adressStreetText, "adressMailBox": adressMailBoxText, "adressBasement": adressBasementText, "adressStage": adressStageText, "adressLat": bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLat ?? 0, "adressLong": bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLong ?? 0])
                            bigModel.currentview = .LivraisonViews_RecapLivraison
                            bigModel.lastViews.append(.LivraisonViews_Livraison)
                            
                        }
                }
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            LocationView()
                .environmentObject(BigModel(shouldInjectMockedData: true))
        } else {
            // Fallback on earlier versions
        }
    }
}
