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
    var textAddress: String?
    
       init() {
            self.userInfo = UserInfo(photo: "tim", name: "Tim", surname: "Cook")
            self.title = "Default title"
            self.descr = "Default description"
            self.date = Date()
            ID = UUID()
            position = CLLocation(latitude: 40.675293, longitude: 14.772105)
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
            position = CLLocation(latitude: 40.675293, longitude: 14.772105)
        }
        
        init(userInfo: UserInfo, title: String, descr: String, date: Date, position: CLLocation, ID: UUID) {
            self.userInfo = userInfo
            self.title = title
            self.descr = descr
            self.date = date
            self.ID = ID
            self.position = position
    }
    
    func timeRemaining() -> TimeInterval {
        return date.timeIntervalSinceNow
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

//let commitmentData = [
//    Commitment(userInfo: sonoIo, title: "Transporting groceries", descr: "It's about a simple transport of some groceries to my place, sadly there is no elevator in my building.\nThanks so much in advance!", date: Date(), position: CLLocation(latitude: 40.675293, longitude: 14.772105)),
//    Commitment(userInfo: sonoIo, title: "Titolo2", descr: "Descrizione di prova", date: Date(), position: CLLocation(latitude: 40.675293, longitude: 14.772105)),
//    Commitment(userInfo: sonoIo, title: "Titolo3", descr: "Descrizione di prova", date: Date(), position: CLLocation(latitude: 40.675293, longitude: 14.772105)),
//    Commitment(userInfo: sonoIo, title: "Titolo4", descr: "Descrizione di prova", date: Date(), position: CLLocation(latitude: 40.675293, longitude: 14.772105))
//]

let uuid1 = UUID()
let uuid2 = UUID()
let uuid3 = UUID()
let uuid4 = UUID()

let commitmentDict: [UUID:Commitment] = [
    uuid1: Commitment(userInfo: sonoIo, title: "Transporting groceries", descr: "It's about a simple transport of some groceries to my place, sadly there is no elevator in my building.\nThanks so much in advance!", date: Date().addingTimeInterval(TimeInterval(29*60)), ID: uuid1),
    uuid2: Commitment(userInfo: sonoIo, title: "Transporting groceries2", descr: "2", date: Date().addingTimeInterval(TimeInterval(31*60)), ID: uuid2),
    uuid3: Commitment(userInfo: sonoIo, title: "Transporting groceries3", descr: "3", date: Date().addingTimeInterval(TimeInterval(31*60)), ID: uuid3),
    uuid4: Commitment(userInfo: sonoIo, title: "Transporting groceries4", descr: "4", date: Date().addingTimeInterval(TimeInterval(31*60)), ID: uuid4)
]


 //  Questo metodo da un array di commitment restituisce il più imminente assumendo che:
func getNextCommitment(dataDictionary: [UUID:Commitment]) -> Commitment? {
    if(dataDictionary.count == 0){
        return nil
    }
     let data = Array(dataDictionary.values)
     var toReturn = data[0]
     for c in data {
         if toReturn.date.compare(c.date) == ComparisonResult.orderedDescending {
            toReturn = c
         }
     }
     return toReturn
 }

func getNextNotificableCommitment(dataDictionary: [UUID:Commitment]) -> Commitment? {
    if(dataDictionary.count == 0){
        return nil
    }
     var data = Array(dataDictionary.values)
    var toReturn: Commitment?
    repeat{
        let i = data.removeFirst()
        if(i.timeRemaining() > TimeInterval(30*60)){
            toReturn = toReturn == nil ? i : toReturn
            if(toReturn!.timeRemaining() > i.timeRemaining()){
                toReturn = i
            }
        }
    } while data.count>0
    
    return toReturn
}
 
 func getNextFive(dataDictionary: [UUID: Commitment]) -> [Commitment]{
     let data = Array(dataDictionary.values)
     var toReturn: [Commitment] = [data[0]]
//   Mi serve a sapere se non ho ancora inserito i primi 5 elementi ordinatamente
     var last = 0

     for i in 1...data.count {
         for j in stride(from: last < 5 ? last : 4, through: 0, by: -1) {
             if toReturn[j].date.compare(data[i].date) == ComparisonResult.orderedDescending{
                 let toShift = toReturn[j]
                 toReturn[j] = data[i]
                 toReturn[j + 1] = toShift
             } else {
                 if last < 5 {
                    toReturn[last + 1] = data[i]
                 }
             }
             last += 1
         }
     }
     return toReturn
 }
