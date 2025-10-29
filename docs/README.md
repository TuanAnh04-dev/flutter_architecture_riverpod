# Flutter Riverpod Clean Architecture Documentation

This documentation provides comprehensive information about the Flutter Riverpod Clean Architecture implementation used in this project. It includes architecture diagrams, guides for creating new features, and best practices for state management and API integration.

## Table of Contents

1. [Product Requirements Document](../prd.md)
2. [Architecture Diagrams](architecture-diagram.md)
3. [Feature Implementation Guide](feature-guide.md)
4. [API Integration Guide](api-integration.md)
5. [State Management Guide](state-management.md)

## Overview

This project implements clean architecture with Riverpod for state management. The clean architecture pattern divides the codebase into three main layers:

- **Presentation Layer**: UI components and state management
- **Domain Layer**: Business logic and rules
- **Data Layer**: Data sources and repositories

The architecture follows a dependency rule where dependencies flow inward, with the domain layer at the center having no dependencies on the outer layers.

## Quick Start

To create a new feature following the clean architecture pattern:

1. Create the feature directory structure following the [Feature Implementation Guide](feature-guide.md)
2. Implement the domain layer (entities, repository interfaces, use cases)
3. Implement the data layer (models, data sources, repository implementations)
4. Implement the presentation layer (providers, pages, widgets)
5. Generate code with `flutter pub run build_runner build --delete-conflicting-outputs`
6. Add navigation routes in `app_route.dart`

## Key Technologies

- **Flutter**: UI framework
- **Riverpod**: State management and dependency injection
- **Dio**: HTTP client for API communication
- **go_router**: Navigation and routing
- **dartz**: Functional programming with Either type for error handling
- **flutter_secure_storage**: Secure storage for sensitive information

## Further Reading

- [Architecture Diagrams](architecture-diagram.md): Visual representations of the architecture
- [Feature Implementation Guide](feature-guide.md): Step-by-step guide for implementing new features
- [API Integration Guide](api-integration.md): Guide for integrating with APIs
- [State Management Guide](state-management.md): Guide for state management with Riverpod
