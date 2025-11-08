//
//  DashboardView.swift
//  HabitKit
//
//  Main dashboard with habit cards
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var habitStore: HabitStore
    @State private var showingNewHabit = false
    @State private var showingSettings = false
    @State private var selectedCategory: String? = nil

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header
                    HStack {
                        Text("Habit")
                            .font(.system(size: 28, weight: .bold))
                        + Text("Kit")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(hex: "9b59d0"))

                        Spacer()

                        Button(action: {}) {
                            Text("PRO")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.primary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.primary, lineWidth: 2)
                                )
                        }

                        Button(action: {}) {
                            Image(systemName: "chart.bar")
                                .font(.system(size: 22))
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal, 4)

                        Button(action: { showingNewHabit = true }) {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 26))
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    // Category filter
                    if let category = selectedCategory {
                        HStack {
                            Image(systemName: "graduationcap")
                                .font(.system(size: 14))
                            Text(category)
                                .font(.system(size: 15))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }

                    // Habits list
                    ForEach(habitStore.activeHabits) { habit in
                        NavigationLink(destination: HabitDetailView(habit: habit)) {
                            HabitCardView(habit: habit)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.bottom, 20)
            }
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingSettings = true }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.primary)
                    }
                }
            }
            .sheet(isPresented: $showingNewHabit) {
                NewHabitView()
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
    }
}

struct HabitCardView: View {
    @EnvironmentObject var habitStore: HabitStore
    let habit: Habit
    @State private var isCompleted = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(colorFromString(habit.color).opacity(0.2))
                        .frame(width: 50, height: 50)

                    Image(systemName: habit.icon)
                        .font(.system(size: 24))
                        .foregroundColor(colorFromString(habit.color))
                }

                // Name
                VStack(alignment: .leading, spacing: 4) {
                    Text(habit.name)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)

                    if !habit.description.isEmpty && habit.description != "No Description" {
                        Text(habit.description)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                // Check button
                Button(action: {
                    habitStore.toggleCompletion(for: habit, on: Date())
                    isCompleted.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(habit.isCompletedOn(date: Date()) ? colorFromString(habit.color) : Color.gray.opacity(0.1))
                            .frame(width: 50, height: 50)

                        if habit.isCompletedOn(date: Date()) {
                            Image(systemName: "checkmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }

            // Completion calendar
            HabitCalendarGridView(habit: habit)
                .padding(.top, 8)

            // Streak info
            HStack {
                if let goal = habit.streakGoal {
                    Label("\(goal)", systemImage: "target")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                } else {
                    Text("No Streak Goal")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }

                Spacer()

                Label("\(habit.currentStreak)", systemName: "flame")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
        }
        .padding(16)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        .padding(.horizontal)
        .onAppear {
            isCompleted = habit.isCompletedOn(date: Date())
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
    DashboardView()
        .environmentObject(HabitStore())
        .environmentObject(ThemeManager())
}
