// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiClientHash() => r'4dc410cba234a38f66fd63854cadeab9f674e3ac';

/// See also [apiClient].
@ProviderFor(apiClient)
final apiClientProvider = AutoDisposeProvider<ApiClient>.internal(
  apiClient,
  name: r'apiClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apiClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiClientRef = AutoDisposeProviderRef<ApiClient>;
String _$userRemoteDataSourceHash() =>
    r'2cde3c435ae1346ac53c33b3ae54fa2b41e1a55d';

/// See also [userRemoteDataSource].
@ProviderFor(userRemoteDataSource)
final userRemoteDataSourceProvider =
    AutoDisposeProvider<EmployeeRemoteDataSource>.internal(
      userRemoteDataSource,
      name: r'userRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserRemoteDataSourceRef =
    AutoDisposeProviderRef<EmployeeRemoteDataSource>;
String _$employeeRepositoryHash() =>
    r'a680b706410d92089b70033ef9219fc6f99af05b';

/// See also [employeeRepository].
@ProviderFor(employeeRepository)
final employeeRepositoryProvider =
    AutoDisposeProvider<EmployeeRepoImpl>.internal(
      employeeRepository,
      name: r'employeeRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$employeeRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmployeeRepositoryRef = AutoDisposeProviderRef<EmployeeRepoImpl>;
String _$getEmployeesUseCaseHash() =>
    r'4301575ae66705bd530d0a6605d5261c7ac08466';

/// See also [getEmployeesUseCase].
@ProviderFor(getEmployeesUseCase)
final getEmployeesUseCaseProvider = AutoDisposeProvider<GetEmployees>.internal(
  getEmployeesUseCase,
  name: r'getEmployeesUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getEmployeesUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetEmployeesUseCaseRef = AutoDisposeProviderRef<GetEmployees>;
String _$getEmployeeByIdUseCaseHash() =>
    r'c3bde1ea43064e4c37164e0ac99fa39467665467';

/// See also [getEmployeeByIdUseCase].
@ProviderFor(getEmployeeByIdUseCase)
final getEmployeeByIdUseCaseProvider =
    AutoDisposeProvider<GetEmployeeById>.internal(
      getEmployeeByIdUseCase,
      name: r'getEmployeeByIdUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getEmployeeByIdUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetEmployeeByIdUseCaseRef = AutoDisposeProviderRef<GetEmployeeById>;
String _$employeesNotifierHash() => r'0e1aa876032251830d54047ad2ee7aa513e5550a';

/// See also [EmployeesNotifier].
@ProviderFor(EmployeesNotifier)
final employeesNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      EmployeesNotifier,
      List<Employee>
    >.internal(
      EmployeesNotifier.new,
      name: r'employeesNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$employeesNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$EmployeesNotifier = AutoDisposeAsyncNotifier<List<Employee>>;
String _$employeeByIdNotifierHash() =>
    r'd2fc453b12ec2139e74524e634e02b284a34ee62';

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

abstract class _$EmployeeByIdNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Employee?> {
  late final String employeeId;

  FutureOr<Employee?> build(String employeeId);
}

/// See also [EmployeeByIdNotifier].
@ProviderFor(EmployeeByIdNotifier)
const employeeByIdNotifierProvider = EmployeeByIdNotifierFamily();

/// See also [EmployeeByIdNotifier].
class EmployeeByIdNotifierFamily extends Family<AsyncValue<Employee?>> {
  /// See also [EmployeeByIdNotifier].
  const EmployeeByIdNotifierFamily();

  /// See also [EmployeeByIdNotifier].
  EmployeeByIdNotifierProvider call(String employeeId) {
    return EmployeeByIdNotifierProvider(employeeId);
  }

  @override
  EmployeeByIdNotifierProvider getProviderOverride(
    covariant EmployeeByIdNotifierProvider provider,
  ) {
    return call(provider.employeeId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'employeeByIdNotifierProvider';
}

/// See also [EmployeeByIdNotifier].
class EmployeeByIdNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<EmployeeByIdNotifier, Employee?> {
  /// See also [EmployeeByIdNotifier].
  EmployeeByIdNotifierProvider(String employeeId)
    : this._internal(
        () => EmployeeByIdNotifier()..employeeId = employeeId,
        from: employeeByIdNotifierProvider,
        name: r'employeeByIdNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$employeeByIdNotifierHash,
        dependencies: EmployeeByIdNotifierFamily._dependencies,
        allTransitiveDependencies:
            EmployeeByIdNotifierFamily._allTransitiveDependencies,
        employeeId: employeeId,
      );

  EmployeeByIdNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.employeeId,
  }) : super.internal();

  final String employeeId;

  @override
  FutureOr<Employee?> runNotifierBuild(
    covariant EmployeeByIdNotifier notifier,
  ) {
    return notifier.build(employeeId);
  }

  @override
  Override overrideWith(EmployeeByIdNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: EmployeeByIdNotifierProvider._internal(
        () => create()..employeeId = employeeId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        employeeId: employeeId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EmployeeByIdNotifier, Employee?>
  createElement() {
    return _EmployeeByIdNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EmployeeByIdNotifierProvider &&
        other.employeeId == employeeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, employeeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EmployeeByIdNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<Employee?> {
  /// The parameter `employeeId` of this provider.
  String get employeeId;
}

class _EmployeeByIdNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<EmployeeByIdNotifier, Employee?>
    with EmployeeByIdNotifierRef {
  _EmployeeByIdNotifierProviderElement(super.provider);

  @override
  String get employeeId => (origin as EmployeeByIdNotifierProvider).employeeId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
