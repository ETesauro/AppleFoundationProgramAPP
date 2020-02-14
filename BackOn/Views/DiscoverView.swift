//
//  Certificates.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 11/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI
import CoreLocation
struct DiscoverView: View {
    var commitment: Commitment
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5){
            UserPreview(user: commitment.userInfo).padding(.top, 15)
            Text(commitment.title)
                .foregroundColor(.white)
                .fontWeight(.medium)
                .padding([.horizontal])
            Text(commitment.descr)
                .foregroundColor(.white)
                .padding([.horizontal])
            Spacer()
            Text("1km from you")
                .foregroundColor(.white)
                .padding([.horizontal,.bottom])
        }
        .frame(width: CGFloat(320), height: CGFloat(230))
        .background(Color.primary)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DiscoverRow: View {

   var aroundme = discoverData

   var body: some View {
    VStack (alignment: .leading) {
        Text("Around you")
            .fontWeight(.heavy)
            .padding(.leading)

         ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(aroundme, id: \.ID) { currentCommitment in
                  DiscoverView(commitment: currentCommitment)
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


let me = UserInfo(photo: "tim", name: "Tim", surname: "Cook")

let discoverData = [
    Commitment(userInfo: me, title: "Titolo1", descr: "Descrizione di prova", date: Date(), position: CLLocation(latitude: 40.675293, longitude: 14.772105)),
    Commitment(userInfo: me, title: "Titolo2", descr: "Descrizione di prova", date: Date(), position: CLLocation(latitude: 40.675293, longitude: 14.772105)),
    Commitment(userInfo: me, title: "Titolo3", descr: "Descrizione di prova", date: Date(), position: CLLocation(latitude: 40.675293, longitude: 14.772105)),
    Commitment(userInfo: me, title: "Titolo4", descr: "Descrizione di prova", date: Date(), position: CLLocation(latitude: 40.675293, longitude: 14.772105))
]
