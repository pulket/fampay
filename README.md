# FamPay Contextual Cards 🚀

## Overview
A dynamic Flutter application for rendering contextual cards with multiple design patterns and seamless API integration.

## 📦 Features
- Multiple Card Design Types (HC3, HC6, HC5, HC9, HC1)
- Dynamic Styling
- API-Driven Rendering
- Cached Image Support
- Error Handling
- Deeplink Integration

## 🛠 Tech Stack
- Flutter
- Dart
- HTTP
- Cached Network Image
- Shared Preferences

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.10+)
- Dart SDK
- Android Studio/VS Code

### 📂 Project Structure

```plaintext
lib/
├── models/        # Data models
├── services/      # API & storage logic
├── widgets/       # UI components
├── home_screen/   # Home screen implementation
└── main.dart      # Entry point
lib/
├── models/        # Data models
├── services/      # API & storage logic
├── widgets/       # UI components
├── home_screen/   # Home screen implementation
└── main.dart      # Entry point
```
### 📦 Dependencies

```plaintext
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  cached_network_image: ^3.3.0
  shared_preferences: ^2.2.1

```

### 🔧 Configuration

```plaintext
- Update lib/services/api_service.dart with your API endpoint
- Customize card designs in respective widget files

```

### 📞 Contact

```plaintext
Pulket - pulket94@gmail.com
Project Link: https://github.com/pulket/fampay
```

### Installation
```bash
# Clone the repository
git clone https://github.com/pulket/fampay.git

# Navigate to project directory
cd fampay

# Install dependencies
flutter pub get

# Run the application
flutter run
