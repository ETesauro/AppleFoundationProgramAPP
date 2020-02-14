//
//  HomeView.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 12/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                CommitmentRow()
                DiscoverRow()
            }
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      HomeView()
   }
}
#endif
