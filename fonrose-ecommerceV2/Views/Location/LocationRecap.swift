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

struct LocationRecap: View {
    
    @EnvironmentObject var bigModel: BigModel
    var db = Firestore.firestore()
    var test: String = ""
    
    var body: some View {
        
        LocationTextField(civilityText: bigModel.user.persons[bigModel.currentPersonIndex].location?.civility ?? "", lastNameText: bigModel.user.persons[bigModel.currentPersonIndex].location?.lastName ?? "", firstNameText: bigModel.user.persons[bigModel.currentPersonIndex].location?.firstName ?? "", emailAdressText: bigModel.user.persons[bigModel.currentPersonIndex].location?.emailAdress ?? "", phoneNumberText: bigModel.user.persons[bigModel.currentPersonIndex].location?.phoneNumber ?? "", adressPostalCodeText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressPostalCode ?? "", adressCityText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressCity ?? "", adressStreetText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressStreet ?? "", adressMailBoxText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressMailBox ?? "", adressBasementText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressBasement ?? "", adressStageText: bigModel.user.persons[bigModel.currentPersonIndex].location?.adressStage ?? "")
        
    }
}

struct LocationTextField: View {
    
    @EnvironmentObject var bigModel: BigModel
    var db = Firestore.firestore()
    @State var civilityText: String = ""
    @State var lastNameText: String = ""
    @State var firstNameText: String = ""
    @State var emailAdressText: String = ""
    @State var phoneNumberText: String = ""
    @State var adressPostalCodeText: String = ""
    @State var adressCityText: String = ""
    @State var adressStreetText: String = ""
    @State var adressMailBoxText: String = ""
    @State var adressBasementText: String = ""
    @State var adressStageText: String = ""
    
    var body: some View {
        
        VStack {
            
            Spacer()
                
                HStack {
                    Spacer()
                        .frame(width: 50)
                    
                    Text("Recap")
                        .font(.system(size: 45, weight: .bold, design: .default))
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 50)
            
            VStack {
                
                TextField("Civility", text: $civilityText)
                
                Spacer()
                
                TextField("Last Name", text: $lastNameText)
                
                Spacer()
                
                TextField("First Name", text: $firstNameText)
                
                Spacer()
                
                TextField("Email Adress", text: $emailAdressText)
                
                Spacer()
                
                TextField("Phone Number", text: $phoneNumberText)
                
                Spacer()
                
            }
            
            VStack {
    
                VStack {
                    TextField("Postal Code Text", text: $adressPostalCodeText)
                    Spacer() }
                
                VStack {
                    TextField("City", text: $adressCityText)
                    Spacer() }
                
                VStack {
                    TextField("Street", text: $adressStreetText)
                    Spacer() }
                
                VStack {
                    TextField("Mail Box", text: $adressMailBoxText)
                    Spacer() }
                
                VStack {
                    TextField("Basement", text: $adressBasementText)
                    Spacer() }
                
                VStack {
                    TextField("Stage", text: $adressStageText)
                    Spacer() }
                
            }
            
            Spacer()
            
            HStack {
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    Text("Location")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                    Spacer()
                
                }.background(Color.blue)
                .frame(width: 150)
                .cornerRadius(5)
                
                Spacer()
                
            }.frame(width: 120, height: 35)
            .background(Color.blue)
            .cornerRadius(15)
            .onTapGesture {
                
                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(bigModel.user.persons.count)").collection("Location").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(bigModel.user.persons.count)-Location").setData(["civility": civilityText, "lastName" : lastNameText, "firstName": firstNameText, "emailAdress": emailAdressText, "phoneNumber": phoneNumberText, "adressPostalCode": adressPostalCodeText, "adressCity": adressCityText, "adressStreet": adressStreetText, "adressMailBox": adressMailBoxText, "adressBasement": adressBasementText, "adressStage": adressStageText, "adressLat": bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLat ?? 0, "adressLong": bigModel.user.persons[bigModel.currentPersonIndex].location?.adressLong ?? 0])
                bigModel.currentview = .Home_homeFeed
                
            }
            
            Spacer()
                .frame(height: 50)
            
        }
        
    }

}

struct LocationRecap_Previews: PreviewProvider {
    static var previews: some View {
        LocationRecap()
    }
}
