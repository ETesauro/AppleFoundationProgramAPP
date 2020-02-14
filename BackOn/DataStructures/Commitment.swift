//
//  Committment.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 11/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import Foundation
import CoreLocation

class Commitment {
    let userInfo: UserInfo
    let title: String
    let descr: String
    let date: Date
    let ID: UUID
    var position: CLLocation
    
    init() {
        self.userInfo = UserInfo(photo: "tim", name: "Tim", surname: "Cook")
        self.title = "Default title"
        self.descr = "Default description"
        self.date = Date()
        ID = UUID()
        position = CLLocation(latitude: 41.5, longitude: 44.3)
    }
    
    init(userInfo: UserInfo, title: String, descr: String, date: Date, position: CLLocation) {
        self.userInfo = userInfo
        self.title = title
        self.descr = descr
        self.date = date
        ID = UUID()
        self.position = position
    }
    
    init(userInfo: UserInfo, title: String, descr: String, date: Date, ID: UUID) {
        self.userInfo = userInfo
        self.title = title
        self.descr = descr
        self.date = date
        self.ID = ID
        position = CLLocation(latitude: 41.5, longitude: 44.3)
    }
}

//class CommitmentSet {
//    var commitmentSet: [UUID: Commitment] = [:]
//    func populate () {
//        var id: UUID
//        var commitment: Commitment
//        for _ in 0...5 {
//            id = UUID()
//            commitment = Commitment(userInfo: sonoIo, title: "Prova", descr: "Prova", date: Date(), ID: id)
//            commitmentSet[id] = commitment
//        }
//    }
//    
//    func getEarliestCommitments (n: Int) -> [Commitment] {
//        return commitmentData
//    }
//}

let sonoIo = UserInfo(photo: "tim", name: "Giancarlo", surname: "Sorrentino")

let commitmentData = [
    Commitment(userInfo: sonoIo, title: "Transporting groceries", descr: "It's about a simple transport of some groceries to my place, sadly there is no elevator in my building.\nThanks so much in advance!", date: Date(), position: CLLocation(latitude: 41.5, longitude: 44.3)),
    Commitment(userInfo: sonoIo, title: "Titolo2", descr: "Descrizione di prova", date: Date(), position: CLLocation(latitude: 41.5, longitude: 44.3)),
    Commitment(userInfo: sonoIo, title: "Titolo3", descr: "Descrizione di prova", date: Date(), position: CLLocation(latitude: 41.5, longitude: 44.3)),
    Commitment(userInfo: sonoIo, title: "Titolo4", descr: "Descrizione di prova", date: Date(), position: CLLocation(latitude: 41.5, longitude: 44.3))
]

let uuid1 = UUID()
let uuid2 = UUID()
let uuid3 = UUID()
let uuid4 = UUID()

let commitmentDict: [UUID:Commitment] = [
    uuid1: Commitment(userInfo: sonoIo, title: "Transporting groceries", descr: "It's about a simple transport of some groceries to my place, sadly there is no elevator in my building.\nThanks so much in advance!", date: Date(), ID: uuid1),
    uuid2: Commitment(userInfo: sonoIo, title: "Transporting groceries2", descr: "2", date: Date(), ID: uuid2),
    uuid3: Commitment(userInfo: sonoIo, title: "Transporting groceries3", descr: "3", date: Date(), ID: uuid3),
    uuid4: Commitment(userInfo: sonoIo, title: "Transporting groceries4", descr: "4", date: Date(), ID: uuid4)
]
