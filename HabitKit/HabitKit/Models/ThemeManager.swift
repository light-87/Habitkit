//
//  ThemeManager.swift
//  HabitKit
//
//  Manages app theme and appearance
//

import Foundation
import SwiftUI

class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme = .system

    enum AppTheme: String, CaseIterable {
        case light = "Light"
        case dark = "Dark"
        case system = "System"

        var colorScheme: ColorScheme? {
            switch self {
            case .light: return .light
            case .dark: return .dark
            case .system: return nil
            }
        }
    }
}
