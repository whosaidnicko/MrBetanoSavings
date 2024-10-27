//
//  RedButtonView.swift
//  Mr. Betano Win Using Savings
//
//  Created by Nicolae Chivriga on 26/10/2024.
//

import Foundation
import SwiftUI

struct RedButtonView: View {
    let text: String
    let action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }, label: {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.init(hex: "#FE3B00"))
                .overlay {
                    Text(text)
                        .font(.custom(Font.bold, size: 18))
                        .foregroundStyle(Color.white)
                }
        })
    
            .frame(height: 56)
            
    }
}
