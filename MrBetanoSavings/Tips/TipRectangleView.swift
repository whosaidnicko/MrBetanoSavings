//
//  TipRectangleView.swift
//  Mr. Betano Win Using Savings
//
//  Created by Nicolae Chivriga on 26/10/2024.
//

import Foundation
import SwiftUI

struct TipRectangleView: View {
    let tipModel: TipModel
    let animationAppearing: Double
    @State var show: Bool = false
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.init(hex: "#F8F8F8"))
            .overlay(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(tipModel.title)
                        .font(.custom(Font.semiBold, size: 16))
                        .foregroundStyle(Color.init(hex: "#FE3B00"))
                    
                    Text(tipModel.text)
                        .font(.custom(Font.medium, size: 14))
                        .foregroundStyle(Color.init(hex: "#111111"))
                }
                .padding(.horizontal)
            }
            .frame(height: 106)
            .scaleEffect(show ? 1 : 0)
            .onAppear() {
                withAnimation(Animation.easeInOut.delay(animationAppearing)) {
                    show = true
                }
            }
    }
}
