# HabitKit Clone - Development Plan

## 📱 App Overview

A habit tracking app with beautiful GitHub-style grid visualizations that helps users build consistent habits. This clone will replicate HabitKit's core features plus add a unique **OR Options** feature for tracking alternative habit completions.

---

## 🎨 Design Analysis (Based on Screenshots)

### Color Scheme
- **Primary Brand Color**: Purple (`#8B5CF6` or similar)
- **Background**: Light gray/white (`#F5F5F5`)
- **Card backgrounds**: White with subtle shadows
- **Accent colors**: 21 color palette for habit customization

### UI Components Observed

1. **Main Dashboard** (Screenshot 4)
   - Header with logo, PRO badge, stats icon, add button
   - Settings gear icon (top left)
   - Tag filters (e.g., "Study")
   - Habit cards with inline grid visualization
   - Checkmark button for quick completion
   - Bottom tab navigation (3 tabs: grid view, list view, menu)

2. **Habit Detail Modal** (Screenshot 2)
   - Full-screen modal with blur background
   - Large GitHub-style grid (6-7 months visible)
   - Streak goal display
   - Counter for completions
   - Monthly calendar view with completion dots
   - Edit and settings buttons

3. **New Habit Form** (Screenshot 3)
   - Icon selector (circular arrangement, 40+ icons)
   - Name field
   - Description field
   - Color picker (21 colors, 7x3 grid)
   - Advanced options dropdown
   - Save button

4. **Settings Screen** (Screenshot 1)
   - Grouped list layout
   - Pro subscription banner
   - Sections: App, Help, About
   - Icon + label for each option

5. **Pro Features Screen** (Screenshot 5)
   - Feature list with icons and descriptions
   - Continue button

---

## 🚀 Technology Stack

### Recommended: **Flutter** (Dart)

**Why Flutter?**
- ✅ Single codebase for iOS & Android
- ✅ Excellent performance & smooth animations
- ✅ Beautiful Material & Cupertino widgets
- ✅ Hot reload for fast development
- ✅ Great documentation & community
- ✅ Perfect for beginners in mobile development

**Key Dependencies:**
```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management
  provider: ^6.1.0           # Simple state management

  # Local Storage
  hive: ^2.2.3              # Fast local database
  hive_flutter: ^1.1.0

  # UI Components
  google_fonts: ^6.1.0      # Custom fonts
  fl_chart: ^0.65.0         # Charts for statistics
  intl: ^0.19.0             # Date formatting

  # Icons & Colors
  flutter_iconpicker: ^3.2.4
  flex_color_picker: ^3.4.0

  # Widgets
  flutter_slidable: ^3.0.0  # Swipe actions
  calendar_view: ^1.0.4     # Calendar widget

  # Notifications
  flutter_local_notifications: ^16.3.0

  # Data Import/Export
  path_provider: ^2.1.1
  share_plus: ^7.2.1
```

---

## 📦 Core Features Breakdown

### Phase 1: MVP (Weeks 1-3)

#### 1.1 Basic Habit Management
- ✓ Create habit (name, description, icon, color)
- ✓ Edit habit
- ✓ Delete habit
- ✓ List all habits
- ✓ Mark habit as complete for today
- ✓ Undo completion

#### 1.2 Data Models
```dart
// Habit Model
class Habit {
  String id;
  String name;
  String description;
  String icon;
  String color;
  DateTime createdAt;
  List<Completion> completions;

  // NEW: OR Options Feature
  bool hasOrOptions;
  OrOptions? orOptions;
}

// OR Options Model (NEW FEATURE)
class OrOptions {
  Option option1;
  Option option2;
}

class Option {
  String name;        // e.g., "Gym"
  String color;       // e.g., "#8B5CF6"
  String? icon;       // Optional icon
}

// Completion Model
class Completion {
  String id;
  DateTime date;
  int count;          // For multiple completions per day

  // NEW: Track which OR option was chosen
  String? selectedOption;  // "option1" or "option2" or null
}
```

#### 1.3 Local Storage (Hive)
- Store habits locally
- Store completions
- No backend/cloud required
- Data persists on device

#### 1.4 Basic UI
- Main dashboard with habit list
- Simple grid visualization (7 days visible)
- Add/Edit habit screen
- Bottom navigation

---

### Phase 2: Grid & Streaks (Weeks 4-5)

