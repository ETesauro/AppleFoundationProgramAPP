//
//  Certificates.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 11/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit

struct DiscoverView: View {
    @ObservedObject var commitment: Commitment
    @EnvironmentObject var shared: Shared
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5){
            Button(action: {
                           withAnimation {
                               self.shared.selectedCommitment = self.commitment
                               DiscoverDetailedView.show(self.shared)
                           }
                       }) {
                        VStack{
                            HStack{
                                VStack (alignment: .leading, spacing: 5){
                                    
                                    UserPreview(user: commitment.userInfo, description: "\(commitment.etaText)", whiteText: shared.darkMode)
                                    Text(commitment.title)
                                        .font(.headline)
                                        .fontWeight(.regular)
                                        .foregroundColor(.primary)
                                    Text(commitment.descr)
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                        .bold()
                                        .foregroundColor(.black)
                                        .frame(width: .none, height: 60, alignment: .leading)
                                }.padding([.horizontal,.bottom]).offset(x: 0, y: -10)
                            }
                           }
                }.buttonStyle(PlainButtonStyle())
                .padding(.vertical, 20)
            
            }
        .frame(width: CGFloat(320), height: CGFloat(230))
        .background(Color.primary.colorInvert())
        .cornerRadius(10)
        .shadow(radius: 10)
    .onAppear(perform: {
        self.commitment.requestETA(source: self.shared.locationManager.lastLocation!)
    })
    }
}

struct DiscoverRow: View {
    @EnvironmentObject var shared: Shared

    var body: some View {
    VStack (alignment: .leading) {
        Text("Around you")
            .fontWeight(.bold)
            .padding(.leading)
            .font(.title)

         ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(shared.discoverArray(), id: \.ID) { currentDiscover in
                  DiscoverView(commitment: currentDiscover)
               }
            }
            .padding(20)
            .padding(.leading, 10)
         }
      }
   }
}

#if DEBUG
struct DiscoverRow_Previews: PreviewProvider {
   static var previews: some View {
      DiscoverRow()
   }
}
#endif
