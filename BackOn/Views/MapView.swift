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
        mapView.showsCompass = false
        MapView.mapViewStore[key] = mapView
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {

        let commitment = shared.commitmentSet[key]
        if commitment != nil {
            //https://stackoverflow.com/questions/51010956/how-can-i-know-if-an-annotation-is-already-on-the-mapview
            if uiView.annotations.isEmpty {
                let annotation = MKPointAnnotation()
                annotation.title = commitment!.userInfo.name
                annotation.subtitle = commitment!.title
                annotation.coordinate = commitment!.position.coordinate
                CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude), completionHandler: {(placemarks, error) in
                    if let e = error {
                        print("Reverse geocoder failed with error: " + e.localizedDescription)
                        return
                    } // place is an instance of CLPlacemark and has the encapsulated address
                    if let place = placemarks {
                        let pm = place[0]
                        commitment!.textAddress = self.address(pm)
                    } else {
                        print("Problem with the data received from geocoder")
                    }
                })
                uiView.addAnnotation(annotation)
            }
            if shared.viewToShow == "CommitmentDetailedView" && uiView.overlays.isEmpty {
                uiView.showsUserLocation = true
                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: uiView.userLocation.coordinate, addressDictionary: nil))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: commitment!.position.coordinate, addressDictionary: nil))
                request.requestsAlternateRoutes = false
                request.transportType = .walking
                MKDirections(request: request).calculate { (response, error) in
                    guard error == nil, let response = response else {print(error!.localizedDescription);return}
                    var fastestRoute: MKRoute = response.routes[0]
                    for route in response.routes {
                        if route.expectedTravelTime < fastestRoute.expectedTravelTime {
                            fastestRoute = route
                        }
                    }
                    uiView.addOverlay(fastestRoute.polyline, level: .aboveRoads)
                    print("\(uiView.overlays)")
                }
            } else {
//                uiView.removeOverlays(uiView.overlays)
            }
            let span = MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
            let region = MKCoordinateRegion(center: commitment!.position.coordinate, span: span)
            uiView.setRegion(region, animated: false)
        } else {
            print(key.uuidString)
            print(shared.commitmentSet)
            print("\(shared.commitmentSet)")
        }
    }
    
    private func address(_ p: CLPlacemark) -> String {
        var ret = ""
        if let n = p.name, let t = p.thoroughfare, n.contains(t) {
            ret = "\(n), "
        } else {
            if let n = p.name {
                ret = "\(n), "
            }
            if let t = p.thoroughfare {
                if let st = p.subThoroughfare {
                    ret = "\(ret)\(st) "
                }
                ret = "\(ret)\(t), "
            }
        }
        if let c = p.country {
            if let aa = p.administrativeArea {
                if let l = p.locality {
                    ret = "\(ret)\(l) "
                }
                ret = "\(ret)\(aa), "
            }
            ret = "\(ret)\(c)"
        }
        if let pc = p.postalCode {
            ret = "\(ret) - \(pc)"
        }
        return ret
    }
}
