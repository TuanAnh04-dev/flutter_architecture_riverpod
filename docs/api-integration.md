# API Integration Guide

This guide explains how to implement API integration using the clean architecture pattern with Dio for HTTP requests and proper error handling.

## Table of Contents

1. [API Client Setup](#api-client-setup)
2. [Creating Data Sources](#creating-data-sources)
3. [Handling Responses](#handling-responses)
4. [Error Handling](#error-handling)
5. [Authentication](#authentication)
6. [Testing API Integration](#testing-api-integration)

## API Client Setup

The project uses a centralized `ApiClient` class that wraps Dio to provide a consistent interface for making API requests. This class handles common configuration like base URLs, timeouts, and request interceptors.

```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/auth/auth_interceptor.dart';

class ApiClient {
  final Dio dio;
  final Ref ref;

  ApiClient(Dio? dio, this.ref) : dio = dio ?? Dio() {
    this.dio.options.baseUrl = 'https://api.example.com/v1';
    this.dio.options.connectTimeout = const Duration(seconds: 30);
    this.dio.options.receiveTimeout = const Duration(seconds: 30);
    this.dio.interceptors.add(AuthInterceptor(ref));
    this.dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<Response> get(String path) async {
    return await dio.get(path);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }

  // Add other methods as needed (put, delete, patch, etc.)
}
```

## Creating Data Sources

Data sources are responsible for communicating with external services (APIs, databases, etc.). Create a remote data source for your feature:

```dart
import '../../../../core/error.dart/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/your_model.dart';

abstract class YourRemoteDataSource {
  Future<List<YourModel>> getItems();
  Future<YourModel> getItemById(String id);
  Future<YourModel> createItem(YourModel item);
  Future<YourModel> updateItem(String id, YourModel item);
  Future<void> deleteItem(String id);
}

class YourRemoteDataSourceImpl implements YourRemoteDataSource {
  final ApiClient apiClient;

  YourRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<YourModel>> getItems() async {
    try {
      final response = await apiClient.get('/items');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['items'];
        return data.map((json) => YourModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load items');
      }
    } catch (e) {
      throw ServerException('Failed to load items: $e');
    }
  }

  @override
  Future<YourModel> getItemById(String id) async {
    try {
      final response = await apiClient.get('/items/$id');
      if (response.statusCode == 200) {
        return YourModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to load item');
      }
    } catch (e) {
      throw ServerException('Failed to load item: $e');
    }
  }

  @override
  Future<YourModel> createItem(YourModel item) async {
    try {
      final response = await apiClient.post(
        '/items',
        data: item.toJson(),
      );
      if (response.statusCode == 201) {
        return YourModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to create item');
      }
    } catch (e) {
      throw ServerException('Failed to create item: $e');
    }
  }

  @override
  Future<YourModel> updateItem(String id, YourModel item) async {
    try {
      final response = await apiClient.put(
        '/items/$id',
        data: item.toJson(),
      );
      if (response.statusCode == 200) {
        return YourModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to update item');
      }
    } catch (e) {
      throw ServerException('Failed to update item: $e');
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    try {
      final response = await apiClient.delete('/items/$id');
      if (response.statusCode != 204) {
        throw ServerException('Failed to delete item');
      }
    } catch (e) {
      throw ServerException('Failed to delete item: $e');
    }
  }
}
```

## Handling Responses

When handling API responses, follow these steps:

1. Check the status code to determine if the request was successful
2. Parse the response body into your model classes
3. Convert models to domain entities when returning from repositories
4. Handle errors appropriately

Example of response handling:

```dart
Future<List<YourModel>> getItems() async {
  try {
    final response = await apiClient.get('/items');

    // Check status code
    if (response.statusCode == 200) {
      // Parse response body
      final List<dynamic> data = response.data['items'];

      // Map to model objects
      return data.map((json) => YourModel.fromJson(json)).toList();
    } else {
      // Throw appropriate exception
      throw ServerException(
        'Failed to load items. Status code: ${response.statusCode}',
      );
    }
  } on DioException catch (e) {
    // Handle Dio specific errors
    if (e.type == DioExceptionType.connectionTimeout) {
      throw NetworkException('Connection timeout');
    } else {
      throw ServerException('Failed to load items: ${e.message}');
    }
  } catch (e) {
    // Handle other errors
    throw ServerException('Unexpected error: $e');
  }
}
```

## Error Handling

Proper error handling is crucial for providing a good user experience. The project uses the following approach:

1. **Exceptions**: Thrown in the data sources when errors occur
2. **Failures**: Returned from repositories to the domain layer
3. **Either type**: Used to represent success or failure outcomes

Example of repository implementation with error handling:

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error.dart/exceptions.dart';
import '../../../../core/error.dart/failure.dart';
import '../../domain/entities/your_entity.dart';
import '../../domain/repositories/your_repository.dart';
import '../data_sources/your_remote_data_source.dart';

class YourRepositoryImpl implements YourRepository {
  final YourRemoteDataSource remoteDataSource;

  YourRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<YourEntity>>> getItems() async {
    try {
      final result = await remoteDataSource.getItems();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, YourEntity>> createItem(YourEntity item) async {
    try {
      // Convert entity to model
      final itemModel = YourModel.fromEntity(item);

      // Make API call
      final result = await remoteDataSource.createItem(itemModel);

      // Return converted entity
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
```

## Authentication

The application uses JWT token authentication with a custom interceptor to automatically add the token to requests:

```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_provider.dart';

class AuthInterceptor extends Interceptor {
  final Ref ref;

  AuthInterceptor(this.ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final authState = ref.read(authProvider);

    if (authState.isLoggedIn) {
      options.headers['Authorization'] = 'Bearer ${authState.userAuth?.accesstoken}';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 errors by logging out the user
    if (err.response?.statusCode == 401) {
      ref.read(authProvider.notifier).logout();
    }

    super.onError(err, handler);
  }
}
```

To make an authenticated request, simply use the ApiClient as normal. The interceptor will automatically add the authentication headers.

## Testing API Integration

To test API integration, you can use the following approaches:

### 1. Manual Testing

Create a simple UI to test API calls:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/your_provider.dart';

class ApiTestPage extends ConsumerWidget {
  const ApiTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(yourItemsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('API Test')),
      body: Center(
        child: itemsAsync.when(
          data: (items) => ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(items[index].name),
            ),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.refresh(yourItemsProvider),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
```

### 2. Automated Testing

Create unit tests for your data sources using mock Dio instances:

```dart
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:your_app/core/network/api_client.dart';
import 'package:your_app/feature/your_feature/data/data_sources/your_remote_data_source.dart';

class MockDio extends Mock implements Dio {}
class MockRef extends Mock implements Ref {}

void main() {
  late MockDio mockDio;
  late MockRef mockRef;
  late ApiClient apiClient;
  late YourRemoteDataSourceImpl dataSource;

  setUp(() {
    mockDio = MockDio();
    mockRef = MockRef();
    apiClient = ApiClient(mockDio, mockRef);
    dataSource = YourRemoteDataSourceImpl(apiClient);
  });

  group('getItems', () {
    test('should return list of items when API call is successful', () async {
      // Arrange
      final response = Response(
        data: {
          'items': [
            {'id': 1, 'name': 'Item 1', 'description': 'Description 1'},
            {'id': 2, 'name': 'Item 2', 'description': 'Description 2'},
          ]
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: '/items'),
      );

      when(mockDio.get('/items')).thenAnswer((_) async => response);

      // Act
      final result = await dataSource.getItems();

      // Assert
      expect(result.length, 2);
      expect(result[0].id, 1);
      expect(result[0].name, 'Item 1');
      expect(result[1].id, 2);
      expect(result[1].name, 'Item 2');
    });

    test('should throw ServerException when API call fails', () async {
      // Arrange
      when(mockDio.get('/items')).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/items'),
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(path: '/items'),
        ),
      ));

      // Act & Assert
      expect(() => dataSource.getItems(), throwsA(isA<ServerException>()));
    });
  });
}
```
