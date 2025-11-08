# HabitKit - Build & Installation Instructions

## Prerequisites

Before you can build and install HabitKit on your iOS device, you'll need:

1. **A Mac** with macOS (required for iOS development)
2. **Xcode** installed (latest version recommended, minimum Xcode 14)
   - Download from Mac App Store or https://developer.apple.com/xcode/
3. **An Apple ID** (free or paid Apple Developer account)
4. **An iOS device** running iOS 15.0 or later

## Step 1: Open the Project

1. Open Finder and navigate to the `HabitKit` folder
2. Double-click on `HabitKit.xcodeproj` to open it in Xcode
3. Wait for Xcode to load the project and index files

## Step 2: Configure Signing & Capabilities

### For Free Apple Account (Testing on Your Device)

1. In Xcode, select the **HabitKit** project in the Project Navigator (left sidebar)
2. Select the **HabitKit** target under "Targets"
3. Click on the **Signing & Capabilities** tab
4. Under "Signing", check **Automatically manage signing**
5. In the **Team** dropdown, select your Apple ID
   - If you don't see your Apple ID, click "Add an Account..." and sign in
6. Change the **Bundle Identifier** to something unique (e.g., `com.yourname.HabitKit`)
   - This must be unique across all iOS apps
   - Format: `com.yourname.appname`

### For Paid Apple Developer Account

1. Follow the same steps as above
2. Select your paid developer team from the **Team** dropdown
3. You can keep the bundle identifier as `com.yourcompany.HabitKit` or change it to your preference

## Step 3: Connect Your iOS Device

1. Connect your iPhone or iPad to your Mac using a USB cable
2. Unlock your device and trust your Mac if prompted
3. In Xcode, at the top near the center, click on the device selector (it might say "Any iOS Device" or "iPhone Simulator")
4. Select your connected physical device from the list

## Step 4: Build and Install

### First Time Installation

1. Click the **Play** button (▶) in the top left of Xcode, or press `Cmd + R`
2. Xcode will build the app - this may take 1-3 minutes
3. The app will automatically install and launch on your device

### Trust the Developer Certificate (First Time Only)

If you're using a free Apple account, you'll need to trust the developer certificate:

1. On your iOS device, go to **Settings**
2. Navigate to **General** → **VPN & Device Management** (or **Profiles & Device Management**)
3. Find your Apple ID under "Developer App"
4. Tap on it and then tap **Trust "[Your Apple ID]"**
5. Confirm by tapping **Trust** again
6. Return to your home screen and launch HabitKit

## Step 5: Running the App

After the first installation, the app should launch automatically. You can now:

- Create new habits
- Track your daily completions
- View your habit history
- Customize themes and settings

## Building an IPA File (For Distribution or Backup)

### Method 1: Archive in Xcode (Recommended)

1. In Xcode, select **Any iOS Device** (not a simulator) from the device selector
2. Go to **Product** → **Archive** in the menu bar
3. Wait for the archive process to complete
4. The Organizer window will open showing your archive
5. Click **Distribute App**
6. Choose distribution method:
   - **Development**: For testing on registered devices
   - **Ad Hoc**: For sharing with up to 100 specific devices
   - **App Store Connect**: For TestFlight or App Store submission

### Method 2: Export IPA from Archive

1. After creating an archive (steps above), in the Organizer window:
2. Select your archive and click **Distribute App**
3. Choose **Development** or **Ad Hoc**
4. Select **Export** (not Upload)
5. Choose signing options (Automatically manage signing is easiest)
6. Click **Export** and choose a save location
7. The IPA file will be saved to that location

### Installing IPA on Your Device

There are several ways to install an IPA:

#### Option A: Using Finder (macOS Catalina or later)

1. Connect your device to your Mac
2. Open Finder
3. Select your device in the sidebar
4. Drag and drop the IPA file onto the device window

#### Option B: Using Apple Configurator 2

1. Download Apple Configurator 2 from the Mac App Store
2. Connect your device
3. Double-click on your device
4. Click "Add" → "Apps"
5. Select your IPA file

#### Option C: Using Xcode

1. Go to **Window** → **Devices and Simulators**
2. Select your connected device
3. Click the **+** button under "Installed Apps"
4. Select your IPA file

## Troubleshooting

### "Failed to verify code signature"
- Make sure you've signed the app with your Apple ID
- Check that your certificate hasn't expired
- Try cleaning the build folder: **Product** → **Clean Build Folder**

### "Unable to install HabitKit"
- Make sure your device is running iOS 15.0 or later
- Check that you have enough storage space
- Restart your device and try again

### "Untrusted Developer"
- You need to trust the certificate in Settings → General → VPN & Device Management

### Build Fails
- Make sure you're using Xcode 14 or later
- Try cleaning the build folder: **Product** → **Clean Build Folder**
- Close and reopen Xcode
- Update to the latest version of Xcode

### Free Account Limitations

With a free Apple account:
- Apps expire after 7 days and need to be reinstalled
- You can only install 3 apps at a time per device
- You can only install on devices you own

To avoid these limitations, consider joining the Apple Developer Program ($99/year).

## Next Steps

Once you have the app running, see:
- `APP_STORE_GUIDE.md` - For publishing to the App Store
- `TESTFLIGHT_GUIDE.md` - For beta testing with TestFlight

## Support

For issues with the build process:
1. Check the Xcode error messages
2. Verify all prerequisites are met
3. Try the troubleshooting steps above
4. Check Apple's developer documentation at https://developer.apple.com
