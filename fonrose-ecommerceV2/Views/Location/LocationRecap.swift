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
    @State var adressBasement: String = BigModel().user.persons[BigModel().currentPersonIndex].location?.adressBasement ?? ""
    @State var adressCity: String = BigModel().user.persons[BigModel().currentPersonIndex].location?.adressCity ?? ""
    @State var adressLat: String = "\(BigModel().user.persons[BigModel().currentPersonIndex].location?.adressLat ?? 0)"
    @State var adressLong: String = "\(BigModel().user.persons[BigModel().currentPersonIndex].location?.adressLong ?? 0)"
    @State var adressMailBox: String = BigModel().user.persons[BigModel().currentPersonIndex].location?.adressMailBox ?? ""
    @State var adressPostalCode: String = BigModel().user.persons[BigModel().currentPersonIndex].location?.adressPostalCode ?? ""
    @State var adressStage: String = BigModel().user.persons[BigModel().currentPersonIndex].location?.adressStage ?? ""
    @State var adressStreet: String = BigModel().user.persons[BigModel().currentPersonIndex].location?.adressStreet ?? ""
    
    var body: some View {
        
        VStack {
            
            TextField("Postal Code", text: $adressPostalCode)
            TextField("City", text: $adressCity)
            TextField("Street", text: $adressStreet)
            TextField("Adress Mail Box", text: $adressMailBox)
            TextField("Basement", text: $adressBasement)
            TextField("Stage", text: $adressStage)
            
        }
        
    }
}

struct LocationRecap_Previews: PreviewProvider {
    static var previews: some View {
        LocationRecap()
    }
}
