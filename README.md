# HabitKit 📱

A beautiful, intuitive iOS habit tracking app built with SwiftUI. Track your daily habits, build streaks, and transform your routines into lasting change.

![iOS](https://img.shields.io/badge/iOS-15.0+-blue)
![Swift](https://img.shields.io/badge/Swift-5.0-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0-green)
![Xcode](https://img.shields.io/badge/Xcode-14.0+-blue)

## Features

### 🎯 Core Features
- **Create Unlimited Habits** - Track as many habits as you want
- **Beautiful Calendar Views** - Visualize your consistency with year-at-a-glance calendar grids
- **Streak Tracking** - Monitor your current streak for each habit
- **Custom Icons & Colors** - Personalize each habit with unique icons and color themes
- **Multiple View Modes** - Switch between grid, list, and compact views

### 📊 Progress Tracking
- **Visual Calendar Grid** - GitHub-style contribution graph for each habit
- **Monthly Calendar View** - Detailed monthly view with completion tracking
- **Streak Goals** - Set and track your streak targets
- **Completion History** - Full history of all your habit completions

### ⚙️ Customization
- **Theme Support** - Light and dark mode support
- **Color Picker** - Choose from a variety of colors for each habit
- **Icon Library** - Extensive selection of SF Symbols icons
- **Category Organization** - Organize habits by category

### 🔔 Reminders & Notifications
- **Daily Check-In Reminders** - Get notified to complete your habits
- **Multiple Reminders** - Set up to three reminders per habit (Pro feature)
- **Local Notifications** - All notifications handled on-device

### 💾 Data Management
- **Local Storage** - All data stored securely on your device using UserDefaults
- **Import/Export** - Backup and restore your habit data
- **Archive Habits** - Pause habits without losing your history
- **Reorder Habits** - Organize habits in your preferred order

## Screenshots

<!-- Add screenshots here when available -->
<p align="center">
  <i>Screenshots coming soon</i>
</p>

## Getting Started

### Prerequisites

- macOS with Xcode 14.0 or later
- iOS device running iOS 15.0 or later
- Apple ID (for device installation)

### Installation

#### For Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/habitkit.git
   cd habitkit
   ```

2. **Open in Xcode**
   ```bash
   open HabitKit/HabitKit.xcodeproj
   ```

3. **Configure Signing**
   - Select the HabitKit project in the navigator
   - Go to "Signing & Capabilities"
   - Select your development team
   - Change the bundle identifier to something unique (e.g., `com.yourname.HabitKit`)

4. **Build and Run**
   - Connect your iOS device
   - Select your device from the device menu
   - Press `Cmd + R` or click the Play button

#### For Device Installation

See the detailed instructions in **[BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md)**

## Project Structure

```
HabitKit/
├── HabitKit/
│   ├── HabitKitApp.swift          # Main app entry point
│   ├── ContentView.swift          # Root view with tab navigation
│   │
│   ├── Models/                    # Data models
│   │   ├── Habit.swift           # Habit data model
│   │   ├── HabitStore.swift      # Data persistence
│   │   └── ThemeManager.swift    # Theme management
│   │
│   ├── Views/                     # UI components
│   │   ├── DashboardView.swift   # Main dashboard
│   │   ├── HabitDetailView.swift # Habit detail screen
│   │   ├── NewHabitView.swift    # Create new habit
│   │   ├── SettingsView.swift    # Settings screen
│   │   ├── ListView.swift        # List view mode
│   │   ├── CompactListView.swift # Compact view mode
│   │   └── HabitCalendarGridView.swift # Calendar grid component
│   │
│   ├── Utilities/                 # Helper utilities
│   │   ├── ColorExtension.swift  # Color utilities
│   │   └── NotificationManager.swift # Notification handling
│   │
│   ├── Resources/                 # Assets and resources
│   │   └── Assets.xcassets/      # Images and colors
│   │
│   └── Info.plist                # App configuration
│
├── BUILD_INSTRUCTIONS.md          # Build and installation guide
├── APP_STORE_GUIDE.md            # App Store submission guide
└── README.md                      # This file
```

## Architecture

HabitKit is built using:

- **SwiftUI** - Modern declarative UI framework
- **MVVM Pattern** - Clear separation of concerns
- **Combine** - Reactive data flow with `@Published` properties
- **UserDefaults** - Lightweight local data persistence
- **UserNotifications** - Local reminder notifications

### Key Components

- **HabitStore**: Observable object managing all habit data and persistence
- **ThemeManager**: Handles app-wide theme preferences
- **NotificationManager**: Manages local notifications for reminders
- **Habit Model**: Codable struct for habit data with completion tracking

## Features in Detail

### Habit Tracking

Each habit includes:
- Name and description
- Custom icon (SF Symbols)
- Custom color
- Optional category
- Optional streak goal
- Completion history
- Multiple reminders
- Archive status

### Calendar Visualization

- **Year Grid**: GitHub-style contribution graph showing up to a year of data
- **Monthly Calendar**: Detailed monthly view with day-by-day completion
- **Completion Indicators**: Visual feedback for completed days
- **Streak Display**: Current streak prominently displayed

### Data Persistence

All data is stored locally using:
- UserDefaults for habit data (JSON encoding)
- Automatic save on every change
- Import/export functionality for backups

## Customization

### Adding New Features

The codebase is structured for easy extension:

1. **New Views**: Add to `Views/` folder
2. **Data Models**: Extend `Habit` or create new models in `Models/`
3. **Utilities**: Add helper functions to `Utilities/`

### Theming

Modify colors in:
- `AccentColor.colorset` for app-wide accent
- `colorFromString()` methods for habit colors
- Theme options in `ThemeManager.swift`

## Building for Distribution

### Creating an IPA

See **[BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md)** for detailed instructions on:
- Building for physical devices
- Creating IPA files
- Installing on devices
- Troubleshooting common issues

### App Store Submission

See **[APP_STORE_GUIDE.md](APP_STORE_GUIDE.md)** for complete guide on:
- Preparing app assets
- Creating App Store listing
- Upload process
- Review guidelines
- Post-launch management

## Requirements

### Minimum Requirements
- iOS 15.0+
- Xcode 14.0+
- Swift 5.0+

### Recommended
- iOS 16.0+ for latest features
- Xcode 15.0+ for best experience

## Privacy

HabitKit is privacy-focused:
- All data stored locally on device
- No analytics or tracking
- No data sent to external servers
- No account required
- Optional iCloud sync (future feature)

## Roadmap

Planned features:
- [ ] iCloud sync across devices
- [ ] Home screen widgets
- [ ] Advanced statistics and charts
- [ ] Habit categories with filtering
- [ ] Custom reminder sounds
- [ ] Dark mode themes
- [ ] iPad optimization
- [ ] Apple Watch companion app

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

### Development Guidelines
- Follow Swift style guide
- Use SwiftUI best practices
- Maintain MVVM architecture
- Comment complex logic
- Test on real devices

## License

This project is available for personal and educational use. See LICENSE file for details.

## Acknowledgments

- Design inspired by modern habit tracking apps
- Icons from SF Symbols
- Built with SwiftUI and modern iOS frameworks

## Support

For questions or issues:
- Open an issue on GitHub
- Check the build instructions and guides
- Review Apple's developer documentation

## Author

Created with ❤️ for building better habits

---

**Ready to build better habits? Let's get started! 🚀**

For build instructions, see [BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md)

For App Store publishing, see [APP_STORE_GUIDE.md](APP_STORE_GUIDE.md)
# HabitKit - Habit Tracking App

A beautiful, feature-rich habit tracking app built with Flutter, inspired by HabitKit. Track your daily habits with elegant GitHub-style grid visualizations and unique **OR Options** feature.

![Flutter](https://img.shields.io/badge/Flutter-3.24.5-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.5.4-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

---

## ✨ Features

### Core Features
- ✅ **Create & Manage Habits** - Add, edit, delete, and archive habits
- 📊 **GitHub-Style Grid** - Beautiful visualization showing 6+ months of progress
- 🔥 **Streak Tracking** - Monitor current and longest streaks
- 📈 **Statistics Dashboard** - View completion rates and overall progress
- 🎨 **Customization** - 21 colors, 40+ emoji icons
- 🏷️ **Tags & Organization** - Group habits by categories
- 💾 **Local Storage** - All data stored locally with Hive (no cloud required)
- 📤 **Import/Export** - Backup and restore your data

### 🎯 Unique Feature: **OR Options**

Track habits that can be completed in multiple ways!

**Example:** Create an "Exercise" habit with OR options:
- 🏋️ **Gym** (Purple)
- 🏸 **Badminton** (Red)

When you complete the habit, select which option you did. The grid shows different colors based on your choice, and you get detailed statistics on which option you prefer.

**Perfect for:**
- Exercise (Gym OR Running OR Swimming)
- Study (Math OR Science OR History)
- Creative work (Writing OR Drawing OR Music)
- Social (Call Friend OR Meet in Person)

---

## 📱 Screenshots

See the `references/` folder for app screenshots and design inspiration.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.24.5 or higher
- Dart 3.5.4 or higher
- Android Studio / Xcode (for Android/iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/light-87/Habitkit.git
   cd Habitkit/app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🏗️ Project Structure

```
app/
├── lib/
│   ├── main.dart                  # App entry point
│   │
│   ├── models/                    # Data models
│   │   ├── habit.dart             # Habit model with OR options
│   │   ├── completion.dart        # Completion tracking
│   │   └── or_option.dart         # OR options model
│   │
│   ├── services/                  # Business logic
│   │   ├── database_service.dart  # Hive initialization
│   │   └── habit_service.dart     # CRUD operations
│   │
│   ├── providers/                 # State management
│   │   └── habit_provider.dart    # Habit state
│   │
│   ├── screens/                   # UI screens
│   │   ├── dashboard_screen.dart  # Main screen
│   │   ├── add_habit_screen.dart  # Create/edit habits
│   │   └── habit_detail_screen.dart # Habit details
│   │
│   ├── widgets/                   # Reusable components
│   │   ├── habit_card.dart        # Habit list item
│   │   └── habit_grid.dart        # GitHub-style grid
│   │
│   └── utils/                     # Utilities
│       ├── constants.dart         # Colors, spacing
│       ├── date_utils.dart        # Date helpers
│       └── theme.dart             # App theme
│
├── references/                    # Design reference images
├── pubspec.yaml                   # Dependencies
└── README.md                      # This file
```

---

## 🎨 Tech Stack

### Framework
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language

### State Management
- **Provider** - Simple and efficient state management

### Local Database
- **Hive** - Fast, lightweight NoSQL database
- **Hive Flutter** - Flutter integration
- **Hive Generator** - Code generation for type adapters

### UI Components
- **Google Fonts** - Inter font family
- **FL Chart** - Beautiful charts (ready for stats screen)
- **Table Calendar** - Calendar widget (ready for future use)

### Utilities
- **UUID** - Generate unique IDs
- **Intl** - Internationalization and date formatting
- **Path Provider** - Access device directories
- **Share Plus** - Share functionality

---

## 📚 How It Works

### Data Models

#### Habit
```dart
class Habit {
  String id;
  String name;
  String description;
  String icon;
  String color;
  DateTime createdAt;
  List<Completion> completions;

  // OR Options
  bool hasOrOptions;
  OrOptions? orOptions;

  // Organization
  List<String> tags;
  bool isArchived;

  // Goals
  int? streakGoal;
  int? targetCompletionsPerDay;
}
```

#### OR Options
```dart
class OrOptions {
  OrOption option1;  // e.g., Gym
  OrOption option2;  // e.g., Badminton
}

class OrOption {
  String name;   // "Gym"
  String color;  // "#8B5CF6"
  String icon;   // "🏋️"
}
```

#### Completion
```dart
class Completion {
  String id;
  DateTime date;
  int count;  // Multiple completions per day
  String? selectedOption;  // "option1", "option2", "both", or null
}
```

### Key Features Implementation

#### 1. GitHub-Style Grid
- Shows last 6 months of data
- Color intensity based on completion count
- OR Options: Shows different colors based on selected option
- Tap tiles to add/remove completions

#### 2. OR Options Flow
1. Create habit with OR Options toggle enabled
2. Define Option 1 and Option 2 (name, color, icon)
3. When completing: Modal appears asking which option
4. Grid tile displays the selected option's color
5. Statistics show breakdown of each option

#### 3. Streak Calculation
- Counts consecutive days of completion
- Resets if a day is missed
- Shows both current and longest streaks

---

## 🎯 Roadmap

### Phase 1: MVP ✅ (Completed)
- [x] Create/Edit/Delete habits
- [x] Mark habits complete
- [x] Grid visualization
- [x] OR Options feature
- [x] Local storage
- [x] Basic UI

### Phase 2: Enhancements (Upcoming)
- [ ] Settings screen
- [ ] Theme customization (dark mode)
- [ ] Daily reminders/notifications
- [ ] Full calendar view
- [ ] Edit habit functionality
- [ ] Habit reordering

### Phase 3: Advanced Features
- [ ] Statistics & Charts
- [ ] Home screen widgets
- [ ] Multiple reminders per habit
- [ ] Dashboard customization
- [ ] Habit templates

### Phase 4: Pro Features
- [ ] Unlimited habits (free tier: 5 habits)
- [ ] Advanced statistics
- [ ] Cloud backup
- [ ] Multi-device sync
- [ ] Custom themes

---

## 🔧 Development

### Generate Code
```bash
# Generate Hive adapters
flutter pub run build_runner build

# Watch for changes and auto-generate
flutter pub run build_runner watch
```

### Testing
```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

### Build
```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web
```

---

## 📖 Usage Guide

### Creating a Habit

1. Tap the **"Add Habit"** button
2. Select an icon (40+ emojis available)
3. Enter habit name and description
4. Choose a color (21 colors)
5. **Optional:** Enable OR Options
   - Define Option 1 (name, icon, color)
   - Define Option 2 (name, icon, color)
6. Tap **Save**

### Completing a Habit

**Regular Habit:**
- Tap the checkmark button on the habit card
- The grid tile for today updates

**OR Options Habit:**
- Tap the checkmark button
- Modal appears: "How did you [habit name]?"
- Select Option 1, Option 2, or Both
- Grid tile shows the selected option's color

### Viewing Progress

1. Tap a habit card to open details
2. View:
   - Current streak
   - Longest streak
   - Total completions
   - OR Options breakdown (if enabled)
   - 6-month grid visualization
3. Tap grid tiles to manage past completions

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Inspired by [HabitKit](https://www.habitkit.app/)
- GitHub contribution graph design
- Flutter community for amazing packages

---

## 📧 Contact

For questions or feedback:
- GitHub Issues: [https://github.com/light-87/Habitkit/issues](https://github.com/light-87/Habitkit/issues)

---

## 🌟 Show Your Support

Give a ⭐️ if this project helped you!

---

**Built with ❤️ using Flutter**
