//
//  CompactListView.swift
//  HabitKit
//
//  Compact list view
//

import SwiftUI

struct CompactListView: View {
    @EnvironmentObject var habitStore: HabitStore

    var body: some View {
        NavigationView {
            List {
                ForEach(habitStore.activeHabits) { habit in
                    CompactHabitRow(habit: habit)
                }
            }
            .navigationTitle("Compact View")
        }
    }
}

struct CompactHabitRow: View {
    @EnvironmentObject var habitStore: HabitStore
    let habit: Habit

    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                habitStore.toggleCompletion(for: habit, on: Date())
            }) {
                Image(systemName: habit.isCompletedOn(date: Date()) ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(habit.isCompletedOn(date: Date()) ? colorFromString(habit.color) : .gray)
                    .font(.system(size: 24))
            }
            .buttonStyle(PlainButtonStyle())

            Text(habit.name)
                .font(.system(size: 16))

            Spacer()

            Text("\(habit.currentStreak)")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
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
    CompactListView()
        .environmentObject(HabitStore())
}
