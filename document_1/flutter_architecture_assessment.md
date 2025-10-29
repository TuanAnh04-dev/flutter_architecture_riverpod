# Flutter Architecture Assessment & Upgrade Roadmap
## Đánh Giá Chuyên Nghiệp Từ Senior Developer

---

## 📋 Executive Summary

Document này cung cấp đánh giá toàn diện về kiến trúc Flutter project hiện tại và roadmap chi tiết để nâng cấp lên một **production-ready template** đa dụng, đáp ứng các tiêu chuẩn enterprise.

**Ngày đánh giá:** Tháng 10, 2025  
**Phiên bản đánh giá:** 1.0  
**Mục tiêu:** Tạo Flutter Template Production-Ready

---

## 1. 🎯 ĐÁNH GIÁ TỔNG QUAN

### 1.1 Điểm Mạnh Hiện Tại

#### ✅ Cấu Trúc Module Rõ Ràng
- Tổ chức theo feature-first approach
- Phân chia logic/model/screen hợp lý
- Dễ maintain và scale

#### ✅ State Management Với Riverpod
- Implementation đúng pattern
- State immutability
- Type-safe providers

#### ✅ Authentication Flow
- Centralized auth management
- Clear auth flow
- Token handling cơ bản

### 1.2 Điểm Yếu Nghiêm Trọng

#### ❌ Thiếu Architecture Layers
- Không có separation giữa Data/Domain/Presentation
- Logic layer trộn lẫn business logic và UI logic
- Không có repository pattern chuẩn

#### ❌ Error Handling Không Nhất Quán
- Error state management rải rác
- UI feedback trực tiếp trong logic layer
- Thiếu centralized error handler

#### ❌ Thiếu Testing Infrastructure
- Không có test coverage
- Không có mock setup
- Không có test utilities

#### ❌ Không Có Dependency Injection
- Hard-coded dependencies
- Khó test và maintain
- Tight coupling giữa các components

#### ❌ Network Layer Cơ Bản
- Thiếu retry mechanism
- Không có cache strategy
- Thiếu interceptors cho logging/auth

---

## 2. 📐 KIẾN TRÚC MỤC TIÊU

### 2.1 Clean Architecture Pattern

```
┌─────────────────────────────────────────────┐
│           PRESENTATION LAYER                │
│  (Screens, Widgets, Providers, State)      │
└────────────────┬────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────┐
│            DOMAIN LAYER                     │
│  (Entities, UseCases, Repository Interfaces)│
└────────────────┬────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────┐
│             DATA LAYER                      │
│  (Models, DataSources, Repository Impl)    │
└─────────────────────────────────────────────┘
```

### 2.2 Cấu Trúc Thư Mục Mục Tiêu

```
lib/
├── core/
│   ├── di/                          # Dependency Injection
│   │   └── injection.dart
│   ├── network/                     # Network Infrastructure
│   │   ├── api_client.dart
│   │   ├── api_response.dart
│   │   ├── api_exception.dart
│   │   ├── interceptors/
│   │   │   ├── auth_interceptor.dart
│   │   │   ├── retry_interceptor.dart
│   │   │   └── logger_interceptor.dart
│   │   └── network_info.dart
│   ├── error/                       # Error Handling
│   │   ├── failures.dart
│   │   ├── exceptions.dart
│   │   └── error_handler.dart
│   ├── storage/                     # Local Storage
│   │   ├── secure_storage.dart
│   │   └── local_storage.dart
│   ├── usecase/                     # Base UseCase
│   │   └── usecase.dart
│   ├── theme/                       # Theme System
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   └── app_text_styles.dart
│   ├── localization/                # i18n
│   │   └── app_localizations.dart
│   ├── config/                      # Configuration
│   │   ├── env.dart
│   │   └── app_config.dart
│   ├── logging/                     # Logging System
│   │   └── logger.dart
│   ├── security/                    # Security
│   │   └── certificate_pinning.dart
│   └── utils/                       # Utilities
│       ├── validators.dart
│       └── extensions.dart
│
├── features/                        # Features (thay vì module)
│   └── feature_name/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── feature_remote_datasource.dart
│       │   │   └── feature_local_datasource.dart
│       │   ├── models/
│       │   │   └── feature_model.dart
│       │   └── repositories/
│       │       └── feature_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── feature_entity.dart
│       │   ├── repositories/
│       │   │   └── feature_repository.dart
│       │   └── usecases/
│       │       ├── get_feature_data.dart
│       │       └── create_feature.dart
│       └── presentation/
│           ├── providers/
│           │   └── feature_provider.dart
│           ├── screens/
│           │   └── feature_screen.dart
│           └── widgets/
│               └── feature_widget.dart
│
└── app.dart                         # App Configuration
```

