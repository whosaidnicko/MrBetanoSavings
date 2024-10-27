//
//  ChooseCategoryRectangle.swift
//  Mr. Betano Win Using Savings
//
//  Created by Nicolae Chivriga on 26/10/2024.
//

import Foundation
import SwiftUI

struct ChooseCategoryRectangle: View {
    @State var category: [String] = ["Housing","Transportation","Food","Health","Personal Expenses","Education","Family","Investments","Debt and Loans", "Gifts", "Entertainment", "Miscellaneous Expenses"]
    @State var extendedRectnangle: Bool = false
    @Binding var caterogySelected: String?
    
    var body: some View {
        VStack {
           
            
            Group {
                if extendedRectnangle {
                    ForEach(category.indices, id: \.self) { index in
                        Text(category[index])
                            .foregroundStyle(Color.init(hex: "#111111"))
                            .font(.custom(Font.semiBold, size: 16))
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                caterogySelected = category[index]
                                withAnimation(Animation.bouncy) {
                                    extendedRectnangle = false
                                }
                            }
                    }
                } else {
                    HStack {
                        Text(caterogySelected ?? "Category")
                            .foregroundStyle(Color.init(hex: "#111111"))
                            .font(.custom(Font.semiBold, size: 16))
//                            .frame(width: UIScreen.main.bounds.width * 0.90
//                                   ,height: 56)
                        
                        Spacer()
                        
                        Image("bottomArrow")
                    }
                    .background() {
                        Color.init(hex: "#F8F8F8")
                            .ignoresSafeArea()
                    }
                    .frame(height: 56)
                    .padding(.horizontal)
                }
            }
            .transition(.scale)
        }
        .frame(maxWidth: .infinity)
        .background(Color.init(hex: "#F8F8F8"))
        .cornerRadius(8)
    
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                withAnimation(Animation.bouncy) {
                    extendedRectnangle = true
                }
            }
    }
}
