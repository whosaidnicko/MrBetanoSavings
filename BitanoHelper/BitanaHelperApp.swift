//
//  Mr__Betano_Win_Using_SavingsApp.swift
//  Mr. Betano Win Using Savings
//
//  Created by Pek Dkopa on 25/10/2024.
//

import SwiftUI

@main
struct BitanoHelper: App {
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
