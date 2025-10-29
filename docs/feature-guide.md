# Feature Implementation Guide

This guide provides step-by-step instructions for implementing new features following the clean architecture pattern with Riverpod.

## Table of Contents

1. [Directory Structure](#directory-structure)
2. [Domain Layer Implementation](#domain-layer-implementation)
3. [Data Layer Implementation](#data-layer-implementation)
4. [Presentation Layer Implementation](#presentation-layer-implementation)
5. [Code Generation](#code-generation)
6. [Navigation Configuration](#navigation-configuration)
7. [Feature Checklist](#feature-checklist)

## Directory Structure

Create the following directory structure for your feature:

```
lib/feature/your_feature/
├── data/
│   ├── data_sources/
│   │   └── your_feature_remote_data_source.dart
│   ├── models/
│   │   └── your_feature_model.dart
│   └── repositories/
│       └── your_feature_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── your_feature.dart
│   ├── repositories/
│   │   └── your_feature_repository.dart
│   └── use_cases/
│       └── get_your_feature.dart
└── presentation/
    ├── pages/
    │   └── your_feature_page.dart
    ├── providers/
    │   └── your_feature_provider.dart
    └── widgets/
        └── your_feature_widget.dart
```

## Domain Layer Implementation

Start with the domain layer to define your business logic without dependencies on external frameworks.

### 1. Entity

Create your entity in `domain/entities/your_feature.dart`:

```dart
class YourFeature {
  final int id;
  final String name;
  final String description;

  YourFeature({
    required this.id,
    required this.name,
    required this.description,
  });
}
```

### 2. Repository Interface

Define the repository interface in `domain/repositories/your_feature_repository.dart`:

```dart
import 'package:dartz/dartz.dart';
import '../entities/your_feature.dart';
import '../../../../core/error.dart/failure.dart';

abstract class YourFeatureRepository {
  Future<Either<Failure, List<YourFeature>>> getYourFeatures();
  Future<Either<Failure, YourFeature>> getYourFeatureById(String id);
}
```

### 3. Use Cases

Create use cases for your business operations in `domain/use_cases/get_your_feature.dart`:

```dart
import 'package:dartz/dartz.dart';
import '../entities/your_feature.dart';
import '../repositories/your_feature_repository.dart';
import '../../../../core/error.dart/failure.dart';

class GetYourFeatures {
  final YourFeatureRepository repository;

  GetYourFeatures(this.repository);

  Future<Either<Failure, List<YourFeature>>> call() async {
    return await repository.getYourFeatures();
  }
}
```

For a use case with parameters:

```dart
class GetYourFeatureDetail {
  final YourFeatureRepository repository;

  GetYourFeatureDetail(this.repository);

  Future<Either<Failure, YourFeature>> call(String id) async {
    return await repository.getYourFeatureById(id);
  }
}
```

## Data Layer Implementation

Implement the data layer to handle external data sources and mapping.

### 1. Model

Create your model in `data/models/your_feature_model.dart`:

```dart
import '../../domain/entities/your_feature.dart';

class YourFeatureModel extends YourFeature {
  YourFeatureModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory YourFeatureModel.fromJson(Map<String, dynamic> json) {
    return YourFeatureModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  YourFeature toEntity() {
    return YourFeature(
      id: id,
      name: name,
      description: description,
    );
  }
}
```

### 2. Data Source

Create your data source in `data/data_sources/your_feature_remote_data_source.dart`:

```dart
import '../../../../core/error.dart/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/your_feature_model.dart';

abstract class YourFeatureRemoteDataSource {
  Future<List<YourFeatureModel>> getYourFeatures();
  Future<YourFeatureModel> getYourFeatureById(String id);
}

class YourFeatureRemoteDataSourceImpl implements YourFeatureRemoteDataSource {
  final ApiClient apiClient;

  YourFeatureRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<YourFeatureModel>> getYourFeatures() async {
    try {
      final response = await apiClient.get('/your-features');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['items']; // Adjust based on your API response structure
        return data.map((json) => YourFeatureModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load your features');
      }
    } catch (e) {
      throw ServerException('Failed to load your features: $e');
    }
  }

  @override
  Future<YourFeatureModel> getYourFeatureById(String id) async {
    try {
      final response = await apiClient.get('/your-features/$id');
      if (response.statusCode == 200) {
        return YourFeatureModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to load your feature');
      }
    } catch (e) {
      throw ServerException('Failed to load your feature: $e');
    }
  }
}
```

### 3. Repository Implementation

Implement the repository in `data/repositories/your_feature_repository_impl.dart`:

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error.dart/exceptions.dart';
import '../../../../core/error.dart/failure.dart';
import '../../domain/entities/your_feature.dart';
import '../../domain/repositories/your_feature_repository.dart';
import '../data_sources/your_feature_remote_data_source.dart';

class YourFeatureRepositoryImpl implements YourFeatureRepository {
  final YourFeatureRemoteDataSource remoteDataSource;

  YourFeatureRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<YourFeature>>> getYourFeatures() async {
    try {
      final result = await remoteDataSource.getYourFeatures();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return Left(NetworkFailure('Failed to load your features'));
    }
  }

  @override
  Future<Either<Failure, YourFeature>> getYourFeatureById(String id) async {
    try {
      final result = await remoteDataSource.getYourFeatureById(id);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return Left(NetworkFailure('Failed to load your feature'));
    }
  }
}
```

## Presentation Layer Implementation

Implement the presentation layer using Riverpod for state management.

### 1. Riverpod Providers

Create your providers in `presentation/providers/your_feature_provider.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../data/data_sources/your_feature_remote_data_source.dart';
import '../../data/repositories/your_feature_repository_impl.dart';
import '../../domain/entities/your_feature.dart';
import '../../domain/use_cases/get_your_feature.dart';

part 'your_feature_provider.g.dart';

@riverpod
ApiClient apiClient(ApiClientRef ref) {
  return ApiClient(Dio(), ref);
}

@riverpod
YourFeatureRemoteDataSource yourFeatureRemoteDataSource(YourFeatureRemoteDataSourceRef ref) {
  return YourFeatureRemoteDataSourceImpl(ref.watch(apiClientProvider));
}

@riverpod
YourFeatureRepositoryImpl yourFeatureRepository(YourFeatureRepositoryRef ref) {
  return YourFeatureRepositoryImpl(ref.watch(yourFeatureRemoteDataSourceProvider));
}

@riverpod
GetYourFeatures getYourFeaturesUseCase(GetYourFeaturesUseCaseRef ref) {
  return GetYourFeatures(ref.watch(yourFeatureRepositoryProvider));
}

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
      (failure) => throw Exception(failure.message),
      (features) => features,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchYourFeatures());
  }
}
```

### 2. UI Page

Create your page in `presentation/pages/your_feature_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/your_feature_provider.dart';
import '../widgets/your_feature_widget.dart';

class YourFeaturePage extends ConsumerWidget {
  const YourFeaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yourFeaturesAsyncValue = ref.watch(yourFeaturesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Features'),
      ),
      body: yourFeaturesAsyncValue.when(
        data: (features) => ListView.builder(
          itemCount: features.length,
          itemBuilder: (context, index) {
            return YourFeatureWidget(feature: features[index]);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(yourFeaturesNotifierProvider.notifier).refresh(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
```

### 3. UI Widget

Create your widget in `presentation/widgets/your_feature_widget.dart`:

```dart
import 'package:flutter/material.dart';
import '../../domain/entities/your_feature.dart';

class YourFeatureWidget extends StatelessWidget {
  final YourFeature feature;

  const YourFeatureWidget({
    Key? key,
    required this.feature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(feature.name),
        subtitle: Text(feature.description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to detail page
        },
      ),
    );
  }
}
```

## Code Generation

Run the following command to generate the necessary Riverpod code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Navigation Configuration

Update your route configuration in `route/app_route.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../feature/your_feature/presentation/pages/your_feature_page.dart';

// Add to your existing GoRouter configuration
GoRoute(
  path: '/your-feature',
  builder: (context, state) => const YourFeaturePage(),
),
```

## Feature Checklist

Use this checklist to ensure your feature implementation follows all the necessary steps:

- [ ] Created complete directory structure
- [ ] Implemented domain layer (entity, repository interface, use cases)
- [ ] Implemented data layer (model, data source, repository implementation)
- [ ] Implemented presentation layer (providers, pages, widgets)
- [ ] Generated code with build_runner
- [ ] Added navigation route
- [ ] Implemented error handling
- [ ] Added appropriate loading states
- [ ] Verified API integration
- [ ] Tested feature functionality
