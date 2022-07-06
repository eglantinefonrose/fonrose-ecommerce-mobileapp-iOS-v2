//
//  BigModel.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 22/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import Foundation
import CoreLocation
import FirebaseAuth
import FirebaseFirestore
import MapKit

class BigModel : ObservableObject {
    
    public static var shared = BigModel()
    var user = User(id: 0, userID: "", email: "", persons: [])
    
    //MARK: UserModel
    struct User: Identifiable {
        var id: Int
        var userID: String
        var email: String
        var persons: [Person]
    }

    struct Location {
        var adress: String
    }

    struct Measurements {
        var ArmpitsMeasurement: String
        var ArmsLength: String
        var HeadMeasurement: String
        var PelvisMeasurement: String
        var PelvisKnee: String
        var ShouldersMeasurement: String
        var ShouldersPelvis: String
    }

    struct Person: Identifiable {
        var id: Int
        var email: String
        var name: String
        var measurements: Measurements?
        var location: Location?
    }


    @Published var currentview = ViewEnum.Home_homeFeed
    @Published var currentPopUpView = ViewEnum.Auth_SignInView
    @Published var lastViews: [ViewEnum] = []
    @Published var previousView: ViewEnum? = nil
    
    //MARK: HomeFeed
    @Published var showMenu: Bool = false

    //MARK: Service Client
    @Published var orderID : String? = nil
    @Published var orderStatus : SuiviStatusEnum? = nil
    
    //MARK: Location
    @Published var selectedPlacemark: CLPlacemark? = nil
    
    //MARK: Authentification
    @Published var currentUserName: String = ""
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    @Published var signedIn = false
    @Published var currentPersonIndex: Int = 0
    @Published var isPersonChosen = false
    @Published var isSignInPopUpPresented = false
    
