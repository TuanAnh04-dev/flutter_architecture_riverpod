# Clean Architecture với Riverpod - All Diagrams

Tất cả 9 diagrams dạng Mermaid code. Có thể view trên GitHub hoặc các editor hỗ trợ Mermaid.

---

## 📋 1. Clean Architecture Overview

```mermaid
graph TB
    subgraph UI["🎨 PRESENTATION LAYER"]
        A[ProductListPage]
        B[ProductsNotifier]
        C[ProductDetailPage]
        D[ProductDetailNotifier]
        E[ProductCard Widget]
    end

    subgraph PROVIDERS["🔌 PROVIDERS"]
        F[GetProducts UseCase]
        G[GetProductDetail UseCase]
    end

    subgraph DOMAIN["🎯 DOMAIN LAYER"]
        H[ProductRepository Interface]
        I[Product Entity]
    end

    subgraph DATA["📊 DATA LAYER"]
        J[ProductRepositoryImpl]
        K[ProductRemoteDataSource]
        L[ProductModel]
    end

    subgraph CORE["⚙️ CORE"]
        M[ApiClient]
        N[Dio]
        O[Failure Handling]
        P[Exception Handling]
    end

    subgraph EXTERNAL["🌐 EXTERNAL"]
        Q[FakeStore API]
    end

    A --> B
    C --> D
    B --> F
    D --> G
    F --> H
    G --> H
    H --> I
    H --> J
    J --> K
    K --> L
    L -.extends.-> I
    K --> M
    M --> N
    J --> O
    K --> P
    N --> Q

    style UI fill:#e1f5ff
    style PROVIDERS fill:#fff4e1
    style DOMAIN fill:#e8f5e9
    style DATA fill:#f3e5f5
    style CORE fill:#fce4ec
    style EXTERNAL fill:#e0e0e0
```

**Mô tả:** Tổng quan về cấu trúc Clean Architecture với các layer: Presentation, Domain, Data và Core.

---

## 🔄 2. Data Flow Diagram

```mermaid
graph LR
    A[👤 User Opens App] --> B[🎨 ProductListPage]
    B --> C[📦 ProductsNotifier]
    C --> D[🎯 GetProducts UseCase]
    D --> E[📚 ProductRepository]
    E --> F[💾 RemoteDataSource]
    F --> G[🌐 ApiClient]
    G --> H[☁️ FakeStore API]
    
    H -.JSON Response.-> G
    G -.Response.-> F
    F -.ProductModel.-> E
    E -.Product Entity.-> D
    D -.Either Result.-> C
    C -.AsyncValue.-> B
    B -.UI Render.-> A

    style A fill:#ffe6e6
    style B fill:#e3f2fd
    style C fill:#fff3e0
    style D fill:#e8f5e9
    style E fill:#f3e5f5
    style F fill:#fce4ec
    style G fill:#e1f5fe
    style H fill:#e0e0e0
```

**Mô tả:** Luồng dữ liệu từ User đến API và ngược lại, bao gồm tất cả các bước chuyển đổi.

---

## 🏛️ 3. Layer Architecture Details

```mermaid
graph LR
    subgraph PRESENTATION["🎨 PRESENTATION"]
        P1[Pages]
        P2[Widgets]
        P3[Notifiers]
    end

    subgraph DOMAIN["🎯 DOMAIN"]
        D1[Entities]
        D2[Repositories]
        D3[Use Cases]
    end

    subgraph DATA["📊 DATA"]
        DT1[Repository Impl]
        DT2[Data Sources]
        DT3[Models]
    end

    subgraph CORE["⚙️ CORE"]
        C1[Network]
        C2[Error Handling]
    end

    PRESENTATION -->|depends on| DOMAIN
    DATA -->|implements| DOMAIN
    DATA -->|uses| CORE
    PRESENTATION -->|uses| CORE

    style PRESENTATION fill:#e3f2fd
    style DOMAIN fill:#c8e6c9
    style DATA fill:#f3e5f5
    style CORE fill:#fff9c4
```

**Mô tả:** Chi tiết cấu trúc từng layer và dependency giữa chúng theo Dependency Rule.

---

## 💉 4. Dependency Injection Flow

