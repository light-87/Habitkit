//
//  SettingsView.swift
//  HabitKit
//
//  Settings and configuration screen
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Pro subscription banner
                    NavigationLink(destination: ProFeaturesView()) {
                        HStack(spacing: 16) {
                            Image(systemName: "square.grid.3x3")
                                .font(.system(size: 24))
                                .foregroundColor(Color(hex: "9b59d0"))
                                .frame(width: 50, height: 50)
                                .background(
                                    LinearGradient(
                                        colors: [Color(hex: "9b59d0").opacity(0.2), Color(hex: "d946ef").opacity(0.2)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .cornerRadius(12)

                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text("Subscribe to ")
                                        .font(.system(size: 17))
                                        .foregroundColor(.primary)
                                    + Text("Habit")
                                        .font(.system(size: 17))
                                        .foregroundColor(.primary)
                                    + Text("Kit")
                                        .font(.system(size: 17))
                                        .foregroundColor(Color(hex: "9b59d0"))
                                    + Text(" Pro")
                                        .font(.system(size: 17))
                                        .foregroundColor(.primary)
                                }

                                Text("Unlimited habits, import/export data, ...")
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal)

                    // App section
                    VStack(alignment: .leading, spacing: 0) {
                        Text("App")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                            .padding(.bottom, 12)

                        VStack(spacing: 0) {
                            SettingsRow(icon: "gearshape", iconColor: Color(hex: "d946ef"), title: "General")
                            Divider().padding(.leading, 70)
                            SettingsRow(icon: "bell", iconColor: Color(hex: "06b6d4"), title: "Daily Check-In Reminders")
                            Divider().padding(.leading, 70)
                            SettingsRow(icon: "paintbrush", iconColor: Color(hex: "f97316"), title: "Theme")
                            Divider().padding(.leading, 70)
                            SettingsRow(icon: "archivebox", iconColor: Color(hex: "10b981"), title: "Archived Habits")
                            Divider().padding(.leading, 70)
                            SettingsRow(icon: "square.and.arrow.down", iconColor: Color(hex: "6366f1"), title: "Data Import/Export")
                            Divider().padding(.leading, 70)
                            SettingsRow(icon: "list.bullet", iconColor: Color(hex: "ef4444"), title: "Reorder Habits")
                        }
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 8)
                        .padding(.horizontal)
                    }

                    // Help section
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Help")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                            .padding(.bottom, 12)

                        VStack(spacing: 0) {
                            SettingsRow(icon: "figure.wave", iconColor: Color(hex: "f97316"), title: "Show Onboarding")
                            Divider().padding(.leading, 70)
                            SettingsRow(icon: "newspaper", iconColor: Color(hex: "3b82f6"), title: "Show What's New")
                            Divider().padding(.leading, 70)
                            SettingsRow(icon: "paperplane", iconColor: .black, title: "Send feedback")
                        }
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 8)
                        .padding(.horizontal)
                    }

                    // About section
                    VStack(alignment: .leading, spacing: 0) {
                        Text("About")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                            .padding(.bottom, 12)

                        VStack(spacing: 0) {
                            SettingsRow(icon: "globe", iconColor: Color(hex: "10b981"), title: "Website")
                            Divider().padding(.leading, 70)
                            SettingsRow(icon: "xlogo", iconColor: Color(hex: "3b82f6"), title: "Follow on X")
                        }
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 8)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical, 20)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Settings")
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
}

struct SettingsRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    var destination: AnyView?

    var body: some View {
        Button(action: {}) {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(iconColor)
                        .frame(width: 36, height: 36)

                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                }

                Text(title)
                    .font(.system(size: 17))
                    .foregroundColor(.primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ProFeaturesView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Unlock ")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)
                + Text("Habit")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)
                + Text("Kit")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(hex: "9b59d0"))
                + Text(" Pro")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)

                VStack(spacing: 16) {
                    ProFeatureRow(icon: "number", color: Color(hex: "10b981"), title: "Unlimited number of habits", description: "Unlimited possibilities by creating as many habits as you like")
                    ProFeatureRow(icon: "square.grid.3x3", color: Color(hex: "3b82f6"), title: "Home Screen Widgets", description: "Show your favorite habits on your home screen")
                    ProFeatureRow(icon: "bell.badge", color: Color(hex: "ef4444"), title: "Multiple Reminders", description: "Add up to three reminders for the same habit")
                    ProFeatureRow(icon: "chart.line.uptrend.xyaxis", color: Color(hex: "f59e0b"), title: "Charts & Statistics", description: "See charts and statistics about your consistency")
                    ProFeatureRow(icon: "square.grid.3x2", color: Color(hex: "06b6d4"), title: "Dashboard Customization", description: "Show streaks and goals, show labels and categories")
                    ProFeatureRow(icon: "list.bullet.rectangle", color: Color(hex: "06b6d4"), title: "Compact List", description: "Configure the amount of days to display and the visibility of the habit names in the compact list")
                    ProFeatureRow(icon: "square.and.arrow.up", color: Color(hex: "6366f1"), title: "Export your data", description: "Generate a file from your habits and completions")
                    ProFeatureRow(icon: "square.and.arrow.down", color: Color(hex: "ef4444"), title: "Import your data", description: "Switching phones? Restore a previously exported backup")
                    ProFeatureRow(icon: "archivebox", color: Color(hex: "f97316"), title: "Restore archived habits", description: "Pausing a specific habit? Just archive it and continue later")
                    ProFeatureRow(icon: "star", color: Color(hex: "a855f7"), title: "Support an Indie Developer", description: "Your purchase supports an independent app developer")
                }
                .padding()

                Button(action: {}) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color(hex: "9b59d0"))
                        .cornerRadius(16)
                }
                .padding()
            }
            .padding(.top, 20)
        }
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

struct ProFeatureRow: View {
    let icon: String
    let color: Color
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(color)
                    .frame(width: 44, height: 44)

                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(color)

                Text(description)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(ThemeManager())
}
