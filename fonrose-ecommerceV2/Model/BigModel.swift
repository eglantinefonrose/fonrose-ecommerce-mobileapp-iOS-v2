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

class BigModel : ObservableObject {
    
    public static var shared = BigModel()
    
    //@Published var commingFromMeasurement: Bool = false
    @Published var currentview = ViewEnum.Home_homeFeed
    @Published var lastViews: [ViewEnum]
    init(lastViews: [ViewEnum] = []) {
        self.lastViews = lastViews
    }
    @Published var previousView: ViewEnum? = nil
    
    //MARK: HomeFeed
    @Published var showMenu: Bool = false
    
    //MARK: Measurement
    @Published var armpitsMeasurement: String! = ""
    @Published var armsLength: String! = ""
    @Published var headMeasurement: String! = ""
    @Published var pelvisMeasurement: String! = ""
    @Published var pelvisKnee: String! = ""
    @Published var shouldersMeasurement: String! = ""
    @Published var shouldersPelvis: String! = ""
    @Published var commingFromPaymentScreen: Bool = false

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
    @Published var persons: [Person] = []
    @Published var currentPersonIndex: Int = 0
    
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
            
            DispatchQueue.main.async {
                self.currentview = .Auth_PersonPickerView
            }
            
            self.db.collection("user\(self.auth.currentUser?.uid ?? "nil")").getDocuments { snapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                self.persons.removeAll()
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let dbName = document.data()["name"] as? String ?? ""
                        let dbEmail = document.data()["email"] as? String ?? ""
                        
                        self.persons.append(Person(id: Int.random(in: 1...999999), email: dbEmail, name: dbName))
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
    }
    
}