#### 2.1 GitHub-Style Grid Visualization
- Show up to 6-7 months of data
- Different color intensities based on completion count
- Scrollable horizontally
- Month labels (Jan, Feb, Mar, etc.)
- Day labels (Mon, Tue, Wed, etc.)
- Tap on day to see details

#### 2.2 OR Options Visualization (NEW FEATURE)
When habit has OR options enabled:
- **Option 1 selected**: Show option1's color on grid tile
- **Option 2 selected**: Show option2's color on grid tile
- **Both selected**: Split tile diagonally or show as gradient
- **None selected**: Show empty/gray tile

#### 2.3 Streak Calculation
- Current streak counter
- Longest streak tracker
- Streak goal setting
- Visual indicator when streak is active

#### 2.4 Multiple Completions Per Day
- Counter for number of completions
- Different grid intensity based on count
- Target count per day (optional)

---

### Phase 3: Advanced Features (Weeks 6-7)

#### 3.1 Calendar Management
- Monthly calendar view
- Tap to add/remove completions for past dates
- Visual dots for completed days
- Navigate between months

#### 3.2 Tags & Organization
- Create tags/categories
- Assign habits to tags
- Filter habits by tag
- Tag chips in UI

#### 3.3 Habit Customization
- 21-color palette
- 40+ icon options
- Custom emoji support
- Habit archiving

#### 3.4 OR Options UI Flow (NEW FEATURE)

**Creating Habit with OR Options:**
```
1. User taps "Add Habit"
2. Fills name, description, icon, color
3. In "Advanced Options":

   [Toggle] Enable OR Options

   When enabled:

   Option 1:
   Name: [Gym          ]
   Color: [Purple picker]
   Icon:  [🏋️          ]

   Option 2:
   Name: [Badminton    ]
   Color: [Red picker   ]
   Icon:  [🏸          ]
```

**Completing Habit with OR Options:**
```
1. User taps habit checkmark
2. Modal appears:

   ┌─────────────────────────┐
   │  How did you Exercise?  │
   │                         │
   │  [🏋️ Gym]    Purple    │
   │  [🏸 Badminton] Red     │
   │                         │
   │  [Both] [Cancel]        │
   └─────────────────────────┘

3. User selects option
4. Grid tile updates with chosen color
```

**Statistics for OR Options:**
```
Exercise
├─ Total: 30 days
├─ Current Streak: 15 days
├─ 🏋️ Gym: 18 completions (60%)
└─ 🏸 Badminton: 12 completions (40%)
```

---

### Phase 4: Pro Features (Weeks 8+)

Based on Screenshot 5, Pro features include:

#### 4.1 Unlimited Habits
- Free: 5 habits limit
- Pro: Unlimited

#### 4.2 Home Screen Widgets
- Small widget: Single habit
- Medium widget: 2-3 habits
- Large widget: Grid + stats

#### 4.3 Multiple Reminders
- Up to 3 reminders per habit
- Custom times
- Smart notifications

#### 4.4 Charts & Statistics
- Completion rate graphs
- Streak history
- Best/worst days analysis
- Monthly/yearly summaries

#### 4.5 Dashboard Customization
- Show/hide streaks
- Show/hide goals
- Show/hide labels
- Compact vs expanded view

#### 4.6 Data Import/Export
- Export as JSON or CSV
- Import from backup
- Backup reminder

#### 4.7 Archived Habits
- Archive instead of delete
- Restore archived habits
- View archived habit history

---

## 🏗️ Project Structure

```
Habitkit/
├── lib/
│   ├── main.dart                      # App entry point
│   │
│   ├── models/                        # Data models
│   │   ├── habit.dart
│   │   ├── completion.dart
│   │   ├── or_options.dart           # NEW: OR options model
│   │   ├── tag.dart
│   │   └── settings.dart
│   │
│   ├── services/                      # Business logic
│   │   ├── database_service.dart      # Hive setup
│   │   ├── habit_service.dart         # CRUD operations
│   │   ├── streak_service.dart        # Streak calculations
│   │   ├── notification_service.dart  # Reminders
│   │   └── export_service.dart        # Import/export
│   │
│   ├── providers/                     # State management
│   │   ├── habit_provider.dart
│   │   ├── theme_provider.dart
│   │   └── settings_provider.dart
│   │
│   ├── screens/                       # UI screens
│   │   ├── dashboard_screen.dart      # Main screen
│   │   ├── habit_detail_screen.dart   # Habit modal
│   │   ├── add_habit_screen.dart      # Create/edit
│   │   ├── settings_screen.dart
│   │   ├── stats_screen.dart
│   │   └── pro_screen.dart
│   │
│   ├── widgets/                       # Reusable components
│   │   ├── habit_card.dart            # Habit list item
│   │   ├── grid_visualization.dart    # GitHub-style grid
│   │   ├── calendar_widget.dart       # Monthly calendar
│   │   ├── color_picker.dart
│   │   ├── icon_picker.dart
│   │   ├── or_options_picker.dart     # NEW: OR options modal
│   │   └── streak_indicator.dart
│   │
│   ├── utils/                         # Utilities
│   │   ├── constants.dart             # Colors, sizes
│   │   ├── date_utils.dart
│   │   └── theme.dart
│   │
│   └── config/
│       └── icons.dart                 # Icon definitions
│
├── android/                           # Android config
├── ios/                              # iOS config
├── assets/                           # Images, fonts
├── test/                             # Unit tests
├── pubspec.yaml                      # Dependencies
└── README.md
```