```mermaid
graph TD
    A[ProviderScope] --> B[ProductListPage]
    B --> C[productsNotifierProvider]
    C --> D[ProductsNotifier]
    D --> E[getProductsUseCaseProvider]
    E --> F[GetProducts UseCase]
    F --> G[productRepositoryProvider]
    G --> H[ProductRepositoryImpl]
    H --> I[productRemoteDataSourceProvider]
    I --> J[ProductRemoteDataSource]
    J --> K[apiClientProvider]
    K --> L[ApiClient with Dio]

    style A fill:#ff6b6b
    style B fill:#4ecdc4
    style D fill:#95e1d3
    style F fill:#f38181
    style H fill:#aa96da
    style J fill:#fcbad3
    style L fill:#ffffd2
```

**Mô tả:** Cách Riverpod inject dependencies tự động thông qua các Providers từ top-down.

---

## ⚠️ 5. Error Handling Flow

```mermaid
graph TB
    A[API Request] --> B{Network Call}
    
    B -->|Success| C[Parse JSON]
    B -->|Network Error| D[NetworkException]
    B -->|Server Error| E[ServerException]
    
    C -->|Success| F[Return Model]
    C -->|Fail| G[ServerException]
    
    D --> H[Repository Catch]
    E --> H
    G --> H
    F --> I[Convert to Entity]
    
    H --> J{Exception Type}
    
    J -->|Network| K[NetworkFailure]
    J -->|Server| L[ServerFailure]
    J -->|Unknown| M[ServerFailure]
    
    I --> N[Right Product]
    
    K --> O[UseCase Returns Either]
    L --> O
    M --> O
    N --> O
    
    O --> P[Notifier fold]
    
    P --> Q{Result Type}
    
    Q -->|Failure| R[AsyncValue.error]
    Q -->|Success| S[AsyncValue.data]
    
    R --> T[UI Error State]
    S --> U[UI Data State]

    style D fill:#ffcdd2
    style E fill:#ffcdd2
    style G fill:#ffcdd2
    style K fill:#ef9a9a
    style L fill:#ef9a9a
    style M fill:#ef9a9a
    style R fill:#e57373
    style T fill:#f44336

    style F fill:#c8e6c9
    style I fill:#a5d6a7
    style N fill:#81c784
    style S fill:#66bb6a
    style U fill:#4caf50
```

**Mô tả:** Xử lý lỗi từ API đến UI qua các Exception và Failure, sử dụng Either pattern.

---

## 📊 6. State Management - AsyncNotifier Lifecycle

```mermaid
graph TD
    A[Initial State] --> B[build called]
    B --> C[Loading State]
    C --> D[Fetch Products]
    D --> E[Call UseCase]
    E --> F[Repository Call]
    F --> G{Result}
    
    G -->|Success| H[AsyncValue.data]
    G -->|Error| I[AsyncValue.error]
    
    H --> J[UI Shows Data]
    I --> K[UI Shows Error]
    
    J --> L{User Action}
    K --> L
    
    L -->|Refresh| C
    L -->|Navigate| M[Navigate to Detail]
    M --> N[DetailNotifier build]
    N --> C

    style A fill:#e0e0e0
    style C fill:#fff9c4
    style H fill:#c8e6c9
    style I fill:#ffcdd2
    style J fill:#81c784
    style K fill:#ef5350
```

**Mô tả:** Vòng đời của AsyncNotifier từ Initial đến Loading, Data hoặc Error, bao gồm user actions.

---

## 🔀 7. Data Transformation Process

```mermaid
graph LR
    A[API JSON] --> B[ProductModel.fromJson]
    B --> C[ProductModel]
    C --> D[model.toEntity]
    D --> E[Product Entity]
    E --> F[Either Success]
    F --> G[result.fold]
    G -->|Right| H[return products]
    G -->|Left| I[throw Exception]
    H --> J[AsyncValue.data]
    I --> K[AsyncValue.error]
    J --> L[UI when data]
    K --> M[UI when error]

    style A fill:#e8f5e9
    style C fill:#ffcc80
    style E fill:#81d4fa
    style F fill:#ce93d8
    style J fill:#66bb6a
    style K fill:#ef5350
    style L fill:#4caf50
    style M fill:#f44336
```

**Mô tả:** Chuyển đổi dữ liệu từ JSON → Model → Entity → Either → AsyncValue → UI.

---

## 📄 8. Product Detail Flow

