# Flutter Riverpod Clean Architecture

This project demonstrates a Flutter application using clean architecture pattern with Riverpod for state management.

## Documentation

Comprehensive documentation is available in the [docs](docs/README.md) directory:

- [Product Requirements Document](prd.md)
- [Architecture Diagrams](docs/architecture-diagram.md)
- [Feature Implementation Guide](docs/feature-guide.md)
- [API Integration Guide](docs/api-integration.md)
- [State Management Guide](docs/state-management.md)

## Project Structure

The project follows a feature-first organization with clean architecture:

```
lib/
├── feature/             # Features using clean architecture
│   ├── product/         # Example feature
│   │   ├── data/        # Data layer
│   │   ├── domain/      # Domain layer
│   │   └── presentation/# Presentation layer
├── core/                # Core functionality
├── auth/                # Authentication
└── route/               # Navigation
```

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate code
4. Run the application with `flutter run`
