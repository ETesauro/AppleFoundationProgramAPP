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
    @Published var locationManager = LocationManager()
    @Published var selectedCommitment = Commitment()
    @Published var commitmentSet: [UUID:Commitment] = commitmentDict
    @Published var discoverSet: [UUID:Commitment] = discoverDict
    @Published var helperMode = true
    
    var darkMode: Bool{
        get{
            return UIScreen.main.traitCollection.userInterfaceStyle == .dark
        }
    }
    
    func commitmentArray() -> [Commitment] {
        return Array(commitmentSet.values)
    }
    
    func discoverArray() -> [Commitment] {
        return Array(discoverSet.values)
    }
}
