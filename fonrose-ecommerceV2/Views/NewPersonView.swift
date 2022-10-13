//
//  NewUserView.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 06/07/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct NewPersonView: View {
    
    let db = Firestore.firestore()
    @State var email: String = ""
    @State var name: String = ""
    @EnvironmentObject var bigModel: BigModel

    var body: some View {
        VStack {
            
            Spacer()
            
            TextField("name", text: $name)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Spacer()
            
            TextField("email", text: $email)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Spacer()
            
            Text("Save")
                .foregroundColor(.blue)
                .onTapGesture {
                
                    db.collection("users").document("user\(Auth.auth().currentUser?.uid ?? "nil")").collection("persons").document().setData(["email": email, "name": name]) { _ in
                        self.db.collection("users").document("user\(Auth.auth().currentUser?.uid ?? "nil")").collection("persons").getDocuments { snapshot, error in
                            guard error == nil else {
                                print(error!.localizedDescription)
                                return
                            }
                            
                            bigModel.user.persons.removeAll()
                                                                
                            if let snapshot = snapshot {
                                for document in snapshot.documents {
                                    let dbID = document.documentID
                                    let dbName = document.data()["name"] as? String ?? ""
                                    let dbEmail = document.data()["email"] as? String ?? ""
                                    
                                    bigModel.user.persons.append(BigModel.Person(id: dbID, email: dbEmail, name: dbName))
                                    print(bigModel.user.persons.count)
                                    print("person added")
                                    
                                }
                                
                                bigModel.authCurrentView = .Auth_PersonPickerView
                                
                            }
                        
                        email = ""
                        name = ""
                        print(bigModel.user.persons.count)
                        print(Auth.auth().currentUser?.uid ?? "nil")
                            
                    }
                }
                
            }
            
            Spacer()
            
        }
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewPersonView()
    }
}
