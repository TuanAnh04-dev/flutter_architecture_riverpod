import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/core/network/api_client.dart';
import 'package:px1_mobile/feature/product/data/data_sources/product_remote_datasource.dart';
import 'package:px1_mobile/feature/product/data/repositories/product_repositories_impl.dart';
import 'package:px1_mobile/feature/product/domain/entities/product.dart';
import 'package:px1_mobile/feature/product/domain/use_cases/get_product.dart';
import 'package:px1_mobile/feature/product/domain/use_cases/get_product_by_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'product_provider.g.dart';

@riverpod
ApiClient apiClinet(Ref ref) {
  return ApiClient(Dio(), ref);
}

// Provider cho DataSource
@riverpod
ProductRemoteDataSource productRemoteDataSource(Ref ref) {
  return ProductRemoteDataSourceImpl(ref.watch(apiClinetProvider));
}

// Provider cho Repository
@riverpod
ProductRepositoryImpl productRepository(Ref ref) {
  return ProductRepositoryImpl(ref.watch(productRemoteDataSourceProvider));
}

// Provider cho UseCase - Get Products
@riverpod
GetProducts getProductsUseCase(Ref ref) {
  return GetProducts(ref.watch(productRepositoryProvider));
}

// Provider cho UseCase - Get Product Detail
@riverpod
GetProductDetail getProductDetailUseCase(Ref ref) {
  return GetProductDetail(ref.watch(productRepositoryProvider));
}

@riverpod
class ProductsNotifier extends _$ProductsNotifier {
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

  void filterByCategory(String category) {
    state = AsyncValue.data(
      state.value?.where((p) => p.category == category).toList() ?? [],
    );
  }
}

// AsyncNotifier cho product detail
@riverpod
class ProductDetailNotifier extends _$ProductDetailNotifier {
  @override
  Future<Product?> build(String productId) async {
    return _fetchProductDetail(productId);
  }

  Future<Product?> _fetchProductDetail(String id) async {
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
