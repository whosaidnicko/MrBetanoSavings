//
//  TabBarView.swift
//  Mr. Betano Win Using Savings
//
//  Created by Pek Dkop on 25/10/2024.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    var body: some View {
        
        HStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .frame(width: 114, height: 36)
                .overlay(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 24)
                    .fill(Color.init(hex: "#FE3B00"))
                    .frame(width: 114 * (navigationManager.presentedView == .wallet ? 1 : 0))
                    
                    HStack(spacing: 8.67) {
                        Image("wallet")
                            .foregroundStyle(navigationManager.presentedView == .wallet ? .white : Color.init(hex: "#707070"))
                            .rotationEffect(.degrees(navigationManager.presentedView == .wallet ? 360 : 0))
                            .offset(x: navigationManager.presentedView != .wallet ? 10 : 0)
//                            .scaleEffect(navigationManager.presentedView == .wallet  ? 1 : 0)
                        
                        Text("Wallet")
                            .font(.custom(Font.semiBold, size: 15))
                            .foregroundStyle(navigationManager.presentedView == .wallet ? .white : Color.init(hex: "#707070"))
                            .scaleEffect(navigationManager.presentedView == .wallet  ? 1 : 0)
                            .animation(Animation.linear.delay(navigationManager.presentedView == .wallet ? 0.3 : 0), value: navigationManager.presentedView)
                    }
                }
                .animation(Animation.linear, value: navigationManager.presentedView)
                .onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    self.navigationManager.presentedView = .wallet
                }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .frame(width: 114, height: 36)
                .overlay(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 24)
                    .fill(Color.init(hex: "#FE3B00"))
                    .frame(width: 114 * (navigationManager.presentedView == .tips ? 1 : 0))
                    HStack(spacing: 8.67) {
                        Image("tips")
                            .foregroundStyle(navigationManager.presentedView == .tips ? .white : Color.init(hex: "#707070"))
                            .rotationEffect(.degrees(navigationManager.presentedView == .tips ? 360 : 0))
                            .offset(x: navigationManager.presentedView != .tips ? -10 : 0)
//                            .scaleEffect(navigationManager.presentedView == .tips  ? 1 : 0)
                        
                        Text("Tips")
                            .font(.custom(Font.semiBold, size: 15))
                            .foregroundStyle(navigationManager.presentedView == .tips ? .white : Color.init(hex: "#707070"))
                            .scaleEffect(navigationManager.presentedView == .tips  ? 1 : 0)
                            .animation(Animation.linear.delay(navigationManager.presentedView == .tips ? 0.3 : 0), value: navigationManager.presentedView)
                    }
                }
                .animation(Animation.linear, value: navigationManager.presentedView)
            
                .onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    self.navigationManager.presentedView = .tips
                }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .frame(width: 114, height: 36)
                .overlay(alignment: .trailing) {
                    RoundedRectangle(cornerRadius: 24)
                    .fill(Color.init(hex: "#FE3B00") )
                    .frame(width: 114 * (navigationManager.presentedView == .history ? 1 : 0))
                    HStack(spacing: 8.67) {
                        Image("history")
                            .foregroundStyle(navigationManager.presentedView == .history ? .white : Color.init(hex: "#707070"))
                            .rotationEffect(.degrees(navigationManager.presentedView == .history ? 360 : 0))
//                            .scaleEffect(navigationManager.presentedView == .history  ? 1 : 0)
                        
                        Text("Analytics")
                            .font(.custom(Font.semiBold, size: 15))
                            .foregroundStyle(navigationManager.presentedView == .history ? .white : Color.init(hex: "#707070"))
                            .scaleEffect(navigationManager.presentedView == .history  ? 1 : 0)
                            .animation(Animation.linear.delay(navigationManager.presentedView == .history ? 0.3 : 0), value: navigationManager.presentedView)
                    }
                }
             
                .animation(Animation.linear, value: navigationManager.presentedView)
                .onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    self.navigationManager.presentedView = .history
                }
        }
        .padding(.horizontal)
        .frame(height: 78)
        .background(Color.init(hex: "#F8F8F8"))
        
        
    }
}
