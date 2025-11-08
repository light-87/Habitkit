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
