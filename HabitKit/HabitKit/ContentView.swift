//
//  ContentView.swift
//  HabitKit
//
//  Main container view with tab navigation
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var showingSettings = false

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                }
                .tag(0)

            ListView()
                .tabItem {
                    Image(systemName: "checkmark.square")
                }
                .tag(1)

            CompactListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                }
                .tag(2)
        }
        .accentColor(Color("AccentPurple"))
    }
}

#Preview {
    ContentView()
        .environmentObject(HabitStore())
        .environmentObject(ThemeManager())
}
