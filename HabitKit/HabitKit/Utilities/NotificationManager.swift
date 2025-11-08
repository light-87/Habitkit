//
//  NotificationManager.swift
//  HabitKit
//
//  Manages local notifications for habit reminders
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }

    func scheduleReminder(for habit: Habit, reminder: HabitReminder) {
        guard reminder.isEnabled else { return }

        let content = UNMutableNotificationContent()
        content.title = "Time to check in!"
        content.body = "Don't forget to complete your \(habit.name) habit"
        content.sound = .default

        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: reminder.time)

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let identifier = reminder.id.uuidString
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }

    func cancelReminder(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }

    func cancelAllReminders(for habit: Habit) {
        let identifiers = habit.reminders.map { $0.id.uuidString }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}
