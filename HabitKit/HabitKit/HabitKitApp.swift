//
//  HabitKitApp.swift
//  HabitKit
//
//  Created by HabitKit Team
//

import SwiftUI

@main
struct HabitKitApp: App {
    @StateObject private var habitStore = HabitStore()
    @StateObject private var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(habitStore)
                .environmentObject(themeManager)
        }
    }
}
