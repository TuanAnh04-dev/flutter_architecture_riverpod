# Clean Architecture với Riverpod trong Flutter

Hướng dẫn chi tiết cách xây dựng ứng dụng Flutter với Clean Architecture và Riverpod 2.x, sử dụng AsyncNotifier để quản lý state.

## 📁 Cấu trúc thư mục

```
lib/
├── core/
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   └── network/
│       └── api_client.dart
├── features/
│   └── product/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── product_remote_datasource.dart
│       │   ├── models/
│       │   │   └── product_model.dart
│       │   └── repositories/
│       │       └── product_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── product.dart
│       │   ├── repositories/
│       │   │   └── product_repository.dart
│       │   └── usecases/
│       │       ├── get_products.dart
│       │       └── get_product_detail.dart
│       └── presentation/
│           ├── providers/
│           │   └── product_provider.dart
│           ├── pages/
│           │   ├── product_list_page.dart
│           │   └── product_detail_page.dart
│           └── widgets/
│               └── product_card.dart
└── main.dart
```

---

## 🔧 Bước 1: Core - Error Handling

### `core/error/exceptions.dart`

```dart
class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server error occurred']);
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Cache error occurred']);
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'No internet connection']);
}
```

### `core/error/failures.dart`

```dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}
```

### `core/network/api_client.dart`

```dart
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient({Dio? dio}) : dio = dio ?? Dio() {
    this.dio.options.baseUrl = 'https://fakestoreapi.com';
    this.dio.options.connectTimeout = const Duration(seconds: 30);
    this.dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<Response> get(String path) async {
    return await dio.get(path);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }
}
```

---

## 🎯 Bước 2: Domain Layer

### `features/product/domain/entities/product.dart`

```dart
class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int ratingCount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
  });
}
```

### `features/product/domain/repositories/product_repository.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> getProductById(int id);
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category);
}
```

### `features/product/domain/usecases/get_products.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getProducts();
  }
}
```

### `features/product/domain/usecases/get_product_detail.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductDetail {
  final ProductRepository repository;

  GetProductDetail(this.repository);

  Future<Either<Failure, Product>> call(int id) async {
    return await repository.getProductById(id);
  }
}
```

---

## 📊 Bước 3: Data Layer

### `features/product/data/models/product_model.dart`

```dart
import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
    required super.ratingCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: (json['rating']['rate'] as num).toDouble(),
      ratingCount: json['rating']['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': {
        'rate': rating,
        'count': ratingCount,
      },
    };
  }

  Product toEntity() {
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating,
      ratingCount: ratingCount,
    );
  }
}
```

### `features/product/data/datasources/product_remote_datasource.dart`

```dart
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiClient.get('/products');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load products');
      }
    } catch (e) {
      throw ServerException('Failed to load products: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await apiClient.get('/products/$id');
      
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to load product');
      }
    } catch (e) {
      throw ServerException('Failed to load product: $e');
    }
  }
}
```

### `features/product/data/repositories/product_repository_impl.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await remoteDataSource.getProducts();
      return Right(products.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    try {
      final product = await remoteDataSource.getProductById(id);
      return Right(product.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category) async {
    throw UnimplementedError();
  }
}
```

---

## 🎨 Bước 4: Presentation Layer - Providers

### `features/product/presentation/providers/product_provider.dart`

#### ⭐ Cách 1: Sử dụng Code Generation (Khuyến nghị)

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/api_client.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_detail.dart';
import '../../domain/usecases/get_products.dart';

part 'product_provider.g.dart';

// Provider cho ApiClient
@riverpod
ApiClient apiClient(ApiClientRef ref) {
  return ApiClient();
}

// Provider cho DataSource
@riverpod
ProductRemoteDataSource productRemoteDataSource(ProductRemoteDataSourceRef ref) {
  return ProductRemoteDataSourceImpl(ref.watch(apiClientProvider));
}

// Provider cho Repository
@riverpod
ProductRepositoryImpl productRepository(ProductRepositoryRef ref) {
  return ProductRepositoryImpl(ref.watch(productRemoteDataSourceProvider));
}

// Provider cho UseCase - Get Products
@riverpod
GetProducts getProductsUseCase(GetProductsUseCaseRef ref) {
  return GetProducts(ref.watch(productRepositoryProvider));
}

// Provider cho UseCase - Get Product Detail
@riverpod
GetProductDetail getProductDetailUseCase(GetProductDetailUseCaseRef ref) {
  return GetProductDetail(ref.watch(productRepositoryProvider));
}

// AsyncNotifier cho danh sách products
@riverpod
class ProductsNotifier extends _$ProductsNotifier {
  @override
  Future<List<Product>> build() async {
    return _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final useCase = ref.read(getProductsUseCaseProvider);
    final result = await useCase();

    return result.fold(
      (failure) => throw Exception(failure.message),
      (products) => products,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProducts());
  }
}

// AsyncNotifier cho product detail
@riverpod
class ProductDetailNotifier extends _$ProductDetailNotifier {
  @override
  Future<Product?> build(int productId) async {
    return _fetchProductDetail(productId);
  }

  Future<Product?> _fetchProductDetail(int id) async {
    final useCase = ref.read(getProductDetailUseCaseProvider);
    final result = await useCase(id);

    return result.fold(
      (failure) => throw Exception(failure.message),
      (product) => product,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProductDetail(productId));
  }
}
```

**Chạy code generation:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 🔧 Cách 2: Viết thủ công (Không cần code generation)

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_detail.dart';
import '../../domain/usecases/get_products.dart';

// Providers thủ công
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((ref) {
  return ProductRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final productRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  return ProductRepositoryImpl(ref.watch(productRemoteDataSourceProvider));
});

final getProductsUseCaseProvider = Provider<GetProducts>((ref) {
  return GetProducts(ref.watch(productRepositoryProvider));
});

final getProductDetailUseCaseProvider = Provider<GetProductDetail>((ref) {
  return GetProductDetail(ref.watch(productRepositoryProvider));
});

// AsyncNotifier cho danh sách products
class ProductsNotifier extends AutoDisposeAsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    return _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final useCase = ref.read(getProductsUseCaseProvider);
    final result = await useCase();

    return result.fold(
      (failure) => throw Exception(failure.message),
      (products) => products,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProducts());
  }
}

