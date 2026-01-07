# 🏛️ Harbour of Fortune

A cross-platform mobile card game built with Flutter. Navigate the harbour, collect cards, and build your fortune!

## 📱 Project Overview

**Harbour of Fortune** is a strategic card game featuring beautiful harbour-themed artwork and engaging gameplay mechanics. Built with Flutter for seamless cross-platform performance on iOS and Android.

### ✨ Features

- 🎨 Beautiful harbour-themed UI with custom card designs
- 🎮 Strategic turn-based gameplay
- 📊 Real-time game state management
- 🔄 Smooth animations and transitions
- 📱 Responsive design for all screen sizes
- 🎯 Cross-platform (iOS & Android)

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: 3.38.5 or higher
- **Dart**: 3.10.4 or higher
- **Android Studio** (for Android development)
- **Xcode** (for iOS development - macOS only)
- **VS Code** or **Android Studio** (recommended IDEs)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/harbour_of_fortune.git
   cd harbour_of_fortune
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter setup**
   ```bash
   flutter doctor -v
   ```

4. **Add your assets**
   - Place `splash_bg.png` in `assets/images/`
   - Place `logo.png` in `assets/images/`

5. **Run the app**
   ```bash
   # On Android device/emulator
   flutter run
   
   # On iOS simulator (macOS only)
   flutter run -d ios
   
   # On Chrome (for testing)
   flutter run -d chrome
   ```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── core/                     # Core functionality
│   ├── constants/           # App constants (colors, assets)
│   ├── theme/              # App theming
│   └── utils/              # Utility functions
├── features/                # Feature modules
│   ├── splash/             # Splash screen
│   ├── onboarding/         # Onboarding flow
│   ├── home/               # Home screen
│   ├── game/               # Game logic & UI
│   └── cards/              # Card components
└── widgets/                 # Reusable widgets
    └── common/             # Common UI components

assets/
├── images/                  # Image assets
│   ├── splash_bg.png
│   ├── logo.png
│   └── cards/              # Card images
└── fonts/                   # Custom fonts (if any)
```
