//
//  testFbDocumentUID.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 18/08/2022.
//  Copyright © 2022 fonrose. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct testFbDocumentUID: View {
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    var body: some View {
        
        Text("🐺")
            .onTapGesture {
                self.db.collection("q").document().setData(["name": "name"])
            }
        
        Text("🦖")
            .onTapGesture {
                self.db.collection("q").getDocuments { snapshot, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    if let snapshot = snapshot {
                        for document in snapshot.documents {
                     
                            print(document.documentID)
                        
                        }
                    }
                }
            }
        
    }
}

struct testFbDocumentUID_Previews: PreviewProvider {
    static var previews: some View {
        testFbDocumentUID()
    }
}
