//
//  ListView.swift
//  HabitKit
//
//  Simple list view of habits
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var habitStore: HabitStore

    var body: some View {
        NavigationView {
            List {
                ForEach(habitStore.activeHabits) { habit in
                    NavigationLink(destination: HabitDetailView(habit: habit)) {
                        HabitRowView(habit: habit)
                    }
                }
            }
            .navigationTitle("Habits")
        }
    }
}

struct HabitRowView: View {
    let habit: Habit

    var body: some View {
        HStack {
            Image(systemName: habit.icon)
                .foregroundColor(colorFromString(habit.color))
            Text(habit.name)
            Spacer()
            if habit.isCompletedOn(date: Date()) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(colorFromString(habit.color))
            }
        }
    }

    private func colorFromString(_ colorString: String) -> Color {
        switch colorString.lowercased() {
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "teal": return .teal
        case "blue": return .blue
        case "purple": return Color(hex: "9b59d0")
        case "pink": return .pink
        case "gray": return .gray
        default: return Color(hex: "9b59d0")
        }
    }
}

#Preview {
    ListView()
        .environmentObject(HabitStore())
}
