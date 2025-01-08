# Task_Management

A simple mobile app to manage tasks with core functionality and a clean design. Focus on local data storage, task management features, and responsive UI.

## Features

### Core Functionality
- **Task Management**
  - Create, edit, and delete tasks
  - Set task priorities (High, Medium, Low)
  - Add due dates
  - Mark tasks as complete/incomplete
  - Swipe to delete tasks

### User Interface
- **Modern Design**
  - Clean Material Design 3.0 interface
  - Responsive layout for different screen sizes
  - Visual priority indicators
  - Intuitive task management

### Additional Features
- **Dark Mode Support**
  - Toggle between light and dark themes
  - Persistent theme preference
  - Automatic system theme detection

- **Data Persistence**
  - Local storage using Hive database
  - Fast and efficient data operations
  - Persistent across app restarts

## Installation

### Prerequisites
- Flutter SDK (version 3.0 or higher)
- Dart SDK (version 3.0 or higher)
- Android Studio / VS Code
- Git

### Setup Steps

1. **Clone the Repository**
```bash
git clone https://github.com/yourusername/task_manager.git
cd task_manager
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Generate Hive Adapters**
```bash
flutter pub run build_runner clean
flutter pub run build_runner build
```

4. **Run the App**
```bash
flutter run
```

### Building for Release

#### Android
```bash
flutter build apk --release
```
The APK file will be available at `build/app/outputs/flutter-apk/app-release.apk`

#### iOS
```bash
flutter build ios --release
```
Follow the standard iOS deployment process through Xcode.

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── task.dart            # Task data model
│   └── task.g.dart          # Generated Hive adapter
├── screens/
│   └── home_screen.dart     # Main screen
├── widgets/
│   ├── add_task_form.dart   # Task creation form
│   ├── edit_task_form.dart  # Task editing form
│   └── task_list_item.dart  # Task list item widget
└── theme/
    └── theme_provider.dart   # Theme management
```


