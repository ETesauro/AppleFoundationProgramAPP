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
            view.displayPriority = .required
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
                    let span = MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
                    let region = MKCoordinateRegion(center: commitment!.position.coordinate, span: span)
                    if uiView.annotations.isEmpty{
                        let annotation = MKPointAnnotation()
                        annotation.title = commitment!.userInfo.name
                        annotation.subtitle = commitment!.title
                        annotation.coordinate = commitment!.position.coordinate
                        uiView.addAnnotation(annotation)
                    }
        //            in case of troubles, see                              https://stackoverflow.com/questions/51010956/how-can-i-know-if-an-annotation-is-already-on-the-mapview
                    uiView.setRegion(region, animated: true)
                    uiView.showsCompass = false
                    uiView.showsUserLocation = true
                    
        //            if uiView.overlays.isEmpty{
        //                print("Niente Overlay!")
        //            }
                    
                    if uiView.overlays.isEmpty{ //&& !shared.removeOverlay
                        let request = MKDirections.Request()
                        request.source = MKMapItem(placemark: MKPlacemark(coordinate: uiView.userLocation.coordinate, addressDictionary: nil))
                        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: (commitment?.position.coordinate)!, addressDictionary: nil))
                        request.requestsAlternateRoutes = false
                        request.transportType = .automobile
                        MKDirections(request: request).calculate { (response, error) in
                        guard error == nil, let response = response else {return}

                        for route in response.routes {
                            uiView.addOverlay(route.polyline, level: .aboveRoads)
                            }
                        }
                    }
        //            else if shared.removeOverlay{
        //                uiView.removeOverlays(uiView.overlays)
        //            }
        //            print(" Overlay alla fine dell'update: \(uiView.overlays), remove overlays: \(shared.removeOverlay)")
               }
        else {
            print(key.uuidString)
            print(shared.commitmentSet)
            print("\(shared.commitmentSet)")
        }

    }
    
}

 