---

## 3. 🚀 ROADMAP NÂNG CẤP CHI TIẾT

### PHASE 1: FOUNDATION (Tuần 1-2) - Ưu Tiên Cao Nhất

#### 3.1.1 Tái Cấu Trúc Architecture Layers

**Mục tiêu:** Implement Clean Architecture với 3 layers rõ ràng

**Tasks:**
- [ ] Tạo structure mới cho features/
- [ ] Tách Domain layer (entities, repositories interfaces)
- [ ] Tách Data layer (models, datasources, repository implementations)
- [ ] Refactor Presentation layer (providers, screens, widgets)
- [ ] Migrate existing features sang structure mới

**Code Example - Entity:**
```dart
// domain/entities/user_entity.dart
class UserEntity {
  final String id;
  final String name;
  final String email;
  
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });
}
```

**Code Example - Repository Interface:**
```dart
// domain/repositories/user_repository.dart
abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser(String id);
  Future<Either<Failure, List<UserEntity>>> getUsers();
}
```

#### 3.1.2 Setup Dependency Injection

**Mục tiêu:** Implement GetIt + Injectable cho DI container

**Tasks:**
- [ ] Add GetIt và Injectable dependencies
- [ ] Setup injection container
- [ ] Register core dependencies (Dio, ApiClient, Storage)
- [ ] Register feature dependencies
- [ ] Update main.dart để initialize DI

**Code Example:**
```dart
// core/di/injection.dart
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();

// Register example
@module
abstract class AppModule {
  @lazySingleton
  Dio get dio => Dio(BaseOptions(
    baseUrl: Env.apiBaseUrl,
    connectTimeout: const Duration(seconds: 30),
  ));
  
  @lazySingleton
  ApiClient apiClient(Dio dio) => ApiClient(dio);
}
```

#### 3.1.3 Implement Base Classes

**Mục tiêu:** Tạo base classes để reduce code duplication

**Tasks:**
- [ ] BaseNotifier<T> cho state management
- [ ] BaseUseCase<Type, Params>
- [ ] BaseRepository
- [ ] BaseRemoteDataSource

**Code Example - BaseNotifier:**
```dart
// core/base/base_notifier.dart
abstract class BaseNotifier<T> extends AutoDisposeNotifier<AsyncValue<T>> {
  @override
  AsyncValue<T> build() => const AsyncValue.loading();

  Future<void> execute(Future<T> Function() action) async {
    state = const AsyncValue.loading();
    try {
      final result = await action();
      state = AsyncValue.data(result);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      handleError(error);
    }
  }

  void handleError(Object error) {
    AppLogger.e('Error in ${runtimeType}', error);
    // Show error to user
  }
}
```

**Code Example - BaseUseCase:**
```dart
// core/usecase/usecase.dart
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

// Example implementation
class GetUserUseCase implements UseCase<UserEntity, String> {
  final UserRepository repository;
  
  GetUserUseCase(this.repository);
  
  @override
  Future<Either<Failure, UserEntity>> call(String userId) {
    return repository.getUser(userId);
  }
}
```

---

### PHASE 2: ESSENTIAL FEATURES (Tuần 3-4)

#### 3.2.1 Error Handling System

**Mục tiêu:** Centralized error handling với custom failures

