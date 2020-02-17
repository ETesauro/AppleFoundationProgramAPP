//
//  SharedResources.swift
//  BackOn
//
//  Created by Emmanuel Tesauro on 14/02/2020.
//  Copyright © 2020 Emmanuel Tesauro. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Shared: ObservableObject {
    @Published var activeView = "HomeView"
    @Published var authentication = false
    @Published var viewToShow = "HomeView"
    @Published var eta = 0.0
    var darkMode: Bool{
        get{
            return UIScreen.main.traitCollection.userInterfaceStyle == .dark
        }
    }
    
    var textEta: String {
        get{
            let hour = eta>7200 ? "hours" : "hour"
            if eta > 3600{
                return "\(Int(eta/3600)) \(hour) and \(Int((Int(eta)%3600)/60)) mins"
            } else{
                return "\(Int(eta/60)) mins"
            }
        }
    }
    @Published var locationManager = LocationManager()
    @Published var selectedCommitment = Commitment()
    @Published var commitmentSet: [UUID:Commitment] = commitmentDict
    
    func getETA(destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: locationManager.lastLocation!.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.requestsAlternateRoutes = false
        request.transportType = .walking
        let directions = MKDirections(request: request)
        directions.calculateETA { (res, error) in
            guard error == nil else {print("error");return}
            self.eta = res!.expectedTravelTime
        }
    }
    
    func commitmentArray() -> [Commitment] {
        return Array(commitmentSet.values)
    }
}