    func signIn(email: String, password: String) {
        
        //[weak self] sert à ce que Xcode considère les variables email et password comme des "Strongs References" pour pas qu'elles soient effacées si jamais elles ne servent pas
        // !!!!!! il faut que l'adresse email soit valide et que le mdp ait + de 6 caractères, sinon erreur
    
        auth.signIn(withEmail: email, password: password) { Result, Error in
            guard Result != nil, Error == nil else {
                print("yeah")
                print((Error != nil) ? "error message = \(Error.debugDescription)" : "no error")
                return
            }
            //Success
            print("groovy baby!")
            print(self.auth.currentUser?.email ?? "nil")
            self.user.userID = self.auth.currentUser?.uid ?? "nil"
            self.user.email = self.auth.currentUser?.email ?? "nil"
            self.signedIn = true
            
            self.db.collection("user\(self.auth.currentUser?.uid ?? "nil")").getDocuments { snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                self.user.persons.removeAll()
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let dbName = document.data()["name"] as? String ?? ""
                        let dbEmail = document.data()["email"] as? String ?? ""
                        
                        self.user.persons.append(Person(id: Int.random(in: 1...999999), email: dbEmail, name: dbName))
                        
                        DispatchQueue.main.async {
                            self.authCurrentView = .Auth_PersonPickerView
                        }
                        
                        print("doc added")
                    }
                }
                
            }
            
        }
        
    }
    
    //MARK: Des modifications de l'appli à la db Firebase
    func newUserSignIn(email: String, password: String) {
        
        //[weak self] sert à ce que Xcode considère les variables email et password comme des "Strongs References" pour pas qu'elles soient effacées si jamais elles ne servent pas
        // !!!!!! il faut que l'adresse email soit valide et que le mdp ait + de 6 caractères, sinon erreur
        auth.signIn(withEmail: email, password: password) { [weak self] Result, Error in
            guard Result != nil, Error == nil else {
                print((Error != nil) ? "error message = \(Error.debugDescription)" : "no error")
                return
            }
            
            DispatchQueue.main.async {
                self!.signedIn = true
            }

            
        }
        
    }
    
    //MARK: Sign up
    
    @Published var authCurrentView =  ViewEnum.Auth_SignInView
    @Published var authLastViews: [ViewEnum] = []
    
    var newUserAccountEmail: String = ""
    var newUserAccountPassword: String = ""
    
    func signUp(newUserEmail: String, newUserPassword: String) {
        
        auth.createUser(withEmail: newUserEmail, password: newUserPassword) { Result, Error in
            guard Result != nil, Error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.signedIn = true
            }
            self.currentview = .Auth_LogInNewUserView
        }
    
    }
    
    var newEmail: String = ""
    
    func changeEmailAdress(_ newValue : String) {
        newEmail = newValue
        objectWillChange.send()
    }
    
    var newPassword: String = ""
    
    func changePassword(_ newValue : String) {
        newPassword = newValue
        objectWillChange.send()
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
        print("current user id is \(self.auth.currentUser?.uid ?? "nil")")
        
        self.isPersonChosen = false
        self.user.id = 0
        self.user.userID = ""
        self.user.email = ""
        self.user.persons = []
        
        self.currentview = .Home_homeFeed
        
        self.signedIn = false
    }
    
    func getCurrentPersonMeasurement() {
        
        if signedIn {
            
            if self.currentPersonIndex+1 < 10 {
                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(self.currentPersonIndex+1)").collection("Mensurations").getDocuments { snapshot, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    if let snapshot = snapshot {
                        for document in snapshot.documents {
                            let dbArmpitsMeasurement = document.data()["ArmpitsMeasurement"] as? String ?? ""
                            let dbArmsLength = document.data()["ArmsLength"] as? String ?? ""
                            let dbHeadMeasurement = document.data()["HeadMeasurement"] as? String ?? ""
                            let dbPelvisMeasurement = document.data()["PelvisMeasurement"] as? String ?? ""
                            let dbPelvisKnee = document.data()["PelvisKnee"] as? String ?? ""
                            let dbShouldersMeasurement = document.data()["ShouldersMeasurement"] as? String ?? ""
                            let dbShouldersPelvis = document.data()["ShouldersPelvis"] as? String ?? ""
                            
                            self.user.persons[self.currentPersonIndex].measurements = BigModel.Measurements(ArmpitsMeasurement: dbArmpitsMeasurement, ArmsLength: dbArmsLength, HeadMeasurement: dbHeadMeasurement, PelvisMeasurement: dbPelvisMeasurement, PelvisKnee: dbPelvisKnee, ShouldersMeasurement: dbShouldersMeasurement, ShouldersPelvis: dbShouldersPelvis)
                            
                        }
                    }
                }
            }
            
            else {
                db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(self.currentPersonIndex+1)").collection("Mensurations").getDocuments { snapshot, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    if let snapshot = snapshot {
                        for document in snapshot.documents {
                            let dbArmpitsMeasurement = document.data()["ArmpitsMeasurement"] as? String ?? ""
                            let dbArmsLength = document.data()["ArmsLength"] as? String ?? ""
                            let dbHeadMeasurement = document.data()["HeadMeasurement"] as? String ?? ""
                            let dbPelvisMeasurement = document.data()["PelvisMeasurement"] as? String ?? ""
                            let dbPelvisKnee = document.data()["PelvisKnee"] as? String ?? ""
                            let dbShouldersMeasurement = document.data()["ShouldersMeasurement"] as? String ?? ""
                            let dbShouldersPelvis = document.data()["ShouldersPelvis"] as? String ?? ""
                            
                            self.user.persons[self.currentPersonIndex].measurements = Measurements(ArmpitsMeasurement: dbArmpitsMeasurement, ArmsLength: dbArmsLength, HeadMeasurement: dbHeadMeasurement, PelvisMeasurement: dbPelvisMeasurement, PelvisKnee: dbPelvisKnee, ShouldersMeasurement: dbShouldersMeasurement, ShouldersPelvis: dbShouldersPelvis)
                            
                        }
                    }
                }
            }
            
        }
        
    }
    
}
