//
//  NavigationManager.swift
//  Mr. Betano Win Using Savings
//
//  Created by Pek Dkop on 25/10/2024.
//

import Foundation
import SwiftUI


final class NavigationManager: ObservableObject {
    @Published var presentedView: ViewPresented = .loading
    @Published var fullScreenCoverSettings: Bool = false 
    @Published var shadowOnScreen: Bool = false
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            if UserDefaults.standard.value(forKey: "landingPassed") == nil {
                self.goingToView(.landing)
            } else {
                self.goingToView(.wallet)
            }
        }
    }
    func goingToView(_ view: ViewPresented) {
        if view == .wallet {
            UserDefaults.standard.setValue(true, forKey: "landingPassed")
        }
        withAnimation {
            self.presentedView = view 
        }
    }
}
