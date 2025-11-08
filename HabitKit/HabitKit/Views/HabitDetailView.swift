//
//  HabitDetailView.swift
//  HabitKit
//
//  Detailed view of a single habit with calendar
//

import SwiftUI

struct HabitDetailView: View {
    @EnvironmentObject var habitStore: HabitStore
    @Environment(\.dismiss) var dismiss
    let habit: Habit

    @State private var selectedMonth = Date()

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }

                Spacer()

                VStack(spacing: 4) {
                    HStack(spacing: 8) {
                        Image(systemName: habit.icon)
                            .font(.system(size: 20))
                        Text(habit.name)
                            .font(.system(size: 20, weight: .semibold))
                    }

                    if !habit.description.isEmpty && habit.description != "No Description" {
                        Text(habit.description)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                Menu {
                    Button(action: {}) {
                        Label("Edit", systemImage: "pencil")
                    }
                    Button(action: {}) {
                        Label("Settings", systemImage: "gearshape")
                    }
                } label: {
                    Image(systemName: "gearshape")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground))

            ScrollView {
                VStack(spacing: 20) {
                    // Year overview
                    HabitCalendarGridView(habit: habit)
                        .padding()

                    // Stats
                    HStack(spacing: 20) {
                        StatBox(
                            title: "No Streak Goal",
                            icon: "target",
                            color: colorFromString(habit.color)
                        )

                        StatBox(
                            title: "\(habit.currentStreak)",
                            icon: "flame",
                            color: colorFromString(habit.color)
                        )
                    }
                    .padding(.horizontal)

                    // Monthly calendar
                    MonthlyCalendarView(habit: habit, selectedMonth: $selectedMonth)
                        .padding()
                }
            }
        }
        .navigationBarHidden(true)
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

struct StatBox: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)

            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
    }
}

struct MonthlyCalendarView: View {
    @EnvironmentObject var habitStore: HabitStore
    let habit: Habit
    @Binding var selectedMonth: Date

    private let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 7)

    var body: some View {
        VStack(spacing: 16) {
            // Month navigation
            HStack {
                Button(action: previousMonth) {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(monthYearString)
                    .font(.system(size: 18, weight: .semibold))

                Spacer()

                Button(action: nextMonth) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)

            // Days of week
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }

            // Calendar grid
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(daysInMonth(), id: \.self) { date in
                    if let date = date {
                        DayCell(
                            date: date,
                            habit: habit,
                            isToday: Calendar.current.isDateInToday(date)
                        )
                    } else {
                        Color.clear
                            .frame(height: 40)
                    }
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
    }

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: selectedMonth)
    }

    private func previousMonth() {
        if let newDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedMonth) {
            selectedMonth = newDate
        }
    }

    private func nextMonth() {
        if let newDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedMonth) {
            selectedMonth = newDate
        }
    }

    private func daysInMonth() -> [Date?] {
        let calendar = Calendar.current
        let interval = calendar.dateInterval(of: .month, for: selectedMonth)!
        let firstDay = interval.start

        var firstWeekday = calendar.component(.weekday, from: firstDay)
        // Convert Sunday = 1 to Monday = 0
        firstWeekday = (firstWeekday + 5) % 7

        let daysInMonth = calendar.range(of: .day, in: .month, for: selectedMonth)!.count

        var days: [Date?] = Array(repeating: nil, count: firstWeekday)

        for day in 0..<daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day, to: firstDay) {
                days.append(date)
            }
        }

        return days
    }
}

struct DayCell: View {
    @EnvironmentObject var habitStore: HabitStore
    let date: Date
    let habit: Habit
    let isToday: Bool

    var body: some View {
        Button(action: {
            habitStore.toggleCompletion(for: habit, on: date)
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(backgroundColor)
                    .frame(height: 40)

                if isToday {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 2)
                        .frame(height: 40)
                }

                Text("\(Calendar.current.component(.day, from: date))")
                    .font(.system(size: 16, weight: isCompleted ? .semibold : .regular))
                    .foregroundColor(textColor)

                if isCompleted {
                    VStack {
                        Spacer()
                        Circle()
                            .fill(colorFromString(habit.color))
                            .frame(width: 6, height: 6)
                            .offset(y: -6)
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var isCompleted: Bool {
        habit.isCompletedOn(date: date)
    }

    private var backgroundColor: Color {
        if isCompleted {
            return colorFromString(habit.color).opacity(0.2)
        }
        return Color(UIColor.systemGray6)
    }

    private var textColor: Color {
        if Calendar.current.compare(date, to: Date(), toGranularity: .month) != .orderedSame {
            return .secondary
        }
        return .primary
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
    NavigationView {
        HabitDetailView(habit: Habit(
            name: "Gym",
            description: "No Description",
            icon: "waveform.path.ecg",
            color: "purple",
            completions: []
        ))
    }
    .environmentObject(HabitStore())
}
