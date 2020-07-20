//
//  ContentView.swift
//  Animations
//
//  Created by jc on 2020-07-18.
//  Copyright © 2020 J. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    var amount: Double
    var anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    let letters = Array("Hello")
    @State private var animationAmount: CGFloat = 0.7
    @State private var animationAmount1 = 0.0
    @State private var animationAmount2: CGFloat = 0.7
    @State private var animationValue = false
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false
    
    var body: some View {
        // Custom Transitions Using ViewModifier
        VStack(spacing: 10) {
            
            VStack {
                Button("Tap Me") {
                    withAnimation {
                        self.isShowingRed.toggle()
                    }
                }
                
                if isShowingRed {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                        .transition(.pivot)
                }
            }
            
            // View Transition
            VStack {
                Button("Tap Me") {
                    withAnimation {
                        self.isShowingRed.toggle()
                    }
                }
                
                if isShowingRed {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                        .transition(.asymmetric(insertion: .opacity, removal: .scale))
                }
            }
            VStack {
                // Gesture Animation
                LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged { self.dragAmount = $0.translation }
                            .onEnded { _ in
                                withAnimation(.spring()) {
                                    self.dragAmount = .zero
                                }
                        }
                )
                
                // Controlling The Animation Stack
                Button("Tap Me") {
                    self.animationValue.toggle()
                }
                .frame(width: 100, height: 100, alignment: .center)
                .background(animationValue ? Color.black : Color.yellow)
                .foregroundColor(animationValue ? .white : .black)
                .animation(.interpolatingSpring(stiffness: 10, damping: 1))
                .clipShape(RoundedRectangle(cornerRadius: animationValue ? 60 : 0, style: .circular))
                .animation(.default)
                
                // Explicit Animations
                Button("Tap Me") {
                    withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                        self.animationAmount1 += 360
                    }
                }
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .rotation3DEffect(.degrees(animationAmount1), axis: (x: 0, y: 1, z: 0))
                
                // Animating Bindings
                Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
                
                Spacer()
                
                Button("Scale") {
                    self.animationAmount2 += 1
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount2)
            }
            
            // Animating Views
            Button("Tap Me") {
                // self.animationAmount += 1
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.red)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(
                        Animation.easeOut(duration: 1)
                            .repeatForever(autoreverses: false)
                )
            )
            
            HStack(spacing: 0) {
                ForEach(0..<letters.count) { num in
                    Text(String(self.letters[num]))
                        .padding(5)
                        .font(.title)
                        .frame(width: 50, height: 80, alignment: .center)
                        .background(self.enabled ? Color.blue : Color.red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .offset(self.dragAmount)
                        .animation(Animation.default.delay(Double(num) / 20))
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in
                        self.dragAmount = .zero
                        self.enabled.toggle()
                }
            )
        }
        .onAppear {
            self.animationAmount = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


