//
//  WalletView.swift
//  Mr. Betano Win Using Savings
//
//  Created by Pek Dkop on 25/10/2024.
//

import Foundation
import SwiftUI

struct WalletView: View {
    @EnvironmentObject private var financeClass: FinanceClass
    @EnvironmentObject private var navigationManager: NavigationManager
    @State var operations: [MoneyModel] = []
    private var formatter: NumberFormatter {
       let formatter = NumberFormatter()
       formatter.numberStyle = .currency
       formatter.locale = Locale(identifier: "en_US")
       return formatter
    }
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack(spacing: 1) {
                        Text("Bitano")
                            .foregroundStyle(Color.init(hex: "#FE3B00"))
                            .font(.custom(Font.bold, size: 20))
                        
                        Text("Helper")
                            .font(.custom(Font.bold, size: 20))
                            .foregroundStyle(Color.init(hex: "#111111"))
                    }
                    
                    Text("Using Savings")
                        .font(.custom(Font.medium, size: 16))
                        .foregroundStyle(Color.init(hex: "#707070"))
                }
                Spacer()
                
                Button(action: {
                    navigationManager.fullScreenCoverSettings = true
                }, label: {
                    Image("settingsBtn")
                })
                
            }
            
            ScrollView(showsIndicators: false ) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Your Balance")
                            .font(.custom(Font.semiBold, size: 16))
                            .foregroundStyle(Color.init(hex: "#111111"))
                        
                        TextAnimatableValue(value: financeClass.animableSuma, formatter: formatter)
                            .font(.custom(Font.bold, size: 36))
                            .foregroundStyle(Color.init(hex: "#FE3B00"))
                        
                        HStack {
                            TextAnimatableValue(value: financeClass.totalSuma, formatter: formatter)
                                .font(.custom(Font.semiBold, size: 12))
                                .foregroundStyle(Color.init(hex: "#999999"))
                            
                            Text("/ mo")
                                .font(.custom(Font.semiBold, size: 12))
                                .foregroundStyle(Color.init(hex: "#999999"))
                        }
                        .offset(x: 10)
                    }
                    Spacer()
                    
                    Button(action: {
                        navigationManager.goingToView(.addOperation)
                    }, label: {
                        Image("pliusui")
                    })
                    
                }
                .padding(.top)
                
                HStack {
                    Text("Target")
                        .font(.custom(Font.semiBold, size: 16))
                        .foregroundStyle(Color.init(hex: "#111111"))
                    
                    Spacer()
                    
                    Button(action: {
                        navigationManager.goingToView(.addWish)
                    }, label: {
                        changeTargetView()
                    })
                }
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.init(hex: "#F8F8F8"))
                    .frame(height: 81)
                    .overlay {
                        VStack {
                            HStack {
                                Text(self.financeClass.wish ?? "No Target")
                                    .font(.custom(Font.semiBold, size: 16))
                                    .foregroundStyle(Color.init(hex: "#111111"))
                                Spacer()
                                if financeClass.wish != nil && financeClass.destinationSuma != nil  {
                                    Text("\(String(format: "%.2f", (financeClass.currentSuma / financeClass.destinationSuma!) * 100))%")
                                        .font(.custom(Font.semiBold, size: 12))
                                        .foregroundStyle(Color.init(hex: "#999999"))
                                        .animation(Animation.easeInOut(duration: 3), value: financeClass.currentSuma)
                                }
                                
                                
                            }
                            Spacer()
                            GeometryReader { geo in
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.init(hex: "#EBEBEB"))
                                    .frame(width: geo.size.width, height: 6)
                                    .overlay(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 3)
                                            .fill(financeClass.destinationSuma != nil ? (financeClass.currentSuma / financeClass.destinationSuma! >= 1 ? Color.green :  Color.init(hex: "#FE3B00")) : Color.init(hex: "#FE3B00"))
                                            .frame(width: geo.size.width * ( financeClass.destinationSuma != nil ? (financeClass.currentSuma / financeClass.destinationSuma! > 1 ? 1 : financeClass.currentSuma / financeClass.destinationSuma!) : 0 ))
                                            .animation(Animation.easeInOut(duration: 3), value: financeClass.currentSuma)
                                    }
                            }
                            
                            Spacer()
                            
                            HStack {
                                Spacer()
                                if self.financeClass.destinationSuma != nil && financeClass.wish != nil {
                                    Text("\(formatter.string(for: financeClass.currentSuma) ?? "") / \(formatter.string(for: financeClass.destinationSuma) ?? "")")
                                        .font(.custom(Font.semiBold, size: 13))
                                        .foregroundStyle(Color.init(hex: "#111111"))
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }
                HStack {
                    Text("Operations this week")
                        .font(.custom(Font.semiBold, size: 16))
                        .foregroundStyle(Color.init(hex: "#111111"))
                    Spacer()
                }
                .padding(.top)
                
                if operations.isEmpty {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.init(hex: "#FE3B00"))
                        .frame(width: 140, height: 32)
                        .overlay {
                            Text("+ Add Operation")
                                .font(.custom(Font.bold, size: 14))
                                .foregroundStyle(Color.white)
                        }
                        .onTapGesture {
                            navigationManager.goingToView(.addOperation)
                        }
                }
                
                ForEach(operations.indices, id: \.self) { index in
                    OperationsHistoryRectangleView(moneyModel: operations[index], secondsRemaining: Double(index) / 4)
                        .scrollTransition(.animated) { content, phase in
                            
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.3)
                                .blur(radius: phase.isIdentity ? 0 : 2.5)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.3)
                            
                        }
                    
                }
                Spacer()
            }
        }
        .padding(.horizontal)
        .onAppear {
            operations = UserDefaults.standard.loadMoneys()
            withAnimation(Animation.linear(duration: 1.5))  {
//                self.financeClass.wish = "Hey"
//                self.financeClass.destinationSuma = 4000
                self.financeClass.animableSuma = financeClass.currentSuma
            }
        }
    }
    
    func changeTargetView() -> some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(Color.init(hex: "#EBEBEB"))
            .overlay {
                Text(financeClass.wish == nil ? "Add Target" : "Change Target")
                    .font(.custom(Font.semiBold, size: 14))
                    .foregroundStyle(Color.init(hex: "#707070"))
            }
            .frame(width: 123, height: 32)
    }
}

