//
//  OperationsHistoryRectangleView.swift
//  Mr. Betano Win Using Savings
//
//  Created by Pek Dkop on 27/10/2024.
//

import Foundation
import SwiftUI

struct OperationsHistoryRectangleView: View {
    let moneyModel: MoneyModel
    @State var showAnimation: Bool = false
    @State var secondsRemaining: Double
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.init(hex: "#F8F8F8"))
            .overlay(alignment: .leading) {
                
                HStack {
                    VStack(spacing: 2) {
                        Text(moneyModel.category)
                            .font(.custom(Font.bold, size: 16))
                            .foregroundStyle(Color.init(hex: "#111111"))
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Text(moneyModel.date)
                            .font(.custom(Font.semiBold, size: 13))
                            .foregroundStyle(Color.init(hex: "#707070"))
                    }
                    Spacer()
                    
                    HStack(spacing: 1.5) {
                        Text("\(moneyModel.income ? "+" : "-")")
                            .font(.custom(Font.bold, size: 18))
                            .foregroundStyle(moneyModel.income ? Color.init(hex: "#008F59") : Color.init(hex: "#FC2020"))
                        TextAnimatableValue(value:  Double(moneyModel.amount) ?? 0)
                            .font(.custom(Font.bold, size: 18))
                            .foregroundStyle(moneyModel.income ? Color.init(hex: "#008F59") : Color.init(hex: "#FC2020"))
                    }
                }
                .padding(.horizontal)
            }
            .offset(x: showAnimation ?  0 : (Bool.random() ? -500 : 500))
            .frame(height: 69)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + secondsRemaining) {
                    withAnimation {
                        showAnimation = true
                    }
                }
            }
    }
}
