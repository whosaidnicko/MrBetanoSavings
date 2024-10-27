//
//  ChangeTargetView.swift
//  Mr. Betano Win Using Savings
//
//  Created by Nicolae Chivriga on 25/10/2024.
//

import Foundation
import SwiftUI


struct ChangeTargetView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject private var financeClass: FinanceClass
    @State var attempts: Int = 0
    @State var dream: String = ""
    @State var destination: String = ""
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    navigationManager.goingToView(.wallet)
                }, label: {
                    Image("backBtn")
                })
               
                Text("Add Operation")
                    .font(.custom(Font.bold, size: 20))
                    .foregroundStyle(Color.init(hex: "#111111"))
                
                Spacer()
            }
            
            VStack(spacing: 16) {
                TextfieldBetn(textAdvice: "Title", decimal: false, placeholer: "Dream", input: $dream)
                
                TextfieldBetn(textAdvice: "Required Amount", decimal: true, placeholer: "$ 10 000.00", input: $destination)
            }
            .padding(.top)
            Spacer()
            
            RedButtonView(text: "Save Target") {
                if !dream.isEmpty && !destination.isEmpty {
                    financeClass.wish = dream
                    financeClass.destinationSuma = Double(destination)
                    navigationManager.goingToView(.wallet)
                }
                else {
                    withAnimation(.default) {
                                       self.attempts += 1
                                   }
                }
            }
            .modifier(Shake(animatableData: CGFloat(attempts)))
        }
        .padding()
    }
}
struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}
