//
//  FinanceClass.swift
//  Bitana Helper
//
//  Created by Pen Ke on 25/10/2024.
//

import Foundation
import SwiftUI

final class FinanceClass: ObservableObject {
    @AppStorage("sum") var currentSuma: Double = 0
    @AppStorage("totalSuma") var totalSuma: Double = 0
    @AppStorage("wish") var wish: String?
    @AppStorage("destinationSuma") var destinationSuma: Double?
    @Published var animableSuma: Double = 0
   
}
