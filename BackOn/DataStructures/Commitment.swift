//
//  Committment.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 11/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Commitment: ObservableObject{
    let userInfo: UserInfo
    let title: String
    let descr: String
    let date: Date
    let ID: UUID
    @Published var eta = 0.0
    @Published var etaText = "Calculating..."
    
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
    
    func requestETA(source: CLLocation) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: position.coordinate))
        request.requestsAlternateRoutes = false
        request.transportType = .walking
        let directions = MKDirections(request: request)
        directions.calculateETA { (res, error) in
            guard error == nil else {print("error");return}
            self.eta = res!.expectedTravelTime
            let hour = self.eta>7200 ? "hrs" : "hr"
            if self.eta > 3600{
                self.etaText = "\(Int(self.eta/3600)) \(hour) \(Int((Int(self.eta)%3600)/60)) min from you"
                        } else{
                self.etaText = "\(Int(self.eta/60)) min from you"
                        }
        }
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


let me1 = UserInfo(photo: "tim", name: "Tim", surname: "Cook")
let me2 = UserInfo(photo: "steve", name: "Steve", surname: "Jobs")
let me3 = UserInfo(photo: "elon", name: "Elon", surname: "Musk")
let me4 = UserInfo(photo: "craig", name: "Craig", surname: "Cookss")


let uuid1 = UUID()
let uuid2 = UUID()
let uuid3 = UUID()
let uuid4 = UUID()
let uuid5 = UUID()
let uuid6 = UUID()
let uuid7 = UUID()
let uuid8 = UUID()

let commitmentDict: [UUID:Commitment] = [
    uuid1: Commitment(userInfo: me1, title: "Spesa1", descr: "Descrizione di spesa1", date: Date(), position: CLLocation(latitude: 41.775293, longitude: 14.572105), ID: uuid1),
    uuid2: Commitment(userInfo: me2, title: "Pulizie1", descr: "Descrizione di pulizie1", date: Date(), position: CLLocation(latitude: 41.275293, longitude: 14.572105), ID: uuid2),
    uuid3: Commitment(userInfo: me3, title: "Soldi1", descr: "Descrizione di soldi1", date: Date(), position: CLLocation(latitude: 41.275293, longitude: 15.572105), ID: uuid3),
    uuid4: Commitment(userInfo: me4, title: "Uscita1", descr: "Descrizione di uscita1", date: Date(), position: CLLocation(latitude: 41.075293, longitude: 15.172105), ID: uuid4)
]

let discoverDict: [UUID:Commitment] = [
    uuid5: Commitment(userInfo: me1, title: "Spesa", descr: "Descrizione di spesa", date: Date(), position: CLLocation(latitude: 40.675293, longitude: 14.772105), ID: uuid5),
    uuid6: Commitment(userInfo: me2, title: "Pulizie", descr: "Descrizione di pulizie", date: Date(), position: CLLocation(latitude: 41.675293, longitude: 14.772105), ID: uuid6),
    uuid7: Commitment(userInfo: me3, title: "Soldi", descr: "Descrizione di soldi", date: Date(), position: CLLocation(latitude: 41.675293, longitude: 15.772105), ID: uuid7),
    uuid8: Commitment(userInfo: me4, title: "Uscita", descr: "Descrizione di uscita", date: Date(), position: CLLocation(latitude: 41.275293, longitude: 15.172105), ID: uuid8)
]


//  Questo metodo da un array di commitment restituisce il più imminente assumendo che:
//  l'array HA SOLO commitment futuri (non ancora implementata tale selezione) e NON è VUOTO
func getNextCommitment(data: [Commitment]) -> Commitment {
    var toReturn = data[0]
    for c in data {
        if toReturn.date.compare(c.date) == ComparisonResult.orderedDescending {
            toReturn = c
        }
    }
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
