//
//  WaiterView.swift
//  Mr. Betano Win Using Savings
//
//  Created by Pek Dkop on 25/10/2024.
//

import Foundation
import SwiftUI


struct WaiterView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    
    var body: some View {
        ZStack {
            if  navigationManager.presentedView == .landing || navigationManager.presentedView == .loading {
                Image("backgroundLandaing")
                    .resizable()
                    .ignoresSafeArea()
            } else {
                Color.init(hex: "#FDD4D4")
                    .ignoresSafeArea()
            }
            
            VStack {
                Group {
                    switch self.navigationManager.presentedView {
                    case .loading:
                        CirclesLoadingView()
                    case .landing:
                        LandingView()
                    case .wallet:
                        WalletView()
                    case .tips:
                        TipsView()
                    case .history:
                        HistoryView()
                    case .addWish:
                        ChangeTargetView()
                 
                    case .addOperation:
                        AddOperationView()
                    }
                }
                .transition(.scale)
                
                if navigationManager.presentedView != .landing && navigationManager.presentedView != .loading && navigationManager.presentedView != .addWish && navigationManager.presentedView != .addOperation  {
                    Spacer()
                    
                    TabBarView()
                        .onAppear(){
                            navigationManager.shadowOnScreen = true
                        }
                      
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .fullScreenCover(isPresented: $navigationManager.fullScreenCoverSettings, content: {
            SettingsView()
        })
    }
}
