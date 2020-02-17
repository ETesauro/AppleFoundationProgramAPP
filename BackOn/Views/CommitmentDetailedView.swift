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
    @ObservedObject var selectedCommitment: Commitment
    
    var body: some View {
        VStack {
            VStack {
                ZStack{
                    MapViewCommitment(key: selectedCommitment.ID)
                        .statusBar(hidden: true)
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 515)
                    ZStack{
                        Image(systemName: "circle.fill")
                        .font(.title)
                        .foregroundColor(Color(.systemGroupedBackground))
                        Button(action: {
                            withAnimation{
                                HomeView.show(self.shared)
                            }}){
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
                        request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.shared.locationManager.lastLocation!.coordinate))
                        let destination = MKMapItem(placemark: MKPlacemark(coordinate: self.selectedCommitment.position.coordinate))
                        destination.name = "\(self.selectedCommitment.userInfo.name)'s request: \(self.selectedCommitment.title)"
                        request.destination = destination
                        request.destination?.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking])
                        }, label: {
                            Text("Open in Maps").fontWeight(.light)})
                }.padding(.horizontal)
            }
            VStack (alignment: .leading, spacing: 5){
                UserPreview(user: selectedCommitment.userInfo, description: selectedCommitment.etaText, whiteText: shared.darkMode)
                Text(selectedCommitment.title)
                    .font(.headline)
                    .fontWeight(.regular)
                Text(selectedCommitment.descr)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .bold()
                    .frame(width: .none, height: 60, alignment: .leading)
            }.padding([.horizontal,.bottom]).offset(x: 0, y: -10)
            CantDoItButton()
        }.onAppear {
            self.selectedCommitment.requestETA(source: self.shared.locationManager.lastLocation!)
        }
    }
}


//struct CommitmentDetailedView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommitmentDetailedView()
//    }
//}
