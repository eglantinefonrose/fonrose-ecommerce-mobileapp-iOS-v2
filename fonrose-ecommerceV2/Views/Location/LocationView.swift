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
    @State var test: String = "k"
    
    var body: some View {
        
        LocationTextField(
            firstNameText: bigModel.user.persons[bigModel.currentPersonIndex].location?.firstName ?? "nil",
            lastNameText: bigModel.user.persons[bigModel.currentPersonIndex].location?.lastName ?? "nil",
            emailAdressText: bigModel.user.persons[bigModel.currentPersonIndex].location?.emailAdress ?? "nil",
            phoneNumberText: bigModel.user.persons[bigModel.currentPersonIndex].location?.phoneNumber ?? "nil",
            adressCountryText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressCountry ?? "nil",
            adressPostalCodeText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressPostalCode ?? "nil",
            adressCityText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressCity ?? "nil",
            adressStreetText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressStreet ?? "nil",
            adressStreet: " \(bigModel.user.persons[bigModel.currentPersonIndex].location?.adressStreet ?? "nil"), \(bigModel.user.persons[bigModel.currentPersonIndex].location?.adressCity ?? "nil"),  \(bigModel.user.persons[bigModel.currentPersonIndex].location?.adressPostalCode ?? "nil"),  \(bigModel.user.persons[bigModel.currentPersonIndex].location?.adressCountry ?? "nil") ",
            adressMailBoxText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressMailBox ?? "nil",
            adressBasementText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressBasement ?? "nil",
            adressStageText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressStage ?? "nil")
        
        //TextField("r", text: $test)
        
        
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
    @Environment(\.colorScheme) var theColorScheme
    
    @State var isAMan = false
    @State var isAWoman = false
    var civilityText: String = ""
    @State var firstNameText: String
    @State var lastNameText: String
    @State var emailAdressText: String
    @State var phoneNumberText: String
    @State var adressCountryText: String
    @State var adressPostalCodeText: String
    @State var adressCityText: String
    @State var adressStreetText: String
    @State var adressStreet: String
    @State var adressMailBoxText: String
    @State var adressBasementText: String
    @State var adressStageText: String
    @State var showStreetCompletion: Bool = false
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                //Spacer()
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                            .frame(width: 10)
                        
                        
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
                                self.bigModel.currentview = .Home_homeFeed0
                            }
                        
                        Spacer()
                            .frame(width: 20)
                        
                    }
                    
                    //Spacer()
                        //.frame(height: 20)
                    
                    
                }
                
                
                ZStack {
                    
                    //&& renvoie la scrollView que si mapData.places et mapData.searchTxt n'est pas vide
                    // rappel : "places" est un tableau d'objets de type "Place" (placemark avec UUID)
                    // place est de type "Place"
                    
                    if showStreetCompletion {
                        VStack {
                            
                            VStack {
                             
                             Spacer()
                             
                             HStack {
                                                                 
                                 Spacer()
                                 
                                 TextField("Street", text: $adressStreet)
                                     .disableAutocorrection(true)
                                     .autocapitalization(.none)
                             }
                             
                             Spacer()

                            }.background(theColorScheme == .dark ? Color.gray : Color.white)
                            .cornerRadius(7)
                            .frame(height: 30)
                            .padding(10)
                            
                            //&& renvoie la scrollView que si mapData.places et mapData.searchTxt n'est pas vide
                            // rappel : "places" est un tableau d'objets de type "Place" (placemark avec UUID)
                            // place est de type "Place"
                            if showStreetCompletion {
                                ScrollView {
                                    VStack(spacing: 15) {
                                        ForEach(mapData.places) { place in
                                            Text("\(place.placemark.name ?? ""), \(place.placemark.locality ?? ""), \(place.placemark.postalCode ?? ""), \(place.placemark.country ?? "")")
                                                //.foregroundColor(.black)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .onTapGesture {
                                                    self.adressStreet = "\(place.placemark.name ?? ""), \(place.placemark.locality ?? ""), \(place.placemark.postalCode ?? ""), \(place.placemark.country ?? "")"
                                                    self.adressStreetText = place.placemark.name ?? ""
                                                    self.adressCityText = place.placemark.locality ?? ""
                                                    self.adressPostalCodeText = place.placemark.postalCode ?? ""
                                                    self.adressCountryText = place.placemark.country ?? ""
                                                    if adressStreet == "\(place.placemark.name ?? ""), \(place.placemark.locality ?? ""), \(place.placemark.postalCode ?? ""), \(place.placemark.country ?? "")" {
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                            showStreetCompletion = false
                                                        }
                                                    }
                                                }
                                            Divider()
                                        }
                                    }.frame(height: 100)
                                }//.background(Color.white)
                            }
                        }.onChange(of: adressStreet, perform: { value in
                            
                            let delay = 0.3
                            showStreetCompletion = true
                            
                            // On se sert de DispatchQueue pour ne pas faire freezer le reste de l'appli
                            // je ne comprends pas pourquoi mais value a la valeur de mapData.searchTxt donc quand on tape qqch dans le TextField, la recherche se met en route instantanement (utilisation de la fonction self.mapData.searchQuery() )
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                                if value == adressStreet {
                                    self.mapData.searchQuery(searchTxt: adressStreet)
                                }
                            }
                            
                        })
                    }
                    
                    
                    if !showStreetCompletion {
                        VStack {
                            
                            VStack {
                                                                                    
                                Text("Location")
                                    .font(.system(size: 35, weight: .bold, design: .default))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                                                                    
                            }
                            
                            //Spacer()
                            
                            VStack {
                                
                                //Spacer()
                                
                                if #available(iOS 15.0, *) {
                                    ScrollView {
                                        
                                        LazyVStack {
                                            
                                            VStack {
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                HStack {
                                                    
                                                    Image(systemName: isAMan ? "circle.circle.fill" : "circle")
                                                        .foregroundColor(.blue)
                                                        .onTapGesture {
                                                            isAMan = true
                                                            isAWoman = false
                                                        }
                                                    
                                                    Text("Mr")
                                                        //.foregroundColor(.black)
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: isAWoman ? "circle.circle.fill" : "circle")
                                                        .foregroundColor(.blue)
                                                        .onTapGesture {
                                                            isAMan = false
                                                            isAWoman = true
                                                        }
                                                    
                                                    Text("Mme")
                                                        //.foregroundColor(.black)
                                                    
                                                }
                                                 
                                                 Spacer()

                                                }.padding(10)
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     TextField("First name", text: $firstNameText)
                                                         .disableAutocorrection(true)
                                                         .autocapitalization(.none)
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     TextField("Last name", text: $lastNameText)
                                                         .disableAutocorrection(true)
                                                         .autocapitalization(.none)
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     TextField("Email adress", text: $emailAdressText)
                                                         .disableAutocorrection(true)
                                                         .autocapitalization(.none)
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     TextField("Phone", text: $phoneNumberText)
                                                         .disableAutocorrection(true)
                                                         .autocapitalization(.none)
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
                                            }
                                            
                                            /*VStack {
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     TextField("Country", text: $adressCountryText)
                                                         .disableAutocorrection(true)
                                                         .autocapitalization(.none)
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
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
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     TextField("Postal code", text: $adressPostalCodeText)
                                                         .disableAutocorrection(true)
                                                         .autocapitalization(.none)
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
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
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     TextField("City", text: $adressCityText)
                                                         .disableAutocorrection(true)
                                                         .autocapitalization(.none)
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
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
                                                
                                            })*/
                                            
                                            VStack {
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     TextField("Street", text: $adressStreet)
                                                         .disableAutocorrection(true)
                                                         .autocapitalization(.none)
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
                                                //&& renvoie la scrollView que si mapData.places et mapData.searchTxt n'est pas vide
                                                // rappel : "places" est un tableau d'objets de type "Place" (placemark avec UUID)
                                                // place est de type "Place"
                                                /*if showStreetCompletion {
                                                    ScrollView {
                                                        VStack(spacing: 15) {
                                                            ForEach(mapData.places) { place in
                                                                Text("\(place.placemark.name ?? ""), \(place.placemark.locality ?? ""), \(place.placemark.postalCode ?? ""), \(place.placemark.country ?? "")")
                                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                                    .onTapGesture {
                                                                        self.adressStreet = "\(place.placemark.name ?? ""), \(place.placemark.locality ?? ""), \(place.placemark.postalCode ?? ""), \(place.placemark.country ?? "")"
                                                                        if adressStreet == "\(place.placemark.name ?? ""), \(place.placemark.locality ?? ""), \(place.placemark.postalCode ?? ""), \(place.placemark.country ?? "")" {
                                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                                                showStreetCompletion = false
                                                                            }
                                                                        }
                                                                    }
                                                                Divider()
                                                            }
                                                        }.frame(height: 100)
                                                    }.background(Color.white)
                                                }*/
                                            }.onChange(of: adressStreet, perform: { value in
                                                
                                                let delay = 0.3
                                                showStreetCompletion = true
                                                
                                                // On se sert de DispatchQueue pour ne pas faire freezer le reste de l'appli
                                                // je ne comprends pas pourquoi mais value a la valeur de mapData.searchTxt donc quand on tape qqch dans le TextField, la recherche se met en route instantanement (utilisation de la fonction self.mapData.searchQuery() )
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                                                    if value == adressStreet {
                                                        self.mapData.searchQuery(searchTxt: adressStreet)
                                                    }
                                                }
                                                
                                            })
                                            
                                            VStack {
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     TextField("Mail box", text: $adressMailBoxText)
                                                         .disableAutocorrection(true)
                                                         .autocapitalization(.none)
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
                                                Spacer()
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     TextField("Basement", text: $adressBasementText)
                                                         .disableAutocorrection(true)
                                                         .autocapitalization(.none)
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
                                                Spacer()
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     TextField("Stage", text: $adressStageText)
                                                         .disableAutocorrection(true)
                                                         .autocapitalization(.none)
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
                                            }
                                            
                                        }
                                        
                                    }//.frame(height: orientation == .portrait || orientation == .portraitUpsideDown ? 400 : 100)
                                    .frame(maxHeight: .infinity)
                                    .onRotate { newOrientation in orientation = newOrientation }
                                    
                                } else {
                                    
                                }
                                
                            }
                            
                            VStack {
                                
                                //Spacer()
                                
                                //Text("Swipe down to see the full list of requested informations")
                                    //.multilineTextAlignment(.center)
                                
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
                                        
                                        db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.currentPersonId).collection("Location").document(bigModel.user.persons[bigModel.currentPersonIndex].location?.id ?? "prout").setData(["civility": civilityText, "firstName": firstNameText, "lastName": lastNameText, "emailAdress": emailAdressText, "phoneNumber": phoneNumberText, "adressCountry": adressCountryText,"adressPostalCode": adressPostalCodeText, "adressCity": adressCityText, "adressStreet": adressStreetText, "adressMailBox": adressMailBoxText, "adressBasement": adressBasementText, "adressStage": adressStageText, "adressLat": bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLat ?? 0, "adressLong": bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLong ?? 0])
                                        bigModel.currentview = .LivraisonViews_RecapLivraison
                                        bigModel.fetchLocation()
                                        bigModel.lastViews.append(.LivraisonViews_Livraison)
                                        
                                    }
                            }
                            
                        }
                    }
                }
                
            }
            
        }
    }
}

@available(iOS 14.0, *)
struct Detail: View {
    
    @State var category: String
    @State var requestedInfo: String
    @State var showCompletion: Bool
    @StateObject var mapData = LocationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(mapData.places) { place in
                    Text(place.placemark.postalCode ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture {
                            requestedInfo = category
                            if requestedInfo == category {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    showCompletion = false
                                }
                            }
                        }
                    Divider()
                }
            }.frame(height: 100)
        }.background(Color.white)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            LocationView()
                .environmentObject(BigModel())
        } else {
            // Fallback on earlier versions
        }
    }
}
