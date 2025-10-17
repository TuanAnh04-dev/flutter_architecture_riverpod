# State Management

## Riverpod Implementation

The project uses Riverpod for state management with the following pattern:

### State Classes

```dart
class FeatureState {
  final bool isLoading;
  final List<Data> data;
  final String? error;
  
  // Constructor and copyWith implementation
}
```

### Notifiers

```dart
class FeatureNotifier extends Notifier<FeatureState> {
  @override
  FeatureState build() {
    // Initial state setup
  }

  // State manipulation methods
  Future<bool> getData() async {
    // API calls and state updates
  }
}
```

### Providers

```dart
final featureProvider = NotifierProvider<FeatureNotifier, FeatureState>(FeatureNotifier.new);
```

## State Flow

1. UI triggers action through provider
2. Notifier handles business logic
3. State is updated through copyWith
4. UI rebuilds with new state

## Key Concepts

### State Immutability
- All state classes are immutable
- Updates happen through copyWith
- New state instances trigger UI updates

### Error Handling
- Error states are part of the state class
- Error handling at the notifier level
- UI responds to error states

### Loading States
- Loading indicator management
- Consistent loading state pattern
- UI feedback during operations