**Tasks:**
- [ ] Define Failure classes hierarchy
- [ ] Implement ErrorHandler utility
- [ ] Create custom exceptions
- [ ] Setup global error boundary
- [ ] Implement user-friendly error messages

**Code Example - Failures:**
```dart
// core/error/failures.dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, {this.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
```

**Code Example - Error Handler:**
```dart
// core/error/error_handler.dart
class ErrorHandler {
  static Failure handleError(Object error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is AppException) {
      return ServerFailure(error.message);
    }
    return const ServerFailure('Unknown error occurred');
  }
  
  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');
      case DioExceptionType.badResponse:
        return ServerFailure(
          'Server error: ${error.response?.statusCode}',
          statusCode: error.response?.statusCode,
        );
      default:
        return const ServerFailure('Unknown network error');
    }
  }
  
  static String getUserMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'Please check your internet connection';
    } else if (failure is ServerFailure) {
      if (failure.statusCode == 401) {
        return 'Session expired. Please login again';
      }
      return 'Something went wrong. Please try again';
    }
    return failure.message;
  }
}
```

#### 3.2.2 Network Layer Enhancement

**Mục tiêu:** Production-ready network layer với interceptors

**Tasks:**
- [ ] Setup Dio với proper configuration
- [ ] Implement AuthInterceptor
- [ ] Implement RetryInterceptor
- [ ] Implement LoggerInterceptor
- [ ] Implement CacheInterceptor (optional)
- [ ] Add request/response logging

**Code Example - ApiClient:**
```dart
// core/network/api_client.dart
@lazySingleton
class ApiClient {
  final Dio _dio;
  
  ApiClient(this._dio) {
    _dio.interceptors.addAll([
      AuthInterceptor(),
      RetryInterceptor(dio: _dio),
      LoggerInterceptor(),
    ]);
  }
  
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse<T>(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
  
  T _handleResponse<T>(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data as T;
    }
    throw AppException('Invalid response');
  }
  
  Exception _handleError(DioException error) {
    return AppException(
      error.message ?? 'Unknown error',
      statusCode: error.response?.statusCode,
    );
  }
}
```

**Code Example - Auth Interceptor:**
```dart
// core/network/interceptors/auth_interceptor.dart
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getIt<SecureStorage>().getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
  
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Token expired, try refresh
      final refreshed = await _refreshToken();
      if (refreshed) {
        // Retry request
        final response = await _retry(err.requestOptions);
        handler.resolve(response);
        return;
      }
      // Logout user
      getIt<AuthRepository>().logout();
    }
    handler.next(err);
  }
}
```

**Code Example - Retry Interceptor:**
```dart
// core/network/interceptors/retry_interceptor.dart
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries = 3;
  
  RetryInterceptor({required this.dio});
  
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final extra = err.requestOptions.extra;
    final retries = extra['retries'] ?? 0;
    
    if (retries < maxRetries && _shouldRetry(err)) {
      extra['retries'] = retries + 1;
      
      await Future.delayed(Duration(seconds: retries + 1));
      
      try {
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        // Continue to next error handler
      }
    }
    handler.next(err);
  }
  
  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           err.type == DioExceptionType.connectionError;
  }
}
```

#### 3.2.3 Testing Infrastructure

**Mục tiêu:** Setup complete testing environment

**Tasks:**
- [ ] Setup test folder structure
- [ ] Create mock generators với Mockito
- [ ] Implement test helpers
- [ ] Write unit tests cho UseCases
- [ ] Write unit tests cho Repositories
- [ ] Write unit tests cho Notifiers
- [ ] Setup test coverage reporting

**Test Structure:**
```
test/
├── fixtures/
│   └── user_fixture.json
├── helpers/
│   ├── test_helper.dart          # Mock generators
│   └── pump_app.dart             # Widget test helper
├── unit/
│   ├── core/
│   │   └── network/
│   ├── features/
│   │   └── user/
│   │       ├── data/
│   │       │   ├── datasources/
│   │       │   ├── models/
│   │       │   └── repositories/
│   │       ├── domain/
│   │       │   └── usecases/
│   │       └── presentation/
│   │           └── providers/
├── widget/
│   └── features/
└── integration/
    └── app_test.dart
```

