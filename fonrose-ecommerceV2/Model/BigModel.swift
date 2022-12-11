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
    
    @Published var user: User = User(id: "", email: "", persons: [])
    
    func fetchPerson() {
        
        guard let userId = auth.currentUser?.uid else { return }
        
        db.collection("users").document("user\(userId)").collection("persons").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.user.persons.removeAll()
            querySnapshot?.documents.forEach({ queryDocumentSnapshot in
                let data = queryDocumentSnapshot.data()
                let person = Person(id: queryDocumentSnapshot.documentID, email: data["email"] as? String ?? "", name:  data["name"] as? String ?? "")
                self.user.persons.append(person)
            })
        }
        
    }
    
    @Published var signInErrorMessage = ""
    @Published var signOutErrorMessage = ""
    /*@Published var defaultLocationCoordinate = CLLocationCoordinate2D(latitude: 55, longitude: 25)
    @Published var userDBLat: CGFloat = 50.073658
    @Published var userDBLong: CGFloat = 14.418540*/
    
    //MARK: UserModel
    struct User: Identifiable {
        var id: String = UUID().uuidString
        var email: String
        var persons: [Person]
    }

    struct Location: Identifiable {
        var id: String = UUID().uuidString
        var civility: String
        var firstName: String
        var lastName: String
        var emailAdress: String
        var phoneNumber: String
        var adressCountry: String
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

    struct PersonFirebaseConstants {
        static let email = "email"
        static let name = "name"
    }
    
    struct Person: Identifiable {
        var id = UUID().uuidString
        var email: String
        var name: String
        var measurements: Measurements?
        var location: Location?
        
    }

    @Published var currentview = ViewEnum.Home_homeFeed0
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
    @Published var deletedPersonID: String = ""
    @Published var deletedPersonName: String = ""
    
    func signIn(email: String, password: String) {
        
        //[weak self] sert à ce que Xcode considère les variables email et password comme des "Strongs References" pour pas qu'elles soient effacées si jamais elles ne servent pas
        // !!!!!! il faut que l'adresse email soit valide et que le mdp ait + de 6 caractères, sinon erreur
    
        auth.signIn(withEmail: email, password: password) { Result, Error in
            guard Result != nil, Error == nil else {
                print((Error != nil) ? "error message = \(String(describing: Error?.localizedDescription))" : "no error")
                self.signInErrorMessage = Error?.localizedDescription ?? ""
                return
            }
            
            print("sign in")
            print(self.auth.currentUser?.uid ?? "fck")
            
            self.user = User(id: self.auth.currentUser?.uid ?? "error", email: self.auth.currentUser?.email ?? "error", persons: [])
            self.fetchPerson()
            self.authCurrentView = .Auth_PersonPickerView
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

            self.db.collection("users").document("user\(self.auth.currentUser?.uid ?? "nil")").setData(["email": self.auth.currentUser?.email ?? "no email"])
            self.user.id = self.auth.currentUser?.uid ?? "nil"
            self.user.email = self.auth.currentUser?.email ?? "nil"
            self.signedIn = true
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
        
        self.currentview = .Home_homeFeed0
        self.authCurrentView = .Auth_SignInView
        
        self.signedIn = false
    }

    func isThereAPersonWithTheSameName(name: String) -> Bool {
        for i in 0..<self.user.persons.count {
            if name == self.user.persons[i].name {
                return true
            }
        }
        return false
    }
    
    
    //
    //
    // SINGLETON
    //
    //
    
    public static var shared = BigModel()  // BigModel(shouldInjectMockedData:true)

    
    
    
    //
    //
    // MOCK FOR TESTING
    //
    //
    
    init() {
        print("Constructor BigModel - default")
    }

    init(shouldInjectMockedData: Bool) {
        print("Constructor BigModel - shouldInjectMockedData==true")
        
        let theMeasurement = Measurements(id: "", ArmpitsMeasurement: "0", ArmsLength: "0", HeadMeasurement: "0", PelvisMeasurement: "0", PelvisKnee: "0", ShouldersMeasurement: "0", ShouldersPelvis: "0")
        let theLocation = Location(id: "idLocation", civility: "Mr", firstName: "Eglantine", lastName: "Fonrose", emailAdress: "egl@gmail.com", phoneNumber: "782068157", adressCountry: "France", adressPostalCode: "59300", adressCity: "Va", adressStreet: "3 rue bessmeres", adressMailBox: "3", adressBasement: "1", adressStage: "3", adressLat: 0, adressLong: 0)
        
        let person001 : Person = Person(id: "idPerson001", email: "eglantine.fonrose@gmail.com", name: "Eglantine Fonrose", measurements: theMeasurement, location: theLocation)
        let person002 : Person = Person(id: "idPerson002", email: "malo.fonrose@gmail.com", name: "Malo Fonrose", measurements: theMeasurement, location: theLocation)
        //let person001: Person = Person(data: "data")
        //let person002: Person = Person(data: "data")
        let thePersons : [Person] = [ person001 , person002 ]

        self.user = User(id: "eee", email: "bfonrose@gmail.com", persons: thePersons )
        
        self.currentPersonIndex = 0 // Eglantine
    }

    
}
