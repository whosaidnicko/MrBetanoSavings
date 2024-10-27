//
//  TipsView.swift
//  Mr. Betano Win Using Savings
//
//  Created by Nicolae Chivriga on 26/10/2024.
//

import Foundation
import SwiftUI

struct TipsView: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject private var financeClass: FinanceClass
    @EnvironmentObject private var navigationManager: NavigationManager
    @State var pushNotificationAccepted: Bool = false
    @State var tips: [TipModel] = [.init(title: "Build an Emergency Fund", text: "Aim to save 3-6 months' worth of expenses for unexpected situations like job loss or illness."),.init(title: "Plan a Budget and Track Your Spending", text: "Create a budget to control where your money is going and adjust it as needed. This helps avoid unnecessary expenses and better plan your purchases."),
                                   .init(title: "Avoid Impulse Purchases", text: "Before buying something, ask yourself if it's really necessary. Often it's better to wait a few days to evaluate if you really need the item."),
                                   .init(title: "Use an Income Allocation System", text: "Try the 50/30/20 rule: 50% of income for essentials, 30% for entertainment and discretionary spending, 20% for savings and investments."),
                                   .init(title: "Regularly Save for Retirement", text: "The earlier you start contributing to a retirement account, the more opportunities you have to accumulate wealth through compound interest.")]
    var body: some View {
        VStack {
            HStack {
                Text("Tips")
                    .font(.custom(Font.bold, size: 20))
                    .foregroundStyle(Color.init(hex: "#111111"))
                
                Spacer()
                Button(action: {
                    navigationManager.fullScreenCoverSettings = true
                }, label: {
                    Image("settingsBtn")
                })
            }
            
            if !pushNotificationAccepted {
                Button(action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }, label: {
                    redButtonPushAlert()
                })
            }
            
            ScrollView {
                ForEach(tips.indices, id: \.self) { index in
                    TipRectangleView(tipModel: tips[index], animationAppearing: Double(index) / 4)
                        .scrollTransition(.animated) { content, phase in

                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.3)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.3)

                        }
                }
            }
        }
        .padding()
        .onChange(of: scenePhase) { scene in
            checkNotificationAuthorizationStatus()
            
        }
        .onAppear() {
            checkNotificationAuthorizationStatus()
        }
    }
    func checkNotificationAuthorizationStatus() {
           UNUserNotificationCenter.current().getNotificationSettings { settings in
               DispatchQueue.main.async {
                   if  settings.authorizationStatus == .authorized {
                       
                       self.pushNotificationAccepted = true
                   } else if settings.authorizationStatus == .denied {
                       
                       self.pushNotificationAccepted = false
                   }
               }
           }
       }
    
    func redButtonPushAlert() -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.init(hex: "#FE3B00"))
            .overlay {
                Text("Turn on notifications in the settings to receive new tips")
                    .font(.custom(Font.semiBold, size: 15))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(height: 60)
    }
}
