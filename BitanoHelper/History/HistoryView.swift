//
//  HistoryView.swift
//  Bitana Helper
//
//  Created by Pen Ke on 27/10/2024.
//

import Foundation
import SwiftUI

struct HistoryView: View {
    private var formatter: NumberFormatter {
       let formatter = NumberFormatter()
       formatter.numberStyle = .currency
       formatter.locale = Locale(identifier: "en_US")
       return formatter
    }
    
    @State var totalTotal: Double = 0
    @State var spendingCategory: SpendingCategory? = nil
    @EnvironmentObject private var financeClass: FinanceClass
    @EnvironmentObject private var navigationManager: NavigationManager
    @State var categories = [
        SpendingCategory(name: "Housing", amount: 0, color: Color.init(hex: "#FF6110")),
        SpendingCategory(name: "Transportation", amount: 0, color: Color.init(hex: "#FC2020")),
        SpendingCategory(name: "Food", amount: 0, color: Color.init(hex: "#E60180")),
        SpendingCategory(name: "Health", amount: 0, color: Color.init(hex: "#7B358E")),
        SpendingCategory(name: "Personal Expenses", amount: 0, color: Color.init(hex: "#404D9C")),
        SpendingCategory(name: "Education", amount: 0, color: Color.init(hex: "#0172B6")),
        SpendingCategory(name: "Family", amount: 0, color: Color.init(hex: "#0097BE")),
        SpendingCategory(name: "Investments", amount: 0, color: Color.init(hex: "#008F59")),
        SpendingCategory(name: "Debt and Loans", amount: 0, color: Color.init(hex: "#75BC00")),
        SpendingCategory(name: "Gifts", amount: 0, color: Color.init(hex: "#F9E701")),
        SpendingCategory(name: "Entertainment", amount: 0, color: Color.init(hex: "#FEC705"))
        , SpendingCategory(name: "Miscellaneous Expenses", amount: 0, color: Color.init(hex: "#FF9000"))
    ]
    let columns = [
        GridItem(.flexible(), spacing: 3),
          GridItem(.flexible(), spacing: 3),
          GridItem(.flexible(), spacing: 3)
      ]
    @State var totalSuma: Double = 0
    @State var operations: [MoneyModel] = []
    var filteredCategories: [SpendingCategory] {
        categories.filter { $0.amount > 0 }
    }
    
    var totalAmount: Double {
        filteredCategories.map { $0.amount }.reduce(0, +)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Analytics")
                    .font(.custom(Font.bold, size: 20))
                    .foregroundStyle(Color.init(hex: "#111111"))
                
                Spacer()
                Button(action: {
                    navigationManager.fullScreenCoverSettings = true
                }, label: {
                    Image("settingsBtn")
                })
            }
            ScrollView(showsIndicators: false) {
                if totalSuma != 0 {
                    ZStack {
                        ForEach(categories) { category in
                            let index = categories.firstIndex(where: { $0.id == category.id }) ?? 0
                            let startAngle = angle(for: categories.prefix(index).map { $0.amount }.reduce(0, +))
                            let endAngle = angle(for: categories.prefix(index + 1).map { $0.amount }.reduce(0, +))
                            let adjustedEndAngle = startAngle + (endAngle - startAngle)
                            
                            CircleSegment(startAngle: startAngle, endAngle: adjustedEndAngle)
                                .trim(from: 0, to:  animate ? 1 : 0)
                                .stroke(category.color, lineWidth: 30)
                                .opacity(spendingCategory == nil || spendingCategory?.id == category.id ? 1 : 0.5)  // Apply conditional opacity
                                
                                .onTapGesture {
                                    withAnimation {
                                        spendingCategory = spendingCategory ==  nil  ?  category : nil
                                    }
                                }
                        }
                    }
                    .frame(width: 200, height: 200)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(Animation.linear(duration: 1.5)) {
                                animate = true
                            }
                        }
                    }
                    .padding(.top)
                    .overlay  {
                        VStack {
                            Text(spendingCategory == nil ? "Total expenses" : spendingCategory!.name)
                                .font(.custom(Font.bold, size: 14))
                                .foregroundStyle(Color.init(hex: "#111111"))
                            
                            TextAnimatableValue(value: totalSuma, formatter: formatter)
                                .font(.custom(Font.bold, size: 24))
                                .foregroundStyle(Color.init(hex: "#FE3B00"))
                        }
                    }
                } else {
                    Circle()
                        .fill(Color.init(hex: "#F8F8F8"))
                        .frame(width: 200, height: 200)
                        .padding(.top)
                        .overlay  {
                            Text("No expenses")
                                .font(.custom(Font.bold, size: 14))
                                .foregroundStyle(Color.init(hex: "#111111"))
                        }
                    
                }
                
                
                Spacer()
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(categories.indices, id: \.self) { index in
                        
                        AnalyticsRectangleView(color: categories[index].color, category: categories[index].name)
                            .opacity(spendingCategory == nil || spendingCategory?.id == categories[index].id ? 1 : 0.5)  // Apply conditional opacity
                            .onTapGesture {
                                withAnimation {
                                    spendingCategory =  spendingCategory == nil ? categories[index] : nil
                                    if spendingCategory != nil {
                                        withAnimation {
                                            totalSuma = categories[index].amount
                                        }
                                    
                                    } else {
                                        withAnimation {
                                            totalSuma = totalTotal
                                        }
                                    }
                                }
                            }
                       
                    }
                }
                .padding(.top, 40)
            }
        }
        .padding()
        .onAppear() {
            operations = UserDefaults.standard.loadMoneys()
            updateSpending()
            
        }
    }
    
    private func angle(for amount: Double) -> Angle {
        return .degrees((amount / totalAmount) * 360)
    }
    @State var animate: Bool = false
    func updateSpending() {
        for operation in operations {
            if let index = categories.firstIndex(where: { $0.name == operation.category }) {
                // Check if the operation is not income
                if !operation.income {
                    categories[index].amount += (Double(operation.amount) ?? 0) 
                    withAnimation {
                        totalSuma += (Double(operation.amount) ?? 0)
                    }
              
                }
                // If needed, you can also add logic here for what to do with income operations
            }
        }
        totalTotal = totalSuma
    }

}
import SwiftUI

struct SpendingCategory: Identifiable {
    let id = UUID()
    let name: String
    var amount: Double
    let color: Color
}

//struct SpendingCircleView: View {
//    let totalAmount: Double
//    let categories: [SpendingCategory]
//    
//
//    
//    @State private var selectedCategory: UUID? = nil  // Track selected category
//
//    var body: some View {
//        
//    }
//    
//   
//}

struct CircleSegment: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        return path
    }
}
