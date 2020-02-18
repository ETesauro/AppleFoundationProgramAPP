//
//  HomeView.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 12/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI

struct AddNeedView: View {
    @State var present = false
    @State var present2 = false
    
    class Pickerelection: ObservableObject {
        @Published var selection = 0
    }
    
    @State var date = Date()
    var array = ["Select your need", "b", "c", "d", "e", "f"]
    @ObservedObject var needTitlePicker = Pickerelection()

    
    private let heightFormat = "%.0f cm"
    private let weightFormat = "%.1f kg"
    @State private var pickerType = 0
    
//    @Published var toggleOn = false
    
    @State private var heightCm = 0.0
    @State private var weightKg = 0.0
    
    @State var temp: String = ""
    @State var needDescription: String = ""
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                
                Text("Add Need")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text("Title")
                    .font(.headline)
                
                TextField("\(self.array[Int(self.needTitlePicker.selection)])", text: $temp)
                    .disabled(true)
                    .onTapGesture { self.present.toggle() }
                    .alert(isPresented: $present, contents: {
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Picker("Il Picker maledetto", selection: self.$needTitlePicker.selection) {
//                                    ForEach(self.array, id: \.self) { item in
//                                        Text(item)
//                                    }
                                    ForEach(1 ..< self.array.count) {
                                       Text(self.array[$0])
                                    }
                                }
                                .labelsHidden()
                            }
                            .background(BlurView(style: .light).blendMode(.plusLighter))
                            
                        }
                    }) {
                        withAnimation(.easeInOut) {
                            print("Mi apro \n\n")
                            self.present = false
                            self.needTitlePicker.selection = self.needTitlePicker.selection + 1
                            print(self.needTitlePicker.selection)
                            print("\n")
                        }
                }
                
            
                
                HStack{
                Text("Description")
                    .font(.headline)
                Text(" Optional")
                    .font(.caption)
                }
                
                TextField("", text: self.$needDescription)
                    .background(Color(.systemGray5))
                    .font(.callout)
//
//                Toggle(isOn: $toggleOn) {
//                    Text("@State Toggle: \(String(toggleOn))")
//                }
//                Toggle(isOn: $data.toggleOn) {
//                    Text("@Published Toggle: \(String(data.toggleOn))")
//                }
                
                Spacer()
            }
            Spacer()
            
            
        }.padding()
    }
}

struct BlurView: UIViewRepresentable {
    
    typealias UIViewType = UIVisualEffectView
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIViewType {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return visualEffectView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

extension View {
    
    func alert<Contents: View>(isPresented: Binding<Bool>, contents: @escaping () -> Contents, onBackgroundTapped: @escaping () -> Void = { }) -> some View {
        
        self.modifier(AlertView(isPresented: isPresented, contents: contents, onBackgroundTapped: onBackgroundTapped))
    }
}


struct AlertView<Contents: View>: ViewModifier {
    @Binding var isPresented: Bool
    var contents: () -> Contents
    var onBackgroundTapped: () -> Void = { }
    
    @State private var rect: CGRect = .zero
    
    
    func body(content: Content) -> some View {
        if rect == .zero {
            return AnyView(
                content.bindingFrame(to: $rect))
        } else {
            return AnyView(content
                .frame(width: rect.width, height: rect.height)
                .overlay(
                    ZStack(alignment: .center) {
                        Color
                            .black
                            .opacity(isPresented ? 0.7 : 0)
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .position(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, in: .global)
                            .onTapGesture {
                                self.onBackgroundTapped()
                        }
                        .animation(.easeInOut)
                        
                        
                        contents()
                            .position(x: UIScreen.main.bounds.midX, y: isPresented ? UIScreen.main.bounds.midY : (UIScreen.main.bounds.midY + UIScreen.main.bounds.height), in: .global)
                            .animation(.spring())
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height),
                    alignment: .center))
        }
        
    }
}

public extension View {
    func position(_ position: CGPoint, in coordinateSpace: CoordinateSpace) -> some View {
        return self.position(x: position.x, y: position.y, in: coordinateSpace)
    }
    func position(x: CGFloat, y: CGFloat, in coordinateSpace: CoordinateSpace) -> some View {
        GeometryReader { geometry in
            self.position(x: x - geometry.frame(in: coordinateSpace).origin.x, y: y - geometry.frame(in: coordinateSpace).origin.y)
        }
    }
}

struct GeometryGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }
    
    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = geometry.frame(in: .global)
        }
        
        return Rectangle().fill(Color.clear)
    }
}

extension View {
    func bindingFrame(to binding: Binding<CGRect>) -> some View {
        self.background(GeometryGetter(rect: binding))
    }
}

#if DEBUG
struct AddNeedView_Previews: PreviewProvider {
    static var previews: some View {
        AddNeedView()
    }
}
#endif
