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
    @Published var viewToShow = "LoginPageView"
    @Published var eta = 0.0
    @Published var locationManager = LocationManager()
    @Published var selectedCommitment = Commitment()
    @Published var commitmentSet: [UUID:Commitment] = commitmentDict

       func getETA(annotation: MKAnnotation) {
           let request = MKDirections.Request()
           request.source = MKMapItem(placemark: MKPlacemark(coordinate: locationManager.lastLocation!.coordinate, addressDictionary: nil))
           request.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil))
           request.requestsAlternateRoutes = false
           request.transportType = .walking
           let directions = MKDirections(request: request)
           directions.calculateETA { (res, error) in
               guard error == nil else {print("error");return}
               print(res!.expectedTravelTime)
               self.eta = res!.expectedTravelTime
           }
       }

       func commitmentArray() -> [Commitment] {
           return Array(commitmentSet.values)
       }
}
