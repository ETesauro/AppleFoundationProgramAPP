//
//  Certificates.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 11/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI
import MapKit

struct CommitmentDetailedView: View {
    @EnvironmentObject var shared: Shared
    
    var body: some View {
        VStack {
            VStack {
                ZStack{
                    MapView(detailed: true, key: shared.selectedCommitment.ID)
                        .statusBar(hidden: true)
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 515)
                    ZStack{
                        Image(systemName: "circle.fill")
                        .font(.title)
                        .foregroundColor(Color(.systemGroupedBackground))
                        Button(action: {
                            self.shared.viewToShow = "HomeView"
                            }){
                                Image(systemName: "xmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(Color(#colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8, alpha: 1)))
                            }
                        }
                    .offset(x:173, y:-265)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        let request = MKDirections.Request()
                        request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.shared.locationManager.lastLocation!.coordinate ))
                        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: self.shared.selectedCommitment.position.coordinate))
                        let regionSpan = MKCoordinateRegion(center: self.shared.selectedCommitment.position.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                        _ = [
                            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
                        ]
                        request.destination?.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
                        }, label: {
                            Text("Open in Maps").fontWeight(.light)})
                }.padding(.horizontal)
            }
            VStack (alignment: .leading, spacing: 5){
                UserPreview(user: shared.selectedCommitment.userInfo, description: "\(String(Int((shared.eta)/60))) mins from you")
                Text(shared.selectedCommitment.title)
                    .font(.headline)
                    .fontWeight(.regular)
                Text(shared.selectedCommitment.descr)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .bold()
                    .frame(width: .none, height: 60, alignment: .leading)
            }.padding([.horizontal,.bottom]).offset(x: 0, y: -10)
            DoItButton()
        }
    }
}


struct CommitmentDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        CommitmentDetailedView()
    }
}