```mermaid
graph TD
    A[User Views List] --> B[Click Product Card]
    B --> C[Navigate to Detail Page]
    C --> D[ProductDetailNotifier with ID]
    D --> E[build called with productId]
    E --> F[GetProductDetail UseCase]
    F --> G[Repository getProductById]
    G --> H[DataSource fetch]
    H --> I[API Call]
    I --> J{Response}
    
    J -->|Success| K[Parse to Model]
    J -->|Error| L[Throw Exception]
    
    K --> M[Convert to Entity]
    M --> N[Right Product]
    L --> O[Catch and Left Failure]
    
    N --> P[Notifier fold]
    O --> P
    
    P --> Q{Result}
    Q -->|Success| R[AsyncValue.data product]
    Q -->|Error| S[AsyncValue.error]
    
    R --> T[Show Product Details]
    S --> U[Show Error with Retry]

    style A fill:#e3f2fd
    style B fill:#fff3e0
    style D fill:#ffcc80
    style F fill:#c8e6c9
    style I fill:#e1f5fe
    style K fill:#a5d6a7
    style M fill:#81d4fa
    style R fill:#66bb6a
    style S fill:#ef5350
    style T fill:#4caf50
    style U fill:#f44336
```

**Mô tả:** Luồng xử lý khi user click vào product để xem chi tiết, sử dụng Family Provider.

---

## 🎯 9. Complete System Architecture

```mermaid
graph TB
    subgraph USER["👤 USER"]
        U1[Open App]
        U2[View List]
        U3[Click Product]
        U4[View Detail]
        U5[Refresh]
    end

    subgraph PRESENTATION["🎨 PRESENTATION"]
        P1[ProviderScope]
        P2[ProductListPage]
        P3[ProductDetailPage]
        N1[ProductsNotifier]
        N2[ProductDetailNotifier]
    end

    subgraph DOMAIN["🎯 DOMAIN"]
        D1[Product Entity]
        D2[ProductRepository]
        D3[GetProducts]
        D4[GetProductDetail]
    end

    subgraph DATA["📊 DATA"]
        DT1[RepositoryImpl]
        DT2[RemoteDataSource]
        DT3[ProductModel]
    end

    subgraph CORE["⚙️ CORE"]
        C1[ApiClient]
        C2[Dio]
        C3[Exceptions]
        C4[Failures]
    end

    subgraph EXTERNAL["🌐 EXTERNAL"]
        EX1[FakeStore API]
    end

    U1 --> P1
    P1 --> P2
    U2 --> P2
    P2 --> N1
    U3 --> P3
    P3 --> N2
    U5 --> N1
    U5 --> N2

    N1 --> D3
    N2 --> D4
    D3 --> D2
    D4 --> D2
    D2 --> D1
    D2 --> DT1
    DT1 --> DT2
    DT2 --> DT3
    DT3 --> D1
    DT1 --> C3
    DT1 --> C4
    DT2 --> C1
    C1 --> C2
    C2 --> EX1

    style USER fill:#ffe6e6
    style PRESENTATION fill:#e3f2fd
    style DOMAIN fill:#c8e6c9
    style DATA fill:#f3e5f5
    style CORE fill:#fff9c4
    style EXTERNAL fill:#e0e0e0
```

**Mô tả:** Tổng quan toàn bộ hệ thống với tất cả components từ User đến External API.

---

## 📝 Cách sử dụng:

### 1. View trên GitHub
- Tạo repository mới trên GitHub
- Upload file này
- GitHub sẽ tự động render Mermaid diagrams

### 2. View với VSCode
- Cài extension: **Markdown Preview Mermaid Support**
- Mở file này
- Nhấn `Ctrl+Shift+V` để preview

### 3. View với Obsidian
- Copy file vào vault
- Obsidian hỗ trợ Mermaid native

### 4. Export sang PNG/SVG
- Dùng online tools:
  - https://mermaid.live/
  - https://mermaid.ink/
- Copy code từng diagram
- Export theo format mong muốn

### 5. Import vào Draw.io
- Mở https://app.diagrams.net/
- Insert → Advanced → Mermaid
- Paste code và convert

---

## 🎯 Key Points

- **Clean Separation**: Mỗi layer có trách nhiệm riêng
- **Dependency Rule**: Inner layers không phụ thuộc outer layers  
- **Testability**: Dễ dàng test từng layer độc lập
- **Type Safety**: Sử dụng Either<Failure, T> cho error handling
- **Reactive State**: AsyncNotifier tự động quản lý loading/error/data states

---

**© 2025 Clean Architecture với Riverpod - Flutter Demo**