//
//  HabitStore.swift
//  HabitKit
//
//  Manages habit data and persistence
//

import Foundation
import SwiftUI

class HabitStore: ObservableObject {
    @Published var habits: [Habit] = []

    private let saveKey = "SavedHabits"

    init() {
        loadHabits()

        // Add sample data if empty
        if habits.isEmpty {
            addSampleHabits()
        }
    }

    func addHabit(_ habit: Habit) {
        habits.append(habit)
        saveHabits()
    }

    func updateHabit(_ habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index] = habit
            saveHabits()
        }
    }

    func deleteHabit(_ habit: Habit) {
        habits.removeAll { $0.id == habit.id }
        saveHabits()
    }

    func toggleCompletion(for habit: Habit, on date: Date) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].toggleCompletion(for: date)
            saveHabits()
        }
    }

    var activeHabits: [Habit] {
        habits.filter { !$0.isArchived }
    }

    var archivedHabits: [Habit] {
        habits.filter { $0.isArchived }
    }

    private func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    private func loadHabits() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
            habits = decoded
        }
    }

    private func addSampleHabits() {
        let gym = Habit(
            name: "Gym",
            description: "No Description",
            icon: "waveform.path.ecg",
            color: "purple",
            streakGoal: nil,
            completions: generateSampleCompletions(pattern: .regular)
        )

        let silence = Habit(
            name: "Silence October",
            description: "",
            icon: "dumbbell",
            color: "pink",
            streakGoal: nil,
            completions: generateSampleCompletions(pattern: .sparse)
        )

        habits = [gym, silence]
        saveHabits()
    }

    enum CompletionPattern {
        case regular, sparse
    }

    private func generateSampleCompletions(pattern: CompletionPattern) -> [Date] {
        let calendar = Calendar.current
        var completions: [Date] = []
        let today = Date()

        for daysAgo in 0..<120 {
            guard let date = calendar.date(byAdding: .day, value: -daysAgo, to: today) else { continue }

            let shouldAdd: Bool
            switch pattern {
            case .regular:
                // Regular pattern with some gaps
                shouldAdd = daysAgo % 7 < 5 && Int.random(in: 0...10) > 2
            case .sparse:
                // Sparse pattern
                shouldAdd = Int.random(in: 0...10) > 7
            }

            if shouldAdd {
                completions.append(date)
            }
        }

        return completions
    }
}
