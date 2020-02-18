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
    
    @State var selection = 0.0
    @State var date = Date()
    var array = [0.1, 0.3, 4.0, 5, 7.9]
    
    //        var formattedDate: String {
    //            let formatter = DateFormatter()
    //            formatter.dateStyle = .long
    //            return formatter.string(from: date)
    //        }
    
    private let heightFormat = "%.0f cm"
    private let weightFormat = "%.1f kg"
    @State private var pickerType = 0
    
    @State private var heightCm = 0.0
    @State private var weightKg = 0.0
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                
                Text("Add Need")
                    .font(.title)
                    .fontWeight(.bold)
                
                
                Text("What kind of help do you need?")
                Text("Select the kind of need")
                    .onTapGesture { self.present.toggle() }
                    .alert(isPresented: $present, contents: {
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Picker("", selection: self.$selection) {
                                    ForEach(self.array, id: \.self) { item in
                                        Text(String(item))
                                    }
                                }
                                .labelsHidden()
                                Spacer()
                            }
                            .background(BlurView(style: .light).blendMode(.plusLighter))
                            
                        }
                    }) {
                        withAnimation(.easeInOut) {
                            self.present = false
                        }
                }
                
                
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
