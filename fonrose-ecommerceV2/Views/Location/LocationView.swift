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
        
        if bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressStreet ?? "nil" == "" &&
            bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressCity ?? "nil" == "" &&
            bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressPostalCode ?? "nil" == ""
            && bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressCountry ?? "nil" == "" {
            
            LocationTextField(
                civilityText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.civility ?? "nil",
                firstNameText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.firstName ?? "nil",
                lastNameText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.lastName ?? "nil",
                emailAdressText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.emailAdress ?? "nil",
                phoneNumberText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.phoneNumber ?? "nil",
                adressCountryText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressCountry ?? "nil",
                adressPostalCodeText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressPostalCode ?? "nil",
                adressCityText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressCity ?? "nil",
                adressStreetText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressStreet ?? "nil",
                adressStreet: "",
                adressMailBoxText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressMailBox ?? "nil",
                adressBasementText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressBasement ?? "nil",
                adressStageText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressStage ?? "nil")
            
        } else {
            LocationTextField(
                civilityText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.civility ?? "nil",
                firstNameText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.firstName ?? "nil",
                lastNameText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.lastName ?? "nil",
                emailAdressText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.emailAdress ?? "nil",
                phoneNumberText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.phoneNumber ?? "nil",
                adressCountryText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressCountry ?? "nil",
                adressPostalCodeText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressPostalCode ?? "nil",
                adressCityText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressCity ?? "nil",
                adressStreetText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressStreet ?? "nil",
                adressStreet: " \(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressStreet ?? "nil"), \(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressCity ?? "nil"),  \(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressPostalCode ?? "nil"),  \(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressCountry ?? "nil") ",
                adressMailBoxText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressMailBox ?? "nil",
                adressBasementText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressBasement ?? "nil",
                adressStageText: bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.adressStage ?? "nil")
        }
        
        
        
        /*LocationTextField(
            civilityText: "woman",
            firstNameText: "nil",
            lastNameText: "nil",
            emailAdressText: "nil",
            phoneNumberText: "nil",
            adressCountryText: "nil",
            adressPostalCodeText: "nil",
            adressCityText: "nil",
            adressStreetText: "nil",
            adressStreet: "nil",
            adressMailBoxText: "nil",
            adressBasementText: "nil",
            adressStageText: "nil")*/
        
        
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
    @State var civilityText: String
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
    @State var isTheFinalNumberCorrect: Bool = true
    @State var isTheFinalEmailCorrect: Bool = true
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                BackButtonModel(text: "location")
                
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
                                 
                                 ZStack(alignment: .leading) {
                                     if adressStageText.isEmpty {
                                         Text("stage")
                                             .foregroundColor(.gray)
                                             .opacity(0.6)
                                             .padding(.horizontal, 5)
                                     }
                                     TextField("", text: $adressStageText)
                                         .disableAutocorrection(true)
                                         .autocapitalization(.none)
                                 }
                                 
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
                        VStack(spacing: 20) {
                            
                            VStack {
                                
                                //Spacer()
                                
                                if #available(iOS 15.0, *) {
                                    ScrollView {
                                        
                                        LazyVStack {
                                            
                                            VStack {
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                HStack {
                                                    
                                                    Image(systemName: civilityText == "man" ? "circle.circle.fill" : "circle")
                                                        .foregroundColor(.blue)
                                                        .onTapGesture {
                                                            self.civilityText = "man"
                                                        }
                                                    
                                                    Text("mr")
                                                        //.foregroundColor(.black)
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: civilityText == "woman" ? "circle.circle.fill" : "circle")
                                                        .foregroundColor(.blue)
                                                        .onTapGesture {
                                                            self.civilityText = "woman"
                                                        }
                                                    
                                                    Text("mme")
                                                        //.foregroundColor(.black)
                                                    
                                                }
                                                 
                                                 Spacer()

                                                }.padding(10)
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     ZStack(alignment: .leading) {
                                                         if firstNameText.isEmpty {
                                                             Text("first-name")
                                                                 .foregroundColor(.gray)
                                                                 .opacity(0.6)
                                                                 .padding(.horizontal, 5)
                                                         }
                                                         TextField("", text: $firstNameText)
                                                             .disableAutocorrection(true)
                                                             .autocapitalization(.none)
                                                     }
                                                     
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
                                                     
                                                     ZStack(alignment: .leading) {
                                                         if lastNameText.isEmpty {
                                                             Text("last-name")
                                                                 .foregroundColor(.gray)
                                                                 .opacity(0.6)
                                                                 .padding(.horizontal, 5)
                                                         }
                                                         TextField("", text: $lastNameText)
                                                             .disableAutocorrection(true)
                                                             .autocapitalization(.none)
                                                     }
                                                     
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
                                                     
                                                     ZStack(alignment: .leading) {
                                                         if emailAdressText.isEmpty {
                                                             Text("email-adress")
                                                                 .foregroundColor(.gray)
                                                                 .opacity(0.6)
                                                                 .padding(.horizontal, 5)
                                                         }
                                                         TextField("", text: $emailAdressText)
                                                             .disableAutocorrection(true)
                                                             .autocapitalization(.none)
                                                     }
                                                         
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
                                                if !isTheFinalEmailCorrect {
                                                    Text("email-adress-not-valid")
                                                        .foregroundColor(.red)
                                                }
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     ZStack(alignment: .leading) {
                                                         if phoneNumberText.isEmpty {
                                                             Text("phone")
                                                                 .foregroundColor(.gray)
                                                                 .opacity(0.6)
                                                                 .padding(.horizontal, 5)
                                                         }
                                                         iPhoneNumberField("", text: $phoneNumberText)
                                                             .prefixHidden(false)
                                                             .disableAutocorrection(true)
                                                             .autocapitalization(.none)
                                                     }
                                                 }
                                                 
                                                 Spacer()

                                                }.background(theColorScheme == .dark ? Color.gray : Color.white)
                                                .cornerRadius(7)
                                                .frame(height: 30)
                                                .padding(10)
                                                
                                                if !isTheFinalNumberCorrect {
                                                    Text("unvalid-phone-number")
                                                        .foregroundColor(.red)
                                                }
                                                
                                            }
                                            
                                            
                                            VStack {
                                                
                                                VStack {
                                                 
                                                 Spacer()
                                                 
                                                 HStack {
                                                                                     
                                                     Spacer()
                                                     
                                                     ZStack(alignment: .leading) {
                                                         if adressStreet.isEmpty {
                                                             Text("street")
                                                                 .foregroundColor(.gray)
                                                                 .opacity(0.6)
                                                                 .padding(.horizontal, 5)
                                                         }
                                                         TextField("", text: $adressStreet)
                                                             .disableAutocorrection(true)
                                                             .autocapitalization(.none)
                                                     }
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
                                                     
                                                     ZStack(alignment: .leading) {
                                                         if adressMailBoxText.isEmpty {
                                                             Text("mail-box")
                                                                 .foregroundColor(.gray)
                                                                 .opacity(0.6)
                                                                 .padding(.horizontal, 5)
                                                         }
                                                         TextField("", text: $adressMailBoxText)
                                                             .disableAutocorrection(true)
                                                             .autocapitalization(.none)
                                                     }
                                                     
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
                                                     
                                                     ZStack(alignment: .leading) {
                                                         if adressBasementText.isEmpty {
                                                             Text("basement")
                                                                 .foregroundColor(.gray)
                                                                 .opacity(0.6)
                                                                 .padding(.horizontal, 5)
                                                         }
                                                         TextField("", text: $adressBasementText)
                                                             .disableAutocorrection(true)
                                                             .autocapitalization(.none)
                                                     }
                                                     
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
                                                     
                                                     ZStack(alignment: .leading) {
                                                         if adressStageText.isEmpty {
                                                             Text("stage")
                                                                 .foregroundColor(.gray)
                                                                 .opacity(0.6)
                                                                 .padding(.horizontal, 5)
                                                         }
                                                         TextField("", text: $adressStageText)
                                                             .disableAutocorrection(true)
                                                             .autocapitalization(.none)
                                                     }
                                                     
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
                                    Text("save")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold)
                                        .padding(10)
                                    Spacer()
                                }.background(Color.blue)
                                    .cornerRadius(15)
                                    .padding(20)
                                    .onTapGesture {
                                        
                                        Task {
                                            if emailAdressText.isValideEmailAdress() {
                                                let docRef = db.collection("users").document("user\(auth.currentUser?.uid ?? "nil")").collection("persons").document(bigModel.currentPersonId).collection("Location").document(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].location?.id ?? "nil")
                                                if civilityText != "" && firstNameText != "" && lastNameText != "" && civilityText != "" && emailAdressText != "" && phoneNumberText != "" && adressCountryText != "" && adressPostalCodeText != "" && adressCityText != "" && adressStreetText != "" {
                                                    
                                                    do {
                                                        try docRef.setData(from: BigModel.Location(civility: civilityText, firstName: firstNameText, lastName: lastNameText, emailAdress: emailAdressText, phoneNumber: phoneNumberText, adressCountry: adressCountryText, adressPostalCode: adressPostalCodeText, adressCity: adressCityText, adressStreet: adressStreetText, adressMailBox: adressMailBoxText, adressBasement: adressBasementText, adressStage: adressStageText))
                                                        await bigModel.fetchLocation()
                                                        bigModel.currentview = .LivraisonViews_RecapLivraison
                                                        bigModel.lastViews.append(.LivraisonViews_Livraison)
                                                        
                                                      }
                                                      catch {
                                                        print(error)
                                                      }
                                                    
                                                } else {
                                                    alertTF(title: "some-fields-empty", message: "fill-all-the-fields", primaryTitle: "ok") {
                                                    }
                                                }
                                            } else {
                                                if !phoneNumberText.isValidPhoneNumber() {
                                                    isTheFinalNumberCorrect = false
                                                }
                                                if !emailAdressText.isValideEmailAdress() {
                                                    isTheFinalEmailCorrect = false
                                                }
                                            }
                                        }
                                        
                                    }
                            }
                        }
                    }
                }
                
            }.padding(20)
            
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
