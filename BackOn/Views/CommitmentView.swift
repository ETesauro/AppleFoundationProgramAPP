//
//  Certificates.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 11/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI
import MapKit

struct CommitmentRow: View {
    @EnvironmentObject var shared: Shared
//    var commitments = [Commitment]()
//    
//    init() {
//        commitments = commitmentData
//    }

   var body: some View {
      VStack (alignment: .leading){
         Text("Your commitments")
            .fontWeight(.heavy)
            .padding(.leading)

         ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(shared.commitmentArray(), id: \.ID) { currentCommitment in
                    CommitmentView(commitment: currentCommitment)
                }
            }
            .padding(20)
            .padding(.leading, 10)
         }
      }
   }
}


struct CommitmentView: View {
    @EnvironmentObject var shared: Shared
    var commitment: Commitment
        
    var body: some View {
         VStack {
            MapView(detailed: false, key: commitment.ID)
                .frame(height: 250)
            Button(action: {
                withAnimation {
                    let annotation = MKPointAnnotation()
                    annotation.title = "Nome"
                    annotation.subtitle = "Descrizione"
                    annotation.coordinate = self.commitment.position.coordinate
                    self.shared.getETA(annotation: annotation)
                    self.shared.selectedCommitment = self.commitment
                    CommitmentDetailedView.show(self.shared)
                }
            }) {
                VStack{
                    Avatar(image: commitment.userInfo.photo, size: 60)
                    Spacer()
                    
                    Text(self.commitment.userInfo.identity)
                    .font(.title)
                    .foregroundColor(Color(.systemGroupedBackground))
                    Spacer()
                    
                    Text(self.commitment.title).foregroundColor(Color(
                    .systemGroupedBackground))
                }.offset(x: 0, y: -30)
            }
        }
        .frame(width: CGFloat(320), height: CGFloat(400))
        .background(Color.primary)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}



#if DEBUG
struct CommitmentRow_Previews: PreviewProvider {
   static var previews: some View {
      CommitmentRow()
   }
}
#endif



