//
//  UserInfo.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 11/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import Foundation

class UserInfo {
    var photo: String
    var name: String
    var surname: String
    var identity: String {
        return "\(name) \(surname)"
    }
    var userID = UUID()
    var email: String?
    
    init(photo: String, name: String, surname: String) {
        self.photo = photo
        self.name = name
        self.surname = surname
    }
    
//    Costruttore aggiuntivo utilizzato al momento dell'accesso con Google
    init(photo: String, name: String, surname: String, email: String) {
        self.photo = photo
        self.name = name
        self.surname = surname
        self.email = email
    }
}
