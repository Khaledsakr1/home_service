# Home Service App - Clean Architecture Refactor

This document outlines the major structural changes applied to the Home Service Flutter application to adhere to Clean Architecture principles. The refactoring focused on separating concerns into distinct layers: Presentation, Domain, and Data, while ensuring all existing functionalities, UI design, and business logic remain unchanged.

## Folder Structure

The application now follows a modular and layered folder structure, making it more scalable and maintainable:

```
lib/
├── core/
│   ├── error/
│   │   └── failures.dart
│   └── usecases/
│       └── usecase.dart
├── features/
│   └── <feature_name>/ (e.g., authentication, services, portfolio)
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── <feature_name>_remote_data_source.dart
│       │   │   └── <feature_name>_local_data_source.dart
│       │   ├── models/
│       │   │   └── <feature_name>_model.dart
│       │   └── repositories/
│       │       └── <feature_name>_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── <feature_name>_entity.dart
│       │   ├── repositories/
│       │   │   └── <feature_name>_repository.dart
│       │   └── usecases/
│       │       └── get_<feature_name>.dart
│       └── presentation/
│           ├── manager/
│           │   └── <feature_name>_cubit.dart (or bloc)
│           │   └── <feature_name>_state.dart
│           └── pages/
│               └── <feature_name>_page.dart
│           └── widgets/
│               └── <feature_name>_widget.dart
├── injection_container.dart
├── main.dart
```

## Layer Responsibilities

### Presentation Layer
- **Location**: `lib/features/<feature_name>/presentation/`
- **Responsibility**: Handles UI rendering and user interaction. Manages UI state using Cubits (from `flutter_bloc`). Dispatches events/calls use cases to the Domain Layer and observes changes to update the UI.
- **Dependencies**: Depends only on the Domain Layer.

### Domain Layer
- **Location**: `lib/features/<feature_name>/domain/`
- **Responsibility**: Contains the core business logic and rules. It is independent of any other layer. Defines Entities (plain Dart objects), Use Cases (encapsulate specific business operations), and Repository Interfaces (abstract contracts for data operations).
- **Dependencies**: None (pure Dart code).

### Data Layer
- **Location**: `lib/features/<feature_name>/data/`
- **Responsibility**: Implements the Repository Interfaces defined in the Domain Layer. Handles data retrieval and storage from various sources (e.g., REST APIs). Contains Models (data structures mapping to external data) and Data Sources (abstract classes for interacting with specific data sources).
- **Dependencies**: Depends only on the Domain Layer (through Repository Interfaces).

### Core Layer
- **Location**: `lib/core/`
- **Responsibility**: Contains common functionalities and utilities used across different layers, such as `Failure` classes for error handling and a base `UseCase` class.
- **Dependencies**: None on specific features.

## Dependency Injection

`get_it` package has been integrated for dependency injection. The `lib/injection_container.dart` file is responsible for registering all dependencies (Cubits, Use Cases, Repositories, Data Sources, and external libraries like `http.Client`). This ensures that dependencies are provided to their consumers in a clean and testable manner.

## Migration of Existing Code

All existing UI widgets, business logic, and API calls have been migrated into this new structure. Each feature (e.g., Authentication, Services, Portfolio) now resides in its dedicated `features/<feature_name>` directory, with its own Presentation, Domain, and Data sub-layers. The original `lib/Pages` and `lib/api` directories have been removed, and their contents redistributed according to the new architecture.

## Running the Refactored App

To run the refactored application:

1. Navigate to the `home_service` directory:
   `cd home_service`
2. Get the Flutter dependencies:
   `/home/ubuntu/flutter/bin/flutter pub get`
3. Run the application:
   `/home/ubuntu/flutter/bin/flutter run`

This refactoring aims to improve the maintainability, testability, and scalability of the Home Service application without altering its existing functionality or user experience.

