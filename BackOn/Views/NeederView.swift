//
//  HomeView.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 12/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI

struct NeederView: View {
    var body: some View {
        
//      VStack che contiene due bottoni, il primo per chiedere i permessi
//      di inviare notifiche,
//      Il secondo attualmente triggera la notifica con il nextCommitment
        VStack{
            
            Text("Ciao Andy!")
                .font(.largeTitle)
                .bold()
                .fontWeight(.heavy)
                .padding(2)
            
            CommitmentRow()
            
            Spacer()
            
            AddNeedButton()
            
            Spacer()
            
        }
    }


    
}

#if DEBUG
struct NeederView_Previews: PreviewProvider {
   static var previews: some View {
      NeederView()
   }
}
#endif
