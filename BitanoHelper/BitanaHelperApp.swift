//
//  BitanaHelperApp.swift
//  Bitana Helper
//
//  Created by Pen Ke on 25/10/2024.
//

import SwiftUI

@main
struct BitanoHelperApp: App {
    @StateObject private var navigatonManager: NavigationManager = NavigationManager()
    @StateObject private var  financeClass: FinanceClass = FinanceClass()
    var body: some Scene {
        WindowGroup {
                WaiterView()
                .environmentObject(self.navigatonManager)
                .environmentObject(financeClass)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        }
    }
}
