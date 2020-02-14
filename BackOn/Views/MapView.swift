//
//  MapView.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 11/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @EnvironmentObject var shared: Shared
    var detailed: Bool
    var key: UUID
    private static var mapViewStore = [UUID : MKMapView]()
   
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 4.0
            return renderer
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view: MKAnnotationView
            if !annotation.isKind(of: MKUserLocation.self) {
               view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
            } else {
                return nil
            }
            view.canShowCallout = true
            return view
        }
        
    }

    func makeUIView(context: Context) -> MKMapView {
        if let mapView = MapView.mapViewStore[key] {
           return mapView
        }
        
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.delegate = context.coordinator
        MapView.mapViewStore[key] = mapView
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let commitment = shared.commitmentSet[key]
        if commitment != nil {
            let annotation = MKPointAnnotation()
                annotation.title = commitment!.userInfo.name
            annotation.subtitle = commitment!.title
            annotation.coordinate = commitment!.position.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
            
            uiView.addAnnotation(annotation)
            uiView.setRegion(region, animated: true)
            uiView.showsCompass = false
            uiView.showsUserLocation = true
        }
        else {
            print(key.uuidString)
            print(shared.commitmentSet)
            print("\(shared.commitmentSet)")
        }

    }
    
}

 