final productsNotifierProvider = 
    AutoDisposeAsyncNotifierProvider<ProductsNotifier, List<Product>>(
  () => ProductsNotifier(),
);

// AsyncNotifier cho product detail
class ProductDetailNotifier extends AutoDisposeFamilyAsyncNotifier<Product?, int> {
  @override
  Future<Product?> build(int arg) async {
    return _fetchProductDetail(arg);
  }

  Future<Product?> _fetchProductDetail(int id) async {
    final useCase = ref.read(getProductDetailUseCaseProvider);
    final result = await useCase(id);

    return result.fold(
      (failure) => throw Exception(failure.message),
      (product) => product,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProductDetail(arg));
  }
}

final productDetailNotifierProvider = 
    AutoDisposeAsyncNotifierProviderFamily<ProductDetailNotifier, Product?, int>(
  () => ProductDetailNotifier(),
);
```

---

## 🖼️ Bước 5: UI - Widgets

### `features/product/presentation/widgets/product_card.dart`

```dart
import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              
              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${product.rating} (${product.ratingCount})',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 📱 Bước 6: UI - Pages

### `features/product/presentation/pages/product_list_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(productsNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: productsState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                'Error: $error',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(productsNotifierProvider.notifier).refresh();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (products) {
          if (products.isEmpty) {
            return const Center(
              child: Text('No products found'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(productsNotifierProvider.notifier).refresh();
            },
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          productId: product.id,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
```

### `features/product/presentation/pages/product_detail_page.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';

class ProductDetailPage extends ConsumerWidget {
  final int productId;

  const ProductDetailPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productDetailNotifierProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(productDetailNotifierProvider(productId).notifier).refresh();
            },
          ),
        ],
      ),
      body: productState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(productDetailNotifierProvider(productId).notifier).refresh();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (product) {
          if (product == null) {
            return const Center(child: Text('Product not found'));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    product.image,
                    height: 300,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 300,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error, size: 60),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 24),
                          const SizedBox(width: 4),
                          Text(
                            '${product.rating}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${product.ratingCount} reviews)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.title} added to cart!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text(
                            'Add to Cart',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

---

## 🚀 Bước 7: Main App

### `main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/product/presentation/pages/product_list_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ProductListPage(),
    );
  }
}
```

---

## 📦 Dependencies

### `pubspec.yaml`

```yaml
name: products_app
description: A Flutter project with Clean Architecture and Riverpod

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.4.10
  riverpod_annotation: ^2.3.5
  
  # Functional Programming
  dartz: ^0.10.1
  
  # Network
  dio: ^5.4.0
  
  # UI
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  
  # Code Generation
  build_runner: ^2.4.7
  riverpod_generator: ^2.3.9
```

---

## ▶️ Chạy ứng dụng

```bash
# 1. Install dependencies
flutter pub get

# 2. Nếu dùng code generation (riverpod_annotation)
flutter pub run build_runner build --delete-conflicting-outputs

# 3. Run app
flutter run
```

---

## 🎯 Flow hoạt động

1. **User mở app** → `ProductListPage` được render
2. **ProductListPage** watch `productsNotifierProvider`
3. **ProductsNotifier.build()** được gọi tự động → gọi `_fetchProducts()`
4. **_fetchProducts()** → gọi `GetProducts` usecase
5. **GetProducts** → gọi `ProductRepository.getProducts()`
6. **ProductRepository** → gọi `ProductRemoteDataSource.getProducts()`
7. **DataSource** → gọi API qua `ApiClient`
8. **Dữ liệu trả về**: API Response → Model → Entity → UI
9. **UI hiển thị** qua `when()` với 3 trạng thái: loading, error, data

### Khi user click vào product:

- Navigate sang `ProductDetailPage` với `productId`
- `productDetailNotifierProvider(productId)` được watch
- Flow tương tự nhưng gọi `GetProductDetail` usecase

---

## 