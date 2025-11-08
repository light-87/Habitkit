//
//  Habit.swift
//  HabitKit
//
//  Data model for habits
//

import Foundation
import SwiftUI

struct Habit: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var icon: String
    var color: String
    var category: String?
    var streakGoal: Int?
    var completions: [Date] = []
    var reminders: [HabitReminder] = []
    var createdDate: Date = Date()
    var isArchived: Bool = false

    var currentStreak: Int {
        calculateStreak()
    }

    func isCompletedOn(date: Date) -> Bool {
        completions.contains { Calendar.current.isDate($0, inSameDayAs: date) }
    }

    mutating func toggleCompletion(for date: Date) {
        if let index = completions.firstIndex(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
            completions.remove(at: index)
        } else {
            completions.append(date)
        }
        completions.sort(by: >)
    }

    private func calculateStreak() -> Int {
        let calendar = Calendar.current
        let sortedCompletions = completions.sorted(by: >)

        guard !sortedCompletions.isEmpty else { return 0 }

        var streak = 0
        var currentDate = calendar.startOfDay(for: Date())

        for completion in sortedCompletions {
            let completionDate = calendar.startOfDay(for: completion)

            if calendar.isDate(completionDate, inSameDayAs: currentDate) {
                streak += 1
                currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
            } else if completionDate < currentDate {
                break
            }
        }

        return streak
    }
}

struct HabitReminder: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var time: Date
    var isEnabled: Bool = true
    var notificationId: String?
}

enum HabitColor: String, CaseIterable {
    case red = "red"
    case orange = "orange"
    case yellow = "yellow"
    case green = "green"
    case teal = "teal"
    case blue = "blue"
    case purple = "purple"
    case pink = "pink"
    case gray = "gray"

    var color: Color {
        switch self {
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .green: return .green
        case .teal: return .teal
        case .blue: return .blue
        case .purple: return .purple
        case .pink: return .pink
        case .gray: return .gray
        }
    }
}
