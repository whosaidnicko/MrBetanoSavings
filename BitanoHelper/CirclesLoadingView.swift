//
//  CirclesLoadingView.swift
//  Bitana Helper
//
//  Created by Pen Ke on 25/10/2024.
//

import Foundation
import SwiftUI

struct CirclesLoadingView: View {
    
    @State private var scaleInOut = false
    @State private var rotateInOut = false
    @State private var moveInOut = false
    
    var body: some View {
        ZStack {
           
            ZStack {
                
                //MARK: - CIRCLES SET 1
                ZStack {
                    Circle().fill(LinearGradient(gradient: Gradient(colors:[Color.init(hex: "#FE9400"), Color.init(hex: "#FF4800"), Color.white, .black]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? -60 : 0)
                    
                    Circle().fill(LinearGradient(gradient: Gradient(colors:[Color.init(hex: "#FE9400"), Color.init(hex: "#FF4800"), Color.white, .black]), startPoint: .bottom, endPoint: .top))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? 60 : 0)
                }.opacity(0.5)
                
                //MARK: - CIRCLES SET 2
                ZStack {
                    Circle().fill(LinearGradient(gradient: Gradient(colors:[Color.init(hex: "#FE9400"), Color.init(hex: "#FF4800"), Color.white, .black]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? -60 : 0)
                    
                    Circle().fill(LinearGradient(gradient: Gradient(colors:[Color.init(hex: "#FE9400"), Color.init(hex: "#FF4800"), Color.white, .black]), startPoint: .bottom, endPoint: .top))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? 60 : 0)
                }.opacity(0.5)
                .rotationEffect(.degrees(60))
                
                //MARK: - CIRCLES SET 3
                ZStack {
                    Circle().fill(LinearGradient(gradient: Gradient(colors:[Color.init(hex: "#FE9400"), Color.init(hex: "#FF4800"), Color.white, .black]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? -60 : 0)
                    
                    Circle().fill(LinearGradient(gradient: Gradient(colors:[Color.init(hex: "#FE9400"), Color.init(hex: "#FF4800"), Color.white, .black]), startPoint: .bottom, endPoint: .top))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? 60 : 0)
                }.opacity(0.5)
                .rotationEffect(.degrees(120))
                
            }.rotationEffect(.degrees(rotateInOut ? 90 : 0))
             .scaleEffect(scaleInOut ? 1 : 1/4)
            .animation(Animation.easeInOut.repeatForever(autoreverses: true).speed(1/4), value: scaleInOut)
            .onAppear {
                moveInOut.toggle()
                scaleInOut.toggle()
                rotateInOut.toggle()
            }
        }
    }
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
