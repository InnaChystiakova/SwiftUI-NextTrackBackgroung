//
//  ContentView.swift
//  NextTrackBackground
//
//  Created by Inna Chystiakova on 10/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var performAnimation: Bool = false
    
    var body: some View {
        Button {
            if !performAnimation {
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                    performAnimation = true
                } completion: {
                    performAnimation = false
                }
            }
        } label: {
            GeometryReader { proxy in
                let width = proxy.size.width / 2
                
                HStack(alignment: .center, spacing: 0) {
                    ArrowImage(width: performAnimation ? width : 0)
                        .opacity(performAnimation ? 1 : 0)
                    ArrowImage(width: width)
                    ArrowImage(width: performAnimation ? 0.5 : width)
                        .opacity(performAnimation ? 0 : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .buttonStyle(CustomButtonStyle())
        .frame(maxWidth: 80)
    }
}

struct ArrowImage: View {
    let systemName = "play.fill"
    var width: CGFloat
    
    var body: some View {
        Image(systemName: systemName)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: width)
    }
}

struct CustomButtonStyle: ButtonStyle {
    let scale: Double = 0.86
    let duration: Double = 0.22
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(9)
            .background(configuration.isPressed ? Color(.systemGray3) : Color(.clear))
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? scale : 1)
            .animation(.interpolatingSpring(duration: duration),
                       value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
}
