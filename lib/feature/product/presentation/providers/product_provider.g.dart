// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiClinetHash() => r'9af52d5633a23945dbaa940a83c994adf55bbfe3';

/// See also [apiClinet].
@ProviderFor(apiClinet)
final apiClinetProvider = AutoDisposeProvider<ApiClient>.internal(
  apiClinet,
  name: r'apiClinetProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apiClinetHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiClinetRef = AutoDisposeProviderRef<ApiClient>;
String _$productRemoteDataSourceHash() =>
    r'b26178de8b94d828af6caadb0d56630273a03513';

/// See also [productRemoteDataSource].
@ProviderFor(productRemoteDataSource)
final productRemoteDataSourceProvider =
    AutoDisposeProvider<ProductRemoteDataSource>.internal(
      productRemoteDataSource,
      name: r'productRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductRemoteDataSourceRef =
    AutoDisposeProviderRef<ProductRemoteDataSource>;
String _$productRepositoryHash() => r'b58cd195db771be1a50de37cd4eef0fec81fd786';

/// See also [productRepository].
@ProviderFor(productRepository)
final productRepositoryProvider =
    AutoDisposeProvider<ProductRepositoryImpl>.internal(
      productRepository,
      name: r'productRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductRepositoryRef = AutoDisposeProviderRef<ProductRepositoryImpl>;
String _$getProductsUseCaseHash() =>
    r'2f8af3a75e1dcece00345c2cb66cd62c6cedd0a3';

/// See also [getProductsUseCase].
@ProviderFor(getProductsUseCase)
final getProductsUseCaseProvider = AutoDisposeProvider<GetProducts>.internal(
  getProductsUseCase,
  name: r'getProductsUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getProductsUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetProductsUseCaseRef = AutoDisposeProviderRef<GetProducts>;
String _$getProductDetailUseCaseHash() =>
    r'c7c945aa6bc7948524aeb6c2a63e382fe49d1dbe';

/// See also [getProductDetailUseCase].
@ProviderFor(getProductDetailUseCase)
final getProductDetailUseCaseProvider =
    AutoDisposeProvider<GetProductDetail>.internal(
      getProductDetailUseCase,
      name: r'getProductDetailUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getProductDetailUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetProductDetailUseCaseRef = AutoDisposeProviderRef<GetProductDetail>;
String _$productsNotifierHash() => r'47b70545cfd4ba6f0ff22d2fb31383594c8e5d03';

/// See also [ProductsNotifier].
@ProviderFor(ProductsNotifier)
final productsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ProductsNotifier, List<Product>>.internal(
      ProductsNotifier.new,
      name: r'productsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProductsNotifier = AutoDisposeAsyncNotifier<List<Product>>;
String _$productDetailNotifierHash() =>
    r'80ed4e99fb39c90dbd29332f556905b0f30640d4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ProductDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Product?> {
  late final String productId;

  FutureOr<Product?> build(String productId);
}

/// See also [ProductDetailNotifier].
@ProviderFor(ProductDetailNotifier)
const productDetailNotifierProvider = ProductDetailNotifierFamily();

/// See also [ProductDetailNotifier].
class ProductDetailNotifierFamily extends Family<AsyncValue<Product?>> {
  /// See also [ProductDetailNotifier].
  const ProductDetailNotifierFamily();

  /// See also [ProductDetailNotifier].
  ProductDetailNotifierProvider call(String productId) {
    return ProductDetailNotifierProvider(productId);
  }

  @override
  ProductDetailNotifierProvider getProviderOverride(
    covariant ProductDetailNotifierProvider provider,
  ) {
    return call(provider.productId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productDetailNotifierProvider';
}

/// See also [ProductDetailNotifier].
class ProductDetailNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<ProductDetailNotifier, Product?> {
  /// See also [ProductDetailNotifier].
  ProductDetailNotifierProvider(String productId)
    : this._internal(
        () => ProductDetailNotifier()..productId = productId,
        from: productDetailNotifierProvider,
        name: r'productDetailNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productDetailNotifierHash,
        dependencies: ProductDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            ProductDetailNotifierFamily._allTransitiveDependencies,
        productId: productId,
      );

  ProductDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  FutureOr<Product?> runNotifierBuild(
    covariant ProductDetailNotifier notifier,
  ) {
    return notifier.build(productId);
  }

  @override
  Override overrideWith(ProductDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductDetailNotifierProvider._internal(
        () => create()..productId = productId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductDetailNotifier, Product?>
  createElement() {
    return _ProductDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailNotifierProvider &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductDetailNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<Product?> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _ProductDetailNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<ProductDetailNotifier, Product?>
    with ProductDetailNotifierRef {
  _ProductDetailNotifierProviderElement(super.provider);

  @override
  String get productId => (origin as ProductDetailNotifierProvider).productId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
