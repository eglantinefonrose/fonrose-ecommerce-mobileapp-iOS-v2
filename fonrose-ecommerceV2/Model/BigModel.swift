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
    var user = User(id: "", email: "", persons: [])
    @Published var signInErrorMessage = ""
    @Published var signOutErrorMessage = ""
    @Published var defaultLocationCoordinate = CLLocationCoordinate2D(latitude: 55, longitude: 25)
    @Published var userDBLat: CGFloat = 50.073658
    @Published var userDBLong: CGFloat = 14.418540
    
    //MARK: UserModel
    struct User: Identifiable {
        var id: String = UUID().uuidString
        var email: String
        var persons: [Person]
    }

    struct Location: Identifiable {
        var id: String = UUID().uuidString
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

    struct Measurements: Identifiable {
        var id: String = UUID().uuidString
        var ArmpitsMeasurement: String
        var ArmsLength: String
        var HeadMeasurement: String
        var PelvisMeasurement: String
        var PelvisKnee: String
        var ShouldersMeasurement: String
        var ShouldersPelvis: String
    }

    struct Person: Identifiable {
        var id = UUID().uuidString
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
    @Published var currentPersonId: String = ""
    @Published var isPersonChosen = false
    @Published var isSignInPopUpPresented = false
    @Published var numberArray: [Int] = [0]
    
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
            self.user.id = self.auth.currentUser?.uid ?? "nil"
            self.user.email = self.auth.currentUser?.email ?? "nil"
            self.signedIn = true
            
            self.db.collection("users").document("user\(self.auth.currentUser?.uid ?? "nil")").collection("persons").getDocuments { snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                self.user.persons.removeAll()
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let dbID = document.documentID
                        let dbName = document.data()["name"] as? String ?? ""
                        let dbEmail = document.data()["email"] as? String ?? ""
                        
                        self.user.persons.append(Person(id: dbID, email: dbEmail, name: dbName))
                        
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
    
    @Published var deletedPersonIndex: Int = 0
    
    func deletePerson() {
        
        db.collection("user\(self.auth.currentUser?.uid ?? "nil")").document("person\(personNumber)").delete() { err in
            
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.user.persons.removeAll()
                print("Document successfully removed!")
                
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

            self.db.collection("users").document("user\(self.auth.currentUser?.uid ?? "nil")").setData(["email": self.auth.currentUser?.email ?? "no email", "iban": ""])
            self.authCurrentView = .Auth_PersonPickerView
            
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
        self.user.id = ""
        self.user.email = ""
        self.user.persons = []
        
        self.currentview = .Home_homeFeed
        self.authCurrentView = .Auth_SignInView
        
        self.signedIn = false
    }
    
}
