# Quick Start Guide - HabitKit

Get HabitKit running on your iPhone in under 10 minutes!

## What You Need

- A Mac computer
- An iPhone (iOS 15 or newer)
- A USB cable
- Xcode (free from App Store)

## Step-by-Step Installation

### 1. Install Xcode (If Not Already Installed)

1. Open the **App Store** on your Mac
2. Search for **Xcode**
3. Click **Get** or **Install**
4. Wait for download (it's large, ~10GB)

### 2. Open the Project

1. Download or clone this project to your Mac
2. Open the **HabitKit** folder
3. Double-click **HabitKit.xcodeproj**
4. Xcode will open

### 3. Set Up Your Developer Account

1. In Xcode, go to **Xcode** → **Settings** (or press `Cmd + ,`)
2. Click the **Accounts** tab
3. Click the **+** button in the bottom left
4. Choose **Apple ID**
5. Sign in with your Apple ID
6. Close the settings window

### 4. Configure the Project

1. In Xcode's left sidebar, click **HabitKit** (the blue project icon at the top)
2. Under "Targets", click **HabitKit**
3. Click the **Signing & Capabilities** tab
4. Check the box **Automatically manage signing**
5. In the **Team** dropdown, select your Apple ID
6. Under **Bundle Identifier**, change it to something unique:
   - Current: `com.yourcompany.HabitKit`
   - Change to: `com.YOURNAME.HabitKit` (replace YOURNAME with your name)

### 5. Connect Your iPhone

1. Plug your iPhone into your Mac with a USB cable
2. Unlock your iPhone
3. If prompted "Trust This Computer?", tap **Trust**
4. Enter your iPhone passcode

### 6. Build and Install

1. At the top of Xcode, find the device selector (it says "iPhone Simulator" or similar)
2. Click it and select your connected iPhone from the list
3. Click the **Play** button (▶️) in the top left corner
4. Xcode will build the app (wait 1-3 minutes)
5. The app will install on your iPhone

### 7. Trust the Developer

**First time only:**

1. On your iPhone, you'll see "Untrusted Developer" when trying to open the app
2. Go to **Settings** on your iPhone
3. Tap **General**
4. Scroll down to **VPN & Device Management** (or **Profiles & Device Management**)
5. Under "Developer App", tap your Apple ID
6. Tap **Trust "[Your Apple ID]"**
7. Tap **Trust** again to confirm

### 8. Launch the App

1. Go back to your iPhone home screen
2. Find the **HabitKit** app
3. Tap to open
4. Start tracking your habits!

## Quick Tips

### Creating Your First Habit

1. Tap the **+** button in the top right
2. Choose an icon by tapping the gray icons
3. Type a name (e.g., "Morning Run")
4. Optional: Add a description
5. Pick a color
6. Tap **Save**

### Marking a Habit as Complete

1. Find your habit on the main screen
2. Tap the gray checkmark button on the right
3. It will turn colored and show as completed!

### Viewing Your Progress

1. Tap on any habit card
2. See your completion calendar
3. Tap dates to mark them complete/incomplete

## Common Issues

### "Failed to verify code signature"
**Fix:** Make sure you selected your Apple ID in the Team dropdown (Step 4, #5)

### Can't find my iPhone in Xcode
**Fix:**
- Make sure it's unlocked
- Try unplugging and replugging the cable
- Tap "Trust This Computer" if you see it

### App works for a week then stops
This is normal with a free Apple account. Options:
- Reinstall the app every week (takes 30 seconds)
- Join Apple Developer Program ($99/year) to avoid this

### "Unable to install HabitKit"
**Fix:**
- Make sure your iPhone has enough storage space
- Make sure your iPhone is running iOS 15 or newer
- Try restarting your iPhone

## Free Account Limitations

With a **free** Apple account:
- ✅ You can install and use the app
- ⚠️ Apps expire after 7 days (need to reinstall)
- ⚠️ Limited to 3 apps at a time

With a **paid** Apple Developer account ($99/year):
- ✅ Apps don't expire
- ✅ Can publish to App Store
- ✅ No app limits

## What's Next?

Once the app is running:

1. **Create habits** - Add all the habits you want to track
2. **Set reminders** - Get notifications to check in daily
3. **Build streaks** - Try to maintain your longest streak!
4. **Explore settings** - Customize themes and preferences

## Need More Help?

- **Detailed build instructions:** See [BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md)
- **Publishing to App Store:** See [APP_STORE_GUIDE.md](APP_STORE_GUIDE.md)
- **Technical details:** See [README.md](README.md)

## Support

Having trouble? Check:
1. Is Xcode fully updated?
2. Is your iPhone running iOS 15+?
3. Did you trust the developer certificate?
4. Did you change the bundle identifier?

Still stuck? Try:
- Restart Xcode
- Restart your Mac
- Restart your iPhone
- Try a different USB cable

---

**That's it! You should now have HabitKit running on your iPhone. Happy habit tracking! 🎉**
