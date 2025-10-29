# Project Structure

## Directory Organization

```
lib/
├── auth/                     # Authentication Module
│   ├── auth_provider.dart    # Authentication state management
│   ├── login_screen.dart     # Login UI
│   └── UserAuth.dart         # User authentication model
│
├── core/                     # Core Functionality
│   ├── constants/           # API endpoints and response models
│   ├── language/           # Internationalization
│   ├── service/           # Network and other services
│   └── util/              # Utilities and helpers
│
├── module/                   # Feature Modules
│   ├── base/               # Base functionality
│   ├── category_setting/   # Category management
│   ├── insurance/         # Insurance feature
│   ├── requirement/       # Requirements feature
│   ├── trolle/           # Trello clone feature
│   └── user/             # User management
│
├── route/                    # Navigation
│   └── app_route.dart       # Route definitions
│
└── screen/                   # Main UI Screens
    ├── Dashboard.dart
    ├── Homepage.dart
    └── trolle/             # Trello feature screens
```

## Module Structure

Each feature module follows a consistent structure:

```
module/feature_name/
├── logic/           # Business logic and state management
├── model/          # Data models
└── screen/         # UI components
```

## Key Files

- `main.dart`: Application entry point and configuration
- `auth_provider.dart`: Central authentication state management
- `app_route.dart`: Route definitions and navigation logic