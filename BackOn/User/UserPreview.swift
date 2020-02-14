//
//  UserPreview.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 11/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI

struct UserPreview: View {
    var user: UserInfo
    var descr: String
    
    init(user: UserInfo, description descr: String) {
        self.user = user
        self.descr = descr
    }
    
    init(user: UserInfo) {
        self.user = user
        descr = ""
    }
    
    var body: some View {
        HStack {
            Avatar(image: user.photo, size: 60)
            VStack (alignment: .leading){
                Text(user.identity)
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .offset(x: 0, y: -3)
                if descr != "" {
                    Text(descr)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(Color.black)
                        .offset(x: 0, y: 1)
                }
            
            }.padding(.leading)
            Spacer()
        }
        .padding([.horizontal, .bottom])
    }
}

struct UserPreview_Previews: PreviewProvider {
    static var previews: some View {
        UserPreview(user: UserInfo(photo: "tim", name: "Giancarlo", surname: "Sorrentino"),description: "5 mins from you")
    }
}