---

## 📅 Development Timeline

### Week 1: Setup & Foundation
- [ ] Install Flutter SDK
- [ ] Set up IDE (VS Code or Android Studio)
- [ ] Install Android Studio & Xcode (for simulators)
- [ ] Create Flutter project
- [ ] Set up dependencies
- [ ] Create basic project structure
- [ ] Design database schema
- [ ] Set up Hive local storage

### Week 2: Core Functionality
- [ ] Build Habit model & service
- [ ] Create add/edit habit screen
- [ ] Implement habit list display
- [ ] Add mark complete functionality
- [ ] Set up state management with Provider
- [ ] Basic navigation

### Week 3: UI Polish & Grid
- [ ] Design main dashboard UI
- [ ] Implement color picker (21 colors)
- [ ] Implement icon picker
- [ ] Build basic 7-day grid visualization
- [ ] Add habit cards with inline grid

### Week 4: Advanced Grid
- [ ] Extend grid to 6-7 months
- [ ] Add horizontal scrolling
- [ ] Month/day labels
- [ ] Different intensities for multiple completions
- [ ] Tap interaction on grid tiles

### Week 5: Streaks & OR Options
- [ ] Implement streak calculation logic
- [ ] Build streak display UI
- [ ] **NEW: Implement OR Options data model**
- [ ] **NEW: Build OR Options toggle in add habit**
- [ ] **NEW: Create OR Options picker modal**
- [ ] **NEW: Update grid to show OR option colors**

### Week 6: Calendar & Tags
- [ ] Build monthly calendar view
- [ ] Add/remove past completions
- [ ] Create tag system
- [ ] Tag filtering
- [ ] Archive functionality

### Week 7: Settings & Polish
- [ ] Build settings screen
- [ ] Theme customization
- [ ] Daily reminders (basic)
- [ ] Data export (JSON)
- [ ] Data import
- [ ] App icon & splash screen

### Week 8+: Pro Features
- [ ] Implement habit limit (5 for free)
- [ ] Build statistics screen with charts
- [ ] Multiple reminders per habit
- [ ] Home screen widgets
- [ ] Dashboard customization options
- [ ] Pro unlock screen
- [ ] In-app purchase integration (optional)

---

## 🎯 Unique Feature: OR Options Deep Dive

### Use Cases
1. **Exercise**: Gym OR Badminton OR Running
2. **Study**: Math OR Science OR English
3. **Creative**: Writing OR Drawing OR Music
4. **Social**: Call Friend OR Meet in Person
5. **Relaxation**: Meditation OR Yoga OR Reading

### Implementation Details

#### Database Schema
```dart
// Hive TypeAdapter
@HiveType(typeId: 1)
class Habit extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  // ... other fields

  @HiveField(10)
  bool hasOrOptions = false;

  @HiveField(11)
  OrOptions? orOptions;
}

@HiveType(typeId: 2)
class OrOptions {
  @HiveField(0)
  Option option1;

  @HiveField(1)
  Option option2;
}

@HiveType(typeId: 3)
class Option {
  @HiveField(0)
  String name;

  @HiveField(1)
  String color;

  @HiveField(2)
  String? icon;
}

@HiveType(typeId: 4)
class Completion {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int count;

  @HiveField(2)
  String? selectedOption; // "option1", "option2", or null
}
```

