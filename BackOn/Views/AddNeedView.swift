//
//  Certificates.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 11/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI

struct AddNeedView: View {
    var commitment = commitmentData[0]
    
    var body: some View {
        VStack {
            
            VStack (alignment: .leading, spacing: 10){
                Text("Add Need")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("What kind of help you need?")
                    .font(.body)
                    .fontWeight(.medium)
                
                
                Spacer()
                ConfirmAddNeedButton()
            }.padding()
        }
    }
}

struct AddNeedView_Previews: PreviewProvider {
    static var previews: some View {
        AddNeedView()
    }
}
