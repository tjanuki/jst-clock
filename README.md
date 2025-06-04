# JSTClock

A macOS menu bar application that displays Japan Standard Time (JST).

## Features

- **Menu Bar Clock**: Shows current Japan Standard Time in your menu bar
- **Date Display**: Displays date in format `[Month Day] HH:mm` (e.g., `[June 3] 05:00`)
- **Always Visible**: Lives in your menu bar for quick reference
- **Start at Login**: Option to automatically launch when you log in to your Mac
- **Lightweight**: Minimal resource usage with real-time updates

## Requirements

- macOS 11.0 or later
- Xcode 14.0 or later (for building from source)

## Installation

### From Source

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/JSTClock.git
   cd JSTClock
   ```

2. Open the project in Xcode:
   ```bash
   open JSTClock.xcodeproj
   ```

3. Build and run the project (⌘+R)

### Pre-built Release

Download the latest release from the [Releases](https://github.com/yourusername/JSTClock/releases) page and drag `JSTClock.app` to your Applications folder.

## Usage

1. Launch JSTClock from your Applications folder or Launchpad
2. The current Japan Standard Time will appear in your menu bar
3. Click on the time to access options:
   - Toggle "Start at Login" to launch automatically
   - Click "Quit" to exit the application

## Development

The project is built with:
- SwiftUI for the user interface
- ServiceManagement framework for login item functionality
- Foundation's DateFormatter for accurate JST time display

### Project Structure

```
JSTClock/
├── JSTClock/
│   ├── JSTClockApp.swift    # Main app entry point and clock logic
│   ├── ContentView.swift    # UI components
│   └── Assets.xcassets/     # App icons and resources
├── JSTClockTests/           # Unit tests
└── JSTClockUITests/         # UI tests
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is available under the MIT License. See the LICENSE file for more details.