#### Grid Visualization Logic
```dart
Color getGridTileColor(Completion? completion, Habit habit) {
  if (completion == null) return Colors.grey[200];

  if (!habit.hasOrOptions) {
    // Regular habit: use habit color with intensity
    return Color(habit.color).withOpacity(
      min(completion.count / 3, 1.0)
    );
  }

  // OR Options habit
  if (completion.selectedOption == 'option1') {
    return Color(habit.orOptions!.option1.color);
  } else if (completion.selectedOption == 'option2') {
    return Color(habit.orOptions!.option2.color);
  }

  return Colors.grey[200]; // No selection
}
```

#### Statistics Calculation
```dart
class OrOptionStats {
  int totalCompletions;
  int option1Count;
  int option2Count;
  double option1Percentage;
  double option2Percentage;

  // Which option was used more this week/month
  String preferredOption;

  // Trends over time
  Map<DateTime, String> optionHistory;
}
```

---

## 🎨 Design System

### Colors (From Screenshots)
```dart
class AppColors {
  // Brand
  static const primary = Color(0xFF8B5CF6);      // Purple
  static const primaryLight = Color(0xFFA78BFA);
  static const primaryDark = Color(0xFF7C3AED);

  // Background
  static const background = Color(0xFFF5F5F5);
  static const cardBackground = Colors.white;

  // Text
  static const textPrimary = Color(0xFF1F2937);
  static const textSecondary = Color(0xFF6B7280);

  // Habit Colors (21 total)
  static const habitColors = [
    Color(0xFFEF4444), // Red
    Color(0xFFF97316), // Orange
    Color(0xFFF59E0B), // Amber
    Color(0xFFEAB308), // Yellow
    Color(0xFF84CC16), // Lime
    Color(0xFF22C55E), // Green
    Color(0xFF10B981), // Emerald
    Color(0xFF14B8A6), // Teal
    Color(0xFF06B6D4), // Cyan
    Color(0xFF0EA5E9), // Sky
    Color(0xFF3B82F6), // Blue
    Color(0xFF6366F1), // Indigo
    Color(0xFF8B5CF6), // Purple
    Color(0xFFA855F7), // Violet
    Color(0xFFD946EF), // Fuchsia
    Color(0xFFEC4899), // Pink
    Color(0xFFF43F5E), // Rose
    Color(0xFF64748B), // Slate
    Color(0xFF6B7280), // Gray
    Color(0xFF78716C), // Stone
    Color(0xFF57534E), // Brown
  ];
}
```

### Typography
```dart
class AppTextStyles {
  static const heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const habitName = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );
}
```

### Spacing
```dart
class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}
```

---

## 🧪 Testing Strategy

### Unit Tests
- Streak calculation logic
- OR options statistics
- Date utilities
- Data import/export

### Widget Tests
- Grid visualization rendering
- Color picker
- OR options modal
- Calendar interactions

### Integration Tests
- Complete user flows
- Data persistence
- State management

---

## 📱 Platform-Specific Considerations

### iOS
- Use Cupertino widgets where appropriate
- SF Symbols for icons
- Haptic feedback on interactions
- Dark mode support

### Android
- Material Design 3
- Material icons
- Adaptive widgets
- Dark/light theme

---

## 🚀 Next Steps

1. **Choose Flutter** as the framework (recommended)
2. **Install Flutter SDK** on your machine
3. **Set up development environment** (VS Code + Flutter extension)
4. **Install simulators** (iOS Simulator / Android Emulator)
5. **Initialize project** with proper structure
6. **Start with Week 1 tasks**

---

## 💡 Additional Recommendations

### Learning Resources
- Flutter official docs: https://flutter.dev
- Flutter Codelabs: https://flutter.dev/codelabs
- Provider state management: https://pub.dev/packages/provider
- Hive database: https://docs.hivedb.dev

### Development Tools
- **IDE**: VS Code or Android Studio
- **Version Control**: Git & GitHub
- **Design**: Figma (optional, for mockups)
- **Testing**: Flutter Test framework

### Best Practices
- Follow Flutter style guide
- Use const constructors where possible
- Implement proper error handling
- Add loading states
- Handle edge cases (empty states, network errors)
- Write meaningful commit messages
- Test on both platforms regularly

---

## 📊 Success Metrics

### MVP Success
- Can create/edit/delete habits
- Can mark habits complete
- Grid shows last 7 days
- Data persists locally

### Full App Success
- All features from screenshots implemented
- OR Options feature working smoothly
- Smooth 60fps animations
- < 50MB app size
- < 2 second cold start time
- No crashes in typical usage

---

**Ready to start building?** Let me know and I'll help you set up Flutter and create the initial project structure! 🚀
