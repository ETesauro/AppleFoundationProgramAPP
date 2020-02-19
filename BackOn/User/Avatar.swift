//
//  ContentView.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 10/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI

struct Avatar: View {
    let image: Image?
    let size: CGFloat = 60

    var body: some View {
        if image == nil {
            return Image(systemName: "questionmark.circle.fill")
            .renderingMode(.original)
            .resizable()
            .frame(width: size, height: size)
            .background(Color.white)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 7)
        } else {
            return image!
            .renderingMode(.original)
            .resizable()
            .frame(width: size, height: size)
            .background(Color.white)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 7)
        }
        

    }
    
}
