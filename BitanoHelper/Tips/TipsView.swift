//
//  TipsView.swift
//  Mr. Betano Win Using Savings
//
//  Created by Pek Dkop on 26/10/2024.
//

import Foundation
import SwiftUI

struct TipsView: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject private var financeClass: FinanceClass
    @EnvironmentObject private var navigationManager: NavigationManager
    @State var pushNotificationAccepted: Bool = false
    @State var tips: [TipModel] = [.init(title: "Establish a Safety Net Fund", text: "Strive to set aside enough to cover 3-6 months of living expenses for emergencies like job loss or health issues."),.init(title: "Create a Budget and Monitor Your Expenses", text: "Develop a budget to manage your spending and make adjustments as needed. This approach helps you avoid overspending and allows for smarter purchase planning."),
                                   .init(title: "Resist Making Impulse Buys", text: "Before making a purchase, consider if it’s truly essential. Waiting a few days can help you decide if you genuinely need the item."),
                                   .init(title: "Utilize a system for income distribution.", text: "Try the 50/30/20 rule: 50% of income for essentials, 30% for entertainment and discretionary spending, 20% for savings and investments."),
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
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.init(hex: "#FE3B00"))
                .overlay {
                    Text("Note: Bitana is not a financial advisor, and it does not provide personalized financial advice. Instead, it offers general tips and tracking tools designed to support your financial journey.")
                        .font(.custom(Font.semiBold, size: 15))
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 100)
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
