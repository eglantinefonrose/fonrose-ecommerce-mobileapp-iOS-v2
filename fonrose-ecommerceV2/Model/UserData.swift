//
//  UserData.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine on 04/05/2020.
//  Copyright © 2020 fonrose. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    
    let didChange = PassthroughSubject<UserData, Never>()
    
    @Published var measurementTextFields = Measurement {
        didSet {
            didChange.send(self)
        }
    }
    
}
