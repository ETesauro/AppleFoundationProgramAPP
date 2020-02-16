//
//  UIElements.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 12/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI

var locAlert = Alert(
    title: Text("Location permission denied"),
    message: Text("To let the app work properly, enable location permissions"),
    primaryButton: .default(Text("Open settings")) {
        if let url = URL(string:UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    },
    secondaryButton: .cancel()
)

struct DoItButton: View {
    @EnvironmentObject var shared: Shared
    
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                print("I'll do it")
                HomeView.show(self.shared)
            }) {
                HStack{
                    Text("I'll do it ")
                        .fontWeight(.regular)
                        .font(.title)
                    Image(systemName: "hand.raised")
                        .font(.title)

                }
                .padding(20)
                .background(Color.blue)
                .cornerRadius(40)
                .foregroundColor(.white)
                .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.blue, lineWidth: 1).foregroundColor(Color.blue)
                )
            }
            Spacer()
        }
    }
}

struct DoItButton_Previews: PreviewProvider {
    static var previews: some View {
        DoItButton()
    }
}
