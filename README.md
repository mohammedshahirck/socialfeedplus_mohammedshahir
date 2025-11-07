# 🌐 SocialFeed+ — Flutter App

A modern, offline-first social media app built with **Flutter**, featuring AI-powered captions, clean architecture, and GetX state management.

---

## 🧠 Overview

**SocialFeed+** lets users:
- Log in (dummy authentication)
- View a social feed
- Create posts (text + image)
- Generate captions via AI
- Like & comment locally
- Use the app offline

---

## ✨ Key Features

- 🔐 **Authentication** — Dummy login with session persistence  
- 🧠 **AI Caption Generator** — Fetch smart captions using `https://dummyjson.com/quotes`  
- 💾 **Offline First** — Local data storage with Hive  
- 💬 **Social Feed** — Like, comment, and paginate posts  
- 🌗 **Dark/Light Mode** — Theme toggle with GetX  
- 🎨 **Modern UI** — Responsive Material Design + custom widgets  

---

## 🏗 Architecture

Follows **Clean Architecture** principles:
```
lib/
├── core/
│   ├── bindings/          # Dependency injection bindings
│   ├── routes/            # App routing configuration
│   ├── services/          # API services and utilities
│   ├── theme/             # App theming and colors
│   └── utils/             # Utility functions
├── features/
│   ├── auth/              # Authentication feature
│   │   ├── controllers/   # Business logic
│   │   ├── models/        # Data models
│   │   ├── views/         # UI screens
│   │   └── widgets/       # Custom widgets
│   ├── feed/              # Social feed feature
│   │   ├── controllers/   # Feed management logic
│   │   ├── models/        # Post models
│   │   ├── views/         # Feed screens
│   │   └── widgets/       # Feed-specific widgets
│   └── post/              # Post creation feature
│       ├── controllers/   # Post creation logic
│       ├── models/        # Comment models
│       ├── views/         # Post creation screens
│       └── widgets/       # Post-related widgets
├── shared/
│   └── widgets/           # Reusable UI components
└── main.dart              # App entry point
```

yaml
Copy code

- **State Management**: GetX  
- **Local Storage**: Hive + SharedPreferences  
- **Networking**: Dio  

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.9.2)
- Android Studio / VS Code

### Installation
```bash
git clone <repository-url>
cd socialfeed_mohammedshahir
flutter pub get
flutter packages pub run build_runner build
flutter run
🧩 Tech Stack
Category	Package
State Management	get
Database	hive, hive_flutter
Storage	shared_preferences
API Calls	dio
Image Picker	image_picker
UI	flutter_svg, cupertino_icons

🏆 Highlights
🧱 Clean Architecture

💾 Offline First

⚡ Smooth Pagination

🌗 Dark Mode Support

🎨 Modern Material UI

📱 Cross-Platform Ready

👨‍💻 Author
Mohammed Shahir
Flutter Developer passionate about scalable, user-centric mobile apps.

🧾 Developed as part of the Flutter Developer Assignment (SocialFeed+), demonstrating architecture design, API integration, and UX best practices.
