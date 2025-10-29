# Clean Architecture Diagrams

## Architecture Overview

The application follows the clean architecture pattern with three main layers:

```mermaid
flowchart TD
    subgraph "Presentation Layer"
        Pages
        Widgets
        Providers[Riverpod Providers]
    end

    subgraph "Domain Layer"
        Entities
        Repositories[Repository Interfaces]
        UseCases[Use Cases]
    end

    subgraph "Data Layer"
        Models
        DataSources[Data Sources]
        RepoImpl[Repository Implementations]
    end

    Providers --> UseCases
    UseCases --> Repositories
    Pages --> Providers
    Widgets --> Providers
    RepoImpl --> Repositories
    RepoImpl --> DataSources
    DataSources --> Models
    Models --> Entities
```

## Layer Responsibilities

### Presentation Layer

- Contains UI-related code (pages, widgets)
- Uses Riverpod for state management
- Doesn't contain business logic
- Depends on the Domain layer

### Domain Layer

- Contains business logic
- Defines entities (business objects)
- Defines repository interfaces
- Contains use cases (business operations)
- Has no dependencies on other layers

### Data Layer

- Implements repository interfaces from Domain layer
- Manages data sources (API, local storage)
- Handles data mapping between external sources and domain entities
- Depends on the Domain layer for interfaces

## Data Flow

```mermaid
sequenceDiagram
    participant UI as UI (Pages/Widgets)
    participant Provider as Riverpod Provider
    participant UseCase as Use Case
    participant Repository as Repository (Interface)
    participant RepoImpl as Repository Implementation
    participant DataSource as Data Source
    participant API as External API/Storage

    UI->>Provider: User Action
    Provider->>UseCase: Call Use Case
    UseCase->>Repository: Call Repository Method
    Repository->>RepoImpl: Implementation Handles Call
    RepoImpl->>DataSource: Request Data
    DataSource->>API: API Request
    API-->>DataSource: Response
    DataSource-->>RepoImpl: Parsed Data
    RepoImpl-->>Repository: Either<Failure, Data>
    Repository-->>UseCase: Either<Failure, Data>
    UseCase-->>Provider: Either<Failure, Data>
    Provider-->>UI: Update State
```

## Authentication Flow

```mermaid
flowchart TD
    Start([Start]) --> CheckToken[Check Stored Token]
    CheckToken --> TokenValid{Token Valid?}
    TokenValid -->|Yes| Authenticated[Set Authenticated State]
    TokenValid -->|No| Unauthenticated[Set Unauthenticated State]
    Unauthenticated --> LoginScreen[Show Login Screen]
    LoginScreen --> LoginAction[User Enters Credentials]
    LoginAction --> CallAPI[Call Login API]
    CallAPI --> ApiResponse{Response}
    ApiResponse -->|Success| StoreToken[Store Token]
    StoreToken --> Authenticated
    ApiResponse -->|Error| ShowError[Show Error]
    ShowError --> LoginScreen
    Authenticated --> ProtectedRoutes[Access Protected Routes]
```

## Error Handling Flow

```mermaid
flowchart TD
    Start([API Request]) --> TryCatch[Try-Catch Block]
    TryCatch --> Success{Success?}
    Success -->|Yes| MapToEntity[Map to Entity]
    Success -->|No| CatchError[Catch Error]
    CatchError --> ErrorType{Error Type?}
    ErrorType -->|Server| ServerException[Server Exception]
    ErrorType -->|Network| NetworkException[Network Exception]
    ErrorType -->|Other| OtherException[Other Exception]
    ServerException --> MapToFailure[Map to ServerFailure]
    NetworkException --> MapToFailure2[Map to NetworkFailure]
    OtherException --> MapToFailure3[Map to Failure]
    MapToFailure --> ReturnEither[Return Either.Left]
    MapToFailure2 --> ReturnEither
    MapToFailure3 --> ReturnEither
    MapToEntity --> ReturnRight[Return Either.Right]
```

## Directory Structure

```mermaid
flowchart TD
    lib[lib/] --> feature[feature/]
    feature --> featureName[product/]

    featureName --> data[data/]
    data --> dataSources[data_sources/]
    data --> models[models/]
    data --> repositories[repositories/]

    featureName --> domain[domain/]
    domain --> entities[entities/]
    domain --> repoInterfaces[repositories/]
    domain --> useCases[use_cases/]

    featureName --> presentation[presentation/]
    presentation --> pages[pages/]
    presentation --> providers[providers/]
    presentation --> widgets[widgets/]

    lib --> core[core/]
    core --> error[error/]
    core --> network[network/]
    core --> util[util/]

    lib --> auth[auth/]
    lib --> route[route/]
```

## Dependency Injection with Riverpod

```mermaid
flowchart TD
    ApiClientProvider[apiClientProvider] --> ProductRemoteDataSourceProvider[productRemoteDataSourceProvider]
    ProductRemoteDataSourceProvider --> ProductRepositoryProvider[productRepositoryProvider]
    ProductRepositoryProvider --> GetProductsUseCaseProvider[getProductsUseCaseProvider]
    ProductRepositoryProvider --> GetProductDetailUseCaseProvider[getProductDetailUseCaseProvider]
    GetProductsUseCaseProvider --> ProductsNotifierProvider[productsNotifierProvider]
    GetProductDetailUseCaseProvider --> ProductDetailNotifierProvider[productDetailNotifierProvider]
    ProductsNotifierProvider --> UI[UI Components]
    ProductDetailNotifierProvider --> UI
```
