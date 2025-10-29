# Architecture Overview

## Architecture Pattern

The project implements a hybrid architecture combining elements of Clean Architecture and Feature-First organization. 

### Layers

1. **Presentation Layer** (`screen/`)
   - Contains UI components and widgets
   - Handles user interaction
   - Uses Riverpod providers to access state

2. **Logic Layer** (`module/*/logic/`)
   - Contains business logic
   - Manages state using Riverpod notifiers
   - Handles data transformation and validation

3. **Data Layer** (`module/*/model/`)
   - Contains data models
   - Handles data serialization/deserialization
   - Defines data structures

4. **Core Layer** (`core/`)
   - Contains shared utilities
   - Handles network communication
   - Provides common constants and helpers

### Key Components

- **Auth Module**: Centralized authentication management
- **Core Module**: Shared utilities and services
- **Feature Modules**: Self-contained feature implementations
- **Route Management**: Centralized navigation handling

## Dependency Flow

```
UI Screens → Logic (Notifiers) → Models → Core Services
```

- UI components depend on Logic layer through Riverpod providers
- Logic layer manages state and business operations
- Models handle data structure and transformation
- Core provides shared functionality across all layers