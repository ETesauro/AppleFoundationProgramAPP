//
//  UserInfo.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 11/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import Foundation

class UserInfo {
    let photo: String
    let name: String
    let surname: String
    var identity: String {
        return "\(name) \(surname)"
    }
    let userID = UUID()
    
    init(photo: String, name: String, surname: String) {
        self.photo = photo
        self.name = name
        self.surname = surname
    }
}
