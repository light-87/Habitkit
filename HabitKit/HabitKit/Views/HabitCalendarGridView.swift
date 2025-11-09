//
//  HabitCalendarGridView.swift
//  HabitKit
//
//  Year-view calendar grid for habits
//

import SwiftUI

struct HabitCalendarGridView: View {
    let habit: Habit
    private let columns = 53 // weeks in a year
    private let rows = 7 // days in a week

    var body: some View {
        GeometryReader { geometry in
            let cellSize = min((geometry.size.width - 40) / CGFloat(columns), 12)

            VStack(alignment: .leading, spacing: 4) {
                // Month labels
                HStack(spacing: 0) {
                    ForEach(monthPositions(), id: \.month) { position in
                        Text(monthName(position.month))
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                            .frame(width: cellSize * 4, alignment: .leading)
                            .offset(x: CGFloat(position.weekIndex) * cellSize)
                    }
                }
                .frame(height: 16)

                // Day labels and grid
                HStack(alignment: .top, spacing: 4) {
                    // Day labels
                    VStack(spacing: cellSize - 8) {
                        ForEach(["", "Tue", "", "Thu", "", "Sat", ""], id: \.self) { day in
                            Text(day)
                                .font(.system(size: 9))
                                .foregroundColor(.secondary)
                                .frame(height: cellSize)
                        }
                    }

                    // Calendar grid
                    HStack(spacing: 2) {
                        ForEach(0..<columns, id: \.self) { week in
                            VStack(spacing: 2) {
                                ForEach(0..<rows, id: \.self) { day in
                                    if let date = dateForCell(week: week, day: day) {
                                        Rectangle()
                                            .fill(habit.isCompletedOn(date: date) ? colorFromString(habit.color) : Color.gray.opacity(0.15))
                                            .frame(width: cellSize, height: cellSize)
                                            .cornerRadius(2)
                                    } else {
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(width: cellSize, height: cellSize)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .frame(height: 120)
    }

    private func dateForCell(week: Int, day: Int) -> Date? {
        let calendar = Calendar.current
        let today = Date()

        // Start from about 1 month before today, then show forward
        // This centers the view around the current month
        let weeksBeforeToday = 4  // Show 1 month of history
        let daysFromToday = -(weeksBeforeToday * 7) + (week * 7 + day)
        return calendar.date(byAdding: .day, value: daysFromToday, to: today)
    }

    private func monthPositions() -> [(month: Int, weekIndex: Int)] {
        let calendar = Calendar.current
        var positions: [(Int, Int)] = []
        var seenMonths: Set<Int> = []

        for week in 0..<columns {
            if let date = dateForCell(week: week, day: 0) {
                let month = calendar.component(.month, from: date)
                if !seenMonths.contains(month) {
                    positions.append((month, week))
                    seenMonths.insert(month)
                }
            }
        }

        return positions.reversed()
    }

    private func monthName(_ month: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.month = month
        if let date = calendar.date(from: components) {
            return formatter.string(from: date)
        }
        return ""
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
