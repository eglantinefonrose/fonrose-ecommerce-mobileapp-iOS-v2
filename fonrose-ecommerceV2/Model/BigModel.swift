//
//  self.swift
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
    @Published var signInErrorMessage = ""
    @Published var signOutErrorMessage = ""
    @Published var defaultLocationCoordinate = CLLocationCoordinate2D(latitude: 55, longitude: 25)
    @Published var userDBLat: CGFloat = 50.073658
    @Published var userDBLong: CGFloat = 14.418540
    
    //MARK: UserModel
    struct User: Identifiable {
        var id: Int
        var userID: String
        var email: String
        var persons: [Person]
    }

    struct Location {
        var civility: String
        var lastName: String
        var firstName: String
        var emailAdress: String
        var phoneNumber: String
        var adressPostalCode: String
        var adressCity: String
        var adressStreet: String
        var adressMailBox: String
        var adressBasement: String
        var adressStage: String
        var adressLat: CGFloat
        var adressLong: CGFloat
        
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
    
    //MARK: Authentification
    @Published var currentUserName: String = ""
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    @Published var signedIn = false
    @Published var currentPersonIndex: Int = 0
    @Published var isPersonChosen = false
    @Published var isSignInPopUpPresented = false
    
    //MARK: Persons
    @Published var personNumber: String = ""
    
    func signIn(email: String, password: String) {
        
        //[weak self] sert à ce que Xcode considère les variables email et password comme des "Strongs References" pour pas qu'elles soient effacées si jamais elles ne servent pas
        // !!!!!! il faut que l'adresse email soit valide et que le mdp ait + de 6 caractères, sinon erreur
    
        auth.signIn(withEmail: email, password: password) { Result, Error in
            guard Result != nil, Error == nil else {
                print("yeah")
                //print((Error != nil) ? "error message = \(String(describing: Error?.localizedDescription))" : "no error")
                self.signInErrorMessage = Error?.localizedDescription ?? ""
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
    
    func deletePerson() {
        
        db.collection("user\(self.auth.currentUser?.uid ?? "nil")").document("person\(personNumber)").delete() { err in
            
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.user.persons.removeAll()
                print("Document successfully removed!")
                
                /*if self.user.persons.count == 0 {
                    self.db.collection("user\(self.auth.currentUser?.uid ?? "nil")").getDocuments { snapshot, error in
                        guard error == nil else {
                            print(error!.localizedDescription)
                            return
                        }
                        
                        self.user.persons.removeAll()
                        var number = 0
                        if let snapshot = snapshot {
                            for document in snapshot.documents {
                                let dbName = document.data()["name"] as? String ?? ""
                                let dbEmail = document.data()["email"] as? String ?? ""
                                
                                self.user.persons.append(Person(id: Int.random(in: 1...999999), email: dbEmail, name: dbName))
                                
                                DispatchQueue.main.async {
                                    self.authCurrentView = .Auth_PersonPickerView
                                }
                                
                                print("the person index is \(number)")
                                
                                /*if self.user.persons.count < 9 {
                                    
                                    self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(number)").setData(["email": self.user.persons[number].email, "name": self.user.persons[number].name]) { _ in
                                        
                                        self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(number+1)").collection("Mensurations").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(number+1)-Mensurations").setData(["ArmpitsMeasurement": self.user.persons[number].measurements?.ArmpitsMeasurement ?? "", "ArmsLength": self.user.persons[number].measurements?.ArmsLength ?? "", "HeadMeasurement": self.user.persons[number].measurements?.HeadMeasurement ?? "", "PelvisMeasurement": self.user.persons[number].measurements?.PelvisMeasurement ?? "", "PelvisKnee": self.user.persons[number].measurements?.PelvisKnee ?? "", "ShouldersMeasurement": self.user.persons[number].measurements?.ShouldersMeasurement ?? "", "ShouldersPelvis": self.user.persons[number].measurements?.ShouldersPelvis ?? ""])
                                        
                                        self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person0\(number+1)").collection("Location").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person0\(number+1)-Location").setData(["civility": self.user.persons[number].location?.civility ?? "", "lastName" : self.user.persons[number].location?.lastName ?? "", "firstName": self.user.persons[number].location?.firstName ?? "", "emailAdress": self.user.persons[number].location?.emailAdress ?? "", "phoneNumber": self.user.persons[number].location?.phoneNumber ?? "", "adressPostalCode": self.user.persons[number].location?.adressPostalCode ?? "", "adressCity": self.user.persons[number].location?.adressCity ?? "", "adressStreet": self.user.persons[number].location?.adressStreet ?? "", "adressMailBox": self.user.persons[number].location?.adressMailBox ?? "", "adressBasement": self.user.persons[number].location?.adressBasement ?? "", "adressStage": self.user.persons[number].location?.adressStage ?? "", "adressLat": self.user.persons[number].location?.adressLat ?? 0, "adressLong": self.user.persons[number].location?.adressLong ?? 0])
                                        
                                    }
                                    
                                }
                                
                                else {
                                    
                                    self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(number+1)").setData(["email": self.user.persons[number].email, "name": self.user.persons[number].name])
                                    
                                    self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(number+1)").collection("Mensurations").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person\(number+1)-Mensurations").setData(["ArmpitsMeasurement": "", "ArmsLength": "", "HeadMeasurement": "", "PelvisMeasurement": "", "PelvisKnee": "", "ShouldersMeasurement": "", "ShouldersPelvis": ""])
                                    
                                    self.db.collection("user\(Auth.auth().currentUser?.uid ?? "nil")").document("person\(number+1)").collection("Location").document("user\(Auth.auth().currentUser?.uid ?? "nil")-person\(number+1)-Location").setData(["civility": "", "lastName" : "", "firstName": "", "emailAdress": "", "phoneNumber": "", "adressPostalCode": "", "adressCity": "", "adressStreet": "", "adressMailBox": "", "adressBasement": "", "adressStage": "", "adressLat": 0, "adressLong": 0])
                                    
                                }*/
                                
                                number = number+1
                            }
                        }
                    }
                }*/
                
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
                self.signOutErrorMessage = Error?.localizedDescription ?? ""
                return
            }
            
            DispatchQueue.main.async {
                self.signedIn = true
            }
            self.authCurrentView = .Auth_LogInNewUserView
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
        self.authCurrentView = .Auth_SignInView
        
        self.signedIn = false
    }
    
}
