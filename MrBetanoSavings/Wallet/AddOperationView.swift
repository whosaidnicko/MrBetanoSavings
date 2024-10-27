//
//  AddOperationView.swift
//  Mr. Betano Win Using Savings
//
//  Created by Nicolae Chivriga on 26/10/2024.
//

import Foundation
import SwiftUI

struct AddOperationView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject private var financeClass: FinanceClass
    var formattedDate: String {
          let formatter = DateFormatter()
          formatter.dateFormat = "dd/MM/yyyy"
          return formatter.string(from: Date())
      }
    @State var amount: String = ""
    @State var attempts: Int = 0
    @State private var selectedDate = Date()
    @State var income: Bool = true
    @State var selectedCategory: String?
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
            ScrollView {
                VStack(spacing: 20) {
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.init(hex: "#F8F8F8"))
                            .frame(width: 165, height: 43)
                            .overlay {
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.init(hex: "#FE3B00"))
                                        .frame(width: 165, height: 43)
                                        .offset(x: self.income ? 0 : -400)
                                    
                                    Text("Income")
                                        .font(.custom(Font.bold, size: 16))
                                        .foregroundStyle(!income ? Color.init(hex: "#707070") : Color.white)
                                }
                            }
                            .scrollTransition(.animated) { content, phase in

                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.3)
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.3)

                            }
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                                withAnimation(Animation.linear(duration: 0.8)) {
                                    self.income = true
                                }
                            }
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.init(hex: "#F8F8F8"))
                            .frame(width: 165, height: 43)
                            .overlay {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.init(hex: "#FE3B00"))
                                        .frame(width: 165, height: 43)
                                        .offset(x: !self.income ? 0 : 400)
                                    
                                    Text("Expenses")
                                        .font(.custom(Font.bold, size: 16))
                                        .foregroundStyle(income ? Color.init(hex: "#707070") : Color.white)
                                }
                            }
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                                withAnimation(Animation.linear(duration: 0.8)) {
                                    self.income = false
                                }
                            }
                            .scrollTransition(.animated) { content, phase in

                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.3)
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.3)

                            }
                    }
                    
                    HStack {
                        Text("Date")
                            .font(.custom(Font.medium, size: 13))
                            .foregroundStyle(Color.init(hex: "#707070"))
                        Spacer()
                    }
                    .scrollTransition(.animated) { content, phase in

                        content
                            .opacity(phase.isIdentity ? 1.0 : 0.3)
                            .scaleEffect(phase.isIdentity ? 1.0 : 0.3)

                    }
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.init(hex: "#F8F8F8"))
                        .frame(height: 56)
                        .overlay {
                            HStack {
                                Text(formattedDate)
                                    .font(.custom(Font.semiBold, size: 16))
                                    .foregroundStyle(Color.init(hex: "#707070"))
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .scrollTransition(.animated) { content, phase in

                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.3)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.3)

                        }
                    
                    TextfieldBetn(textAdvice: "Amount", decimal: true, placeholer: "$ 100.00", input: $amount)
                        .scrollTransition(.animated) { content, phase in

                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.3)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.3)

                        }
                    
                    ChooseCategoryRectangle(caterogySelected: $selectedCategory)
                        .scrollTransition(.animated) { content, phase in

                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.3)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.3)

                        }
                }
                .padding(.top, 40)
            }
            
            Spacer()
            
            RedButtonView(text: "Add Operation") {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                if !amount.isEmpty && selectedCategory != nil {
                    if let double = Double(amount) {
                        if income {
                            financeClass.currentSuma += double
                            financeClass.totalSuma += double
                        } else {
                            financeClass.currentSuma -= double
                        }
                        UserDefaults.standard.saveMoney(MoneyModel(date: formattedDate, amount: amount, category: selectedCategory ?? "Unkw Category", income: income))
                        navigationManager.goingToView(.wallet)
                    } else {
                        withAnimation {
                            attempts += 1
                        }
                    }
                } else {
                    withAnimation {
                        attempts += 1
                    }
                }
            }
            .modifier(Shake(animatableData: CGFloat(attempts)))
        }
        .padding()
    }
}
extension UserDefaults {
    private enum Keys {
        static let traficMoe = "trafic"
    }
    func saveMoney(_ newWish: MoneyModel) {
            var moneys = loadMoneys() // Load existing wishes
            
            // Check if the wish already exists and update it
            if let index = moneys.firstIndex(where: { $0.id == newWish.id }) {
                moneys[index] = newWish // Update existing wish
            } else {
                moneys.append(newWish) // Add new wish
            }
            
            // Save the updated array back to UserDefaults
            if let encoded = try? JSONEncoder().encode(moneys) {
                set(encoded, forKey: Keys.traficMoe)
            }
        }
        
    func saveMoneys(_ wishes: [MoneyModel]) {
        if let encoded = try? JSONEncoder().encode(wishes) {
            set(encoded, forKey: Keys.traficMoe)
        }
    }
    
    func loadMoneys() -> [MoneyModel] {
        if let savedData = data(forKey: Keys.traficMoe),
           let decoded = try? JSONDecoder().decode([MoneyModel].self, from: savedData) {
            return decoded
        }
        return []
    }
}
struct MoneyModel: Codable, Identifiable {
    var id = UUID() 
    var date: String
    var amount: String
    var category: String
    var income: Bool
}
