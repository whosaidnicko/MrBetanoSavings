//
//  TextfieldBetn.swift
//  Mr. Betano Win Using Savings
//
//  Created by Pek Dkop on 26/10/2024.
//

import Foundation
import SwiftUI

struct TextfieldBetn: View {
    let textAdvice: String
    let decimal: Bool
    let placeholer: String
    @Binding var input: String
    @FocusState var keybordActive
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(textAdvice)
                    .font(.custom(Font.medium, size: 13))
                    .foregroundStyle(Color.init(hex: "#707070"))
                
                
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.init(hex: "#F8F8F8"))
                        .overlay {
                            
                            HStack {
                                TextField("", text: $input)
                                    .foregroundStyle(Color.init(hex: "#111111"))
                                    .keyboardType(decimal ? .decimalPad : .default)
                                    .focused($keybordActive)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            if input.isEmpty {
                                HStack {
                                    Text(placeholer)
                                        .font(.custom(Font.medium, size: 16))
                                        .foregroundStyle(Color.init(hex: "#707070"))
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                        }
                        .frame(height: 56)
                        .onTapGesture {
                            keybordActive = true 
                        }
            }
            Spacer()
        }
//        .padding(.horizontal)
    }
}
