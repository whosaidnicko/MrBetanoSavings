//
//  AnalyticsRectangleView.swift
//  Mr. Betano Win Using Savings
//
//  Created by Pek Dkop on 27/10/2024.
//

import Foundation
import SwiftUI

struct AnalyticsRectangleView: View {
    let color: Color
    let category: String
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(color)
                .frame(width: 12, height: 12)
                .padding(.leading)
            
            Text(category)
                .font(.custom(Font.semiBold, size: 10))
                .foregroundStyle(Color.init(hex: "#111111"))
                .fixedSize(horizontal: false, vertical: true)
                .minimumScaleFactor(0.01)
            
            Spacer()
        }
        
        .frame(height: 80)
        .background(Color.init(hex: "#F8F8F8"))
        .cornerRadius(50)
    

    }
}
