//
//  NewHabitView.swift
//  HabitKit
//
//  Screen for creating new habits
//

import SwiftUI

struct NewHabitView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var habitStore: HabitStore

    @State private var name = ""
    @State private var description = ""
    @State private var selectedIcon = "waveform.path.ecg"
    @State private var selectedColor = "purple"
    @State private var showingAdvancedOptions = false

    let icons = [
        "creditcard", "xmark", "leaf", "face.smiling", "camera", "tag", "dollarsign", "triangle",
        "cup.and.saucer", "carrot", "mug", "photo", "wrench", "frame", "trash",
        "waveform.path.ecg", "figure.run", "dumbbell", "figure.yoga", "drop", "lightbulb",
        "basketball", "baseball", "fork.knife", "book", "phone", "envelope",
        "paintbrush", "bell", "heart", "star", "music.note", "gamecontroller"
    ]

    let colors = [
        "red", "orange", "orange", "yellow", "green", "teal", "teal",
        "teal", "blue", "blue", "blue", "purple", "purple",
        "pink", "pink", "red", "gray", "gray", "gray", "brown"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Icon picker
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 120, height: 120)
                                .shadow(color: Color.black.opacity(0.1), radius: 10)

                            Image(systemName: selectedIcon)
                                .font(.system(size: 48))
                                .foregroundColor(.black)
                        }

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 12), spacing: 12) {
                            ForEach(icons, id: \.self) { icon in
                                Button(action: { selectedIcon = icon }) {
                                    Image(systemName: icon)
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .frame(width: 24, height: 24)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 20)

                    // Name field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name")
                            .font(.system(size: 16, weight: .medium))
                        TextField("", text: $name)
                            .textFieldStyle(RoundedTextFieldStyle())
                    }
                    .padding(.horizontal)

                    // Description field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.system(size: 16, weight: .medium))
                        TextField("", text: $description)
                            .textFieldStyle(RoundedTextFieldStyle())
                    }
                    .padding(.horizontal)

                    // Color picker
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Color")
                            .font(.system(size: 16, weight: .medium))
                            .padding(.horizontal)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 7), spacing: 16) {
                            ForEach(["red", "orange", "orange", "yellow", "green", "teal", "teal",
                                     "teal", "blue", "blue", "blue", "purple", "purple",
                                     "pink", "pink", "red", "gray", "gray", "gray", "brown"], id: \.self) { color in
                                Button(action: { selectedColor = color }) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(colorFromString(color))
                                        .frame(height: 45)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(selectedColor == color ? Color.primary : Color.clear, lineWidth: 3)
                                        )
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Advanced options
                    Button(action: { showingAdvancedOptions.toggle() }) {
                        HStack {
                            Text("Advanced Options")
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                            Image(systemName: showingAdvancedOptions ? "chevron.up" : "chevron.down")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 8)

                    if showingAdvancedOptions {
                        VStack(spacing: 16) {
                            // Placeholder for advanced options
                            Text("Advanced options coming soon")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                        .padding()
                    }

                    // Save button
                    Button(action: saveHabit) {
                        Text("Save")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color(hex: "9b59d0"))
                            .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }

    private func saveHabit() {
        let newHabit = Habit(
            name: name.isEmpty ? "New Habit" : name,
            description: description,
            icon: selectedIcon,
            color: selectedColor
        )
        habitStore.addHabit(newHabit)
        dismiss()
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
        case "brown": return .brown
        case "gray": return .gray
        default: return Color(hex: "9b59d0")
        }
    }
}

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
    }
}

#Preview {
    NewHabitView()
        .environmentObject(HabitStore())
}
