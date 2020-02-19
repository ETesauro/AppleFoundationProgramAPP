//
//  HomeView.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 12/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI

class PickerSelection: ObservableObject {
    var array = ["a", "b", "c", "d", "e", "f"]
    @Published var show = false
    @Published var value = -1
}


struct AddNeedView: View {
    @ObservedObject var pickerSelection = PickerSelection()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Add Need")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Spacer()
                CloseButton()
            }
            Text("Type of your need")
                .font(.headline)
            Text(self.pickerSelection.value == -1 ? "Click to select your need" : "\(self.pickerSelection.array[Int(self.pickerSelection.value)])")
                .onTapGesture {
                    withAnimation {self.pickerSelection.show.toggle()}
                }
            HStack{
                Text("Description (optional)")
                    .font(.headline)
            }
//            TextField("", text: self.$needDescription)
//                .background(Color(.systemGray5))
//                .font(.callout)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        .overlay(PickerOverlay(isPresented: self.$pickerSelection.show, selectedValue: self.$pickerSelection.value, pickerElements: pickerSelection.array))
 
    }
}


struct PickerOverlay: View {
    @Binding var isPresented: Bool
    @Binding var selectedValue: Int
    var pickerElements: [String]
 
    var body: some View {
        VStack {
            if self.isPresented {
                    Color
                        .black
                        .opacity(0.7)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation() {
                                self.isPresented = false
                            }
                        }
                        .overlay(
                            Picker("Select your need", selection: self.$selectedValue) {
                                ForEach(0 ..< self.pickerElements.count) {
                                    Text(self.pickerElements[$0])
                                        .font(.headline)
                                        .fontWeight(.medium)
                                }
                            }.labelsHidden()
                            .frame(width: UIScreen.main.bounds.width, height: 250)
                            .background(Color.primary.colorInvert()),
                            alignment: .bottom
                        )
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .animation(.easeInOut)
            } else {
                EmptyView()
                    .animation(.easeInOut)
            }
        }
        
    }
}

#if DEBUG
struct AddNeedView_Previews: PreviewProvider {
    static var previews: some View {
        AddNeedView()
    }
}
#endif
