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
    @EnvironmentObject var shared: Shared

    
    var body: some View {
        VStack (alignment: .leading, spacing: 5){
            Button(action: {
                           withAnimation {
                               self.shared.getETA(destination: self.commitment.position.coordinate)
                               self.shared.selectedCommitment = self.commitment
                               DiscoverDetailedView.show(self.shared)
                           }
                       }) {
                        VStack{
                            HStack{
                                VStack (alignment: .leading, spacing: 5){
                                    UserPreview(user: shared.selectedCommitment.userInfo, description: "\(shared.textEta) from you", whiteText: shared.darkMode)
                                    Text(shared.selectedCommitment.title)
                                        .font(.headline)
                                        .fontWeight(.regular)
                                        .foregroundColor(.primary)
                                    Text(shared.selectedCommitment.descr)
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
    }
}

struct DiscoverRow: View {

   var aroundme = discoverData

   var body: some View {
    VStack (alignment: .leading) {
        Text("Around you")
            .fontWeight(.bold)
            .padding(.leading)
            .font(.title)

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