**Code Example - Test Helper:**
```dart
// test/helpers/test_helper.dart
@GenerateMocks([
  ApiClient,
  UserRepository,
  GetUserUseCase,
  SecureStorage,
])
void main() {}

// Run: flutter pub run build_runner build --delete-conflicting-outputs
```

**Code Example - UseCase Test:**
```dart
// test/unit/features/user/domain/usecases/get_user_test.dart
void main() {
  late GetUserUseCase useCase;
  late MockUserRepository mockRepository;
  
  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUserUseCase(mockRepository);
  });
  
  group('GetUserUseCase', () {
    const testUserId = '123';
    const testUser = UserEntity(
      id: testUserId,
      name: 'Test User',
      email: 'test@example.com',
    );
    
    test('should get user from repository', () async {
      // Arrange
      when(mockRepository.getUser(testUserId))
          .thenAnswer((_) async => const Right(testUser));
      
      // Act
      final result = await useCase(testUserId);
      
      // Assert
      expect(result, const Right(testUser));
      verify(mockRepository.getUser(testUserId));
      verifyNoMoreInteractions(mockRepository);
    });
    
    test('should return ServerFailure when repository fails', () async {
      // Arrange
      when(mockRepository.getUser(testUserId))
          .thenAnswer((_) async => const Left(ServerFailure('Error')));
      
      // Act
      final result = await useCase(testUserId);
      
      // Assert
      expect(result, const Left(ServerFailure('Error')));
    });
  });
}
```

---

### PHASE 3: ADVANCED FEATURES (Tuần 5-6)

#### 3.3.1 Logging & Monitoring System

**Mục tiêu:** Comprehensive logging và error tracking

**Tasks:**
- [ ] Setup Logger package
- [ ] Implement AppLogger wrapper
- [ ] Integrate Firebase Crashlytics
- [ ] Setup Firebase Analytics
- [ ] Implement performance monitoring
- [ ] Add custom event tracking

**Code Example - AppLogger:**
```dart
// core/logging/logger.dart
class AppLogger {
  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
    filter: ProductionFilter(),
  );
  
  static void d(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }
  
  static void i(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }
  
  static void w(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
    FirebaseAnalytics.instance.logEvent(
      name: 'warning',
      parameters: {'message': message},
    );
  }
  
  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
    
    // Send to Crashlytics
    if (error != null) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        reason: message,
      );
    }
  }
  
  static void setUserId(String userId) {
    FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }
}
```

#### 3.3.2 Environment Configuration

**Mục tiêu:** Multi-environment support (dev, staging, prod)

**Tasks:**
- [ ] Create Env class
- [ ] Setup dart-define configuration
- [ ] Create run configurations
- [ ] Environment-specific assets
- [ ] API endpoint configuration

**Code Example:**
```dart
// core/config/env.dart
abstract class Env {
  static const String _env = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );
  
  static bool get isDev => _env == 'dev';
  static bool get isStaging => _env == 'staging';
  static bool get isProd => _env == 'prod';
  
  static String get apiBaseUrl {
    switch (_env) {
      case 'prod':
        return 'https://api.production.com';
      case 'staging':
        return 'https://api.staging.com';
      default:
        return 'https://api.dev.com';
    }
  }
  
  static String get appName {
    switch (_env) {
      case 'prod':
        return 'MyApp';
      case 'staging':
        return 'MyApp Staging';
      default:
        return 'MyApp Dev';
    }
  }
}

// Run commands:
// flutter run --dart-define=ENV=dev
// flutter run --dart-define=ENV=staging
// flutter run --dart-define=ENV=prod
```

**VS Code Launch Configuration:**
```json
// .vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Development",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=ENV=dev"]
    },
    {
      "name": "Staging",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=ENV=staging"]
    },
    {
      "name": "Production",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=ENV=prod"]
    }
  ]
}
```

