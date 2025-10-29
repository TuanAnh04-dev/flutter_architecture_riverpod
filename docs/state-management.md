# State Management with Riverpod

This guide explains how to implement state management using Riverpod in the Flutter clean architecture project.

## Table of Contents

1. [Introduction to Riverpod](#introduction-to-riverpod)
2. [Provider Types](#provider-types)
3. [Setting Up Providers](#setting-up-providers)
4. [AsyncNotifier for Async Operations](#asyncnotifier-for-async-operations)
5. [Dependency Injection](#dependency-injection)
6. [Consuming Providers in UI](#consuming-providers-in-ui)
7. [Code Generation](#code-generation)
8. [Best Practices](#best-practices)

## Introduction to Riverpod

Riverpod is a state management library for Flutter that provides a simple way to access, create and combine state while handling all edge cases. It's designed as an improvement over the Provider package, offering:

- Compile-time safety
- Better testability
- No need for a context
- Code generation support
- Better error handling
- Easy dependency overriding

In our clean architecture implementation, Riverpod serves as:

1. A state management solution for UI components
2. A dependency injection system for the application
3. A way to handle async operations with proper loading and error states

## Provider Types

Riverpod offers several provider types, each suited for different use cases:

1. **Provider**: For simple immutable values
2. **StateProvider**: For simple mutable state
3. **FutureProvider**: For async operations that don't need to be updated
4. **StreamProvider**: For streams of data
5. **StateNotifierProvider**: For complex state with immutable state objects
6. **AsyncNotifierProvider**: For complex async state with immutable state objects

In our project, we primarily use:

- **Provider**: For dependency injection
- **AsyncNotifierProvider**: For async state management (created with code generation)

## Setting Up Providers

Providers are set up in the presentation layer, typically in a `providers` directory for each feature. Here's how to set up the dependency injection providers:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../data/data_sources/your_feature_remote_data_source.dart';
import '../../data/repositories/your_feature_repository_impl.dart';
import '../../domain/use_cases/get_your_feature.dart';

part 'your_feature_provider.g.dart';

// API Client Provider
@riverpod
ApiClient apiClient(ApiClientRef ref) {
  return ApiClient(Dio(), ref);
}

// Data Source Provider
@riverpod
YourFeatureRemoteDataSource yourFeatureRemoteDataSource(YourFeatureRemoteDataSourceRef ref) {
  return YourFeatureRemoteDataSourceImpl(ref.watch(apiClientProvider));
}

// Repository Provider
@riverpod
YourFeatureRepositoryImpl yourFeatureRepository(YourFeatureRepositoryRef ref) {
  return YourFeatureRepositoryImpl(ref.watch(yourFeatureRemoteDataSourceProvider));
}

// Use Case Provider
@riverpod
GetYourFeatures getYourFeaturesUseCase(GetYourFeaturesUseCaseRef ref) {
  return GetYourFeatures(ref.watch(yourFeatureRepositoryProvider));
}
```

## AsyncNotifier for Async Operations

AsyncNotifier is a powerful way to handle async operations with proper loading, error, and data states. Here's how to implement it:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/your_feature.dart';

part 'your_feature_provider.g.dart';

@riverpod
class YourFeaturesNotifier extends _$YourFeaturesNotifier {
  @override
  Future<List<YourFeature>> build() async {
    return _fetchYourFeatures();
  }

  Future<List<YourFeature>> _fetchYourFeatures() async {
    final useCase = ref.read(getYourFeaturesUseCaseProvider);
    final result = await useCase();

    return result.fold(
      (failure) => throw Exception(failure.message), // Convert failure to exception
      (features) => features, // Return the features on success
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading(); // Set loading state
    state = await AsyncValue.guard(() => _fetchYourFeatures()); // Handle errors automatically
  }

  // Add more methods for CRUD operations
  Future<void> addFeature(YourFeature feature) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(addYourFeatureUseCaseProvider);
    final result = await useCase(feature);

    result.fold(
      (failure) {
        // Show error or handle failure
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (success) async {
        // Refresh the list after successful addition
        state = await AsyncValue.guard(() => _fetchYourFeatures());
      },
    );
  }
}
```

### For Providers with Parameters

Sometimes you need to create providers that take parameters, like fetching a specific item by ID:

```dart
@riverpod
class YourFeatureDetailNotifier extends _$YourFeatureDetailNotifier {
  @override
  Future<YourFeature?> build(String id) async {
    return _fetchYourFeature(id);
  }

  Future<YourFeature?> _fetchYourFeature(String id) async {
    final useCase = ref.read(getYourFeatureDetailUseCaseProvider);
    final result = await useCase(id);

    return result.fold(
      (failure) => throw Exception(failure.message),
      (feature) => feature,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchYourFeature(id)); // 'id' is available from the build parameter
  }
}
```

## Dependency Injection

Riverpod serves as our dependency injection system. We create a chain of providers where each component depends on its dependencies through providers.

Here's the typical dependency injection chain:

1. Core services (ApiClient, SharedPreferences, etc.)
2. Data sources (depend on core services)
3. Repositories (depend on data sources)
4. Use cases (depend on repositories)
5. UI state (depends on use cases)

This approach ensures:

- Easy testing through dependency overriding
- Proper scoping of dependencies
- Automatic disposal of resources when no longer needed

## Consuming Providers in UI

To use providers in your UI, use the ConsumerWidget or ConsumerStatefulWidget:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/your_feature_provider.dart';

class YourFeaturePage extends ConsumerWidget {
  const YourFeaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider to rebuild when state changes
    final featuresAsync = ref.watch(yourFeaturesNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Features')),
      body: featuresAsync.when(
        // Show data when available
        data: (features) => features.isEmpty
            ? const Center(child: Text('No features found'))
            : ListView.builder(
                itemCount: features.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(features[index].name),
                  subtitle: Text(features[index].description),
                ),
              ),
        // Show loading indicator
        loading: () => const Center(child: CircularProgressIndicator()),
        // Show error message
        error: (error, stack) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Use read to perform actions without rebuilding
        onPressed: () => ref.read(yourFeaturesNotifierProvider.notifier).refresh(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
```

### Using Providers with Parameters

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/your_feature_provider.dart';

class YourFeatureDetailPage extends ConsumerWidget {
  final String featureId;

  const YourFeatureDetailPage({
    Key? key,
    required this.featureId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Pass the parameter to the provider
    final featureAsync = ref.watch(yourFeatureDetailNotifierProvider(featureId));

    return Scaffold(
      appBar: AppBar(title: const Text('Feature Detail')),
      body: featureAsync.when(
        data: (feature) => feature == null
            ? const Center(child: Text('Feature not found'))
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 8),
                    Text(feature.description),
                  ],
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
      ),
    );
  }
}
```

## Code Generation

Riverpod supports code generation to reduce boilerplate. To use it:

1. Add the necessary dependencies to pubspec.yaml:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.6.1
  riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1

dev_dependencies:
  build_runner: ^2.4.7
  riverpod_generator: ^2.6.5
```

2. Create your providers with annotations as shown in the examples above

3. Run the code generator:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Best Practices

1. **Keep Providers Focused**: Each provider should have a single responsibility

2. **Use AsyncValue for All Async Operations**: The `when` method makes it easy to handle loading, error, and data states

3. **Proper Error Handling**: Use the `fold` method from Either to properly handle success and failure cases

4. **Use ref.watch Carefully**: Only watch providers that you need to rebuild the UI when they change

5. **Override Providers in Tests**: Take advantage of Riverpod's easy provider overriding for testing

6. **Organize Providers by Feature**: Keep related providers together in the same file

7. **Cache Data When Appropriate**: For performance optimization, consider caching data in providers:

```dart
@riverpod
class YourFeaturesNotifier extends _$YourFeaturesNotifier {
  @override
  Future<List<YourFeature>> build() async {
    // Check if we already have cached data
    if (state.hasValue && state.value!.isNotEmpty) {
      return state.value!;
    }

    // Otherwise fetch from source
    return _fetchYourFeatures();
  }

  // Rest of implementation...
}
```

8. **Use Family Providers for Parameterized Data**: When you need to pass parameters to a provider, use the family approach

9. **Handle Disposal**: Riverpod automatically handles disposal of resources when providers are no longer used
