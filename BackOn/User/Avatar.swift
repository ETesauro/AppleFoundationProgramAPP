//
//  ContentView.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 10/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI

struct Avatar: View {
    
    // image
    let image: String
    
    // size
    let size: CGFloat

    var body: some View {
        Image(image)        // creates an imageview with specified image
            .renderingMode(.original)
            .resizable()    // makes image resizable
            .frame(width: size, height: size)       // frame for the image (width, height)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 10)
//            .padding(.trailing)
    }
}