#### 3.3.3 Localization System

**Mục tiêu:** Multi-language support với ARB files

**Tasks:**
- [ ] Setup intl package
- [ ] Create ARB files structure
- [ ] Implement AppLocalizations
- [ ] Generate localization code
- [ ] Add language switcher
- [ ] Support RTL languages

**Code Example:**
```dart
// l10n.yaml
arb-dir: lib/core/localization/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart

// lib/core/localization/l10n/app_en.arb
{
  "@@locale": "en",
  "appTitle": "My App",
  "@appTitle": {
    "description": "The application title"
  },
  "welcomeMessage": "Welcome, {name}!",
  "@welcomeMessage": {
    "description": "Welcome message with user name",
    "placeholders": {
      "name": {
        "type": "String"
      }
    }
  },
  "itemCount": "{count, plural, =0{No items} =1{1 item} other{{count} items}}",
  "@itemCount": {
    "description": "Number of items",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}

// Usage in code
Text(AppLocalizations.of(context)!.welcomeMessage('John'))
```

#### 3.3.4 Theme System

**Mục tiêu:** Consistent design system với Material 3

**Tasks:**
- [ ] Define color palette
- [ ] Create text styles
- [ ] Setup light/dark themes
- [ ] Implement theme provider
- [ ] Create reusable components
- [ ] Add theme switcher

**Code Example:**
```dart
// core/theme/app_colors.dart
class AppColors {
  // Light theme colors
  static const Color primaryLight = Color(0xFF6200EE);
  static const Color secondaryLight = Color(0xFF03DAC6);
  static const Color errorLight = Color(0xFFB00020);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  
  // Dark theme colors
  static const Color primaryDark = Color(0xFFBB86FC);
  static const Color secondaryDark = Color(0xFF03DAC6);
  static const Color errorDark = Color(0xFFCF6679);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
}

// core/theme/app_text_styles.dart
class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.25,
  );
  
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  static TextTheme textTheme = const TextTheme(
    displayLarge: headline1,
    bodyLarge: body1,
    // ... more styles
  );
}

// core/theme/app_theme.dart
class AppTheme {
  static ThemeData light() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
      brightness: Brightness.light,
    ),
    textTheme: AppTextStyles.textTheme,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
  
  static ThemeData dark() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryDark,
      brightness: Brightness.dark,
    ),
    textTheme: AppTextStyles.textTheme,
  );
}
```

---

### PHASE 4: PRODUCTION READY (Tuần 7-8)

#### 3.4.1 CI/CD Pipeline

**Mục tiêu:** Automated testing, building, deployment

**Tasks:**
- [ ] Setup GitHub Actions workflow
- [ ] Configure automated testing
- [ ] Setup code coverage reporting
- [ ] Configure automated builds (APK/IPA)
- [ ] Setup deployment to stores (optional)

**Code Example - GitHub Actions:**
```yaml
# .github/workflows/flutter_ci.yml
name: Flutter CI/CD

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
          channel: 'stable'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Verify formatting
        run: flutter format --set-exit-if-changed .
      
      - name: Analyze code
        run: flutter analyze
      
      - name: Run tests
        run: flutter test --coverage
      
      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage/lcov.info
  
  build-android:
    needs: analyze
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Build APK
        run: flutter build apk --release --dart-define=ENV=prod
      
      - name: Upload APK
        uses: actions/upload-artifact@v3
        with:
          name: release-apk
          path: build/app/outputs/flutter-apk/app-release.apk
  
  build-ios:
    needs: analyze
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Build iOS
        run: flutter build ios --release --no-codesign --dart-define=ENV=prod
```

#### 3.4.2 Code Quality & Linting

**Mục tiêu:** Enforce code standards và best practices

**Tasks:**
- [ ] Configure analysis_options.yaml
- [ ] Setup custom lint rules
- [ ] Configure import sorting
- [ ] Setup pre-commit hooks
- [