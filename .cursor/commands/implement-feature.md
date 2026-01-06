# Implement Feature

This is the **single, powerful command** for all feature implementation and refactoring in the justpark monorepo. It automatically applies all architectural patterns from `project.mdc` and follows DRY principles.

## Usage

Type `/implement-feature` followed by your requirements. The AI will automatically determine the best approach and generate complete, production-ready code.

## Command Patterns

### Complete Feature Implementation

```bash
/implement-feature products management system
Create a complete products flow with CRUD operations, image upload, category integration, search, and filtering.
```

### Quick Implementation

```bash
/implement-feature contact form
Create a contact form with name, email, phone fields, validation, and submit functionality.
```

### Refactoring

```bash
/implement-feature refactor this StatefulWidget to ConsumerWidget
Convert the existing StatefulWidget to use ConsumerWidget with proper Riverpod providers.
```

### API Integration

```bash
/implement-feature payment integration
Create payment processing with Stripe integration, error handling, and success states.
```

### Backend Functions

```bash
/implement-feature user management functions
Create Cloud Functions for user CRUD operations with proper validation and error handling.
```

### Responsive Design

```bash
/implement-feature responsive dashboard
Create a responsive dashboard with mobile, tablet, and desktop layouts.
```

### Accessibility Features

```bash
/implement-feature accessible form
Create a form with proper accessibility support, semantic labels, and screen reader compatibility.
```

## Auto-Detection

The AI automatically detects and applies:

### **Unified Architecture Pattern**

- ✅ **Standard Layer Structure**: Consistent across Frontend, Backend, Scripts, and Rules Testing

#### **Frontend (Flutter)**

- ✅ **Entry Layer**: `FeaturePage` (StatelessWidget) → `FeatureView` (ConsumerWidget)
- ✅ **State Management**: `FeatureProvider` + `FeatureUIProvider` + `FeatureFormProvider`
- ✅ **Service Layer**: `FeatureFunctionsService` (FlutterCommon) → Cloud Functions
- ✅ **Model Layer**: `FeatureModel` (Equatable) with copyWith(), fromFirestore(), toFirestore()
- ✅ **Widget Layer**: `FeatureCard` + `FeatureForm` + `FeatureActions` + `FeatureList`
- ✅ **UIState Pattern**: executeWithLoading() for async operations with automatic state management
- ✅ **Centralized Navigation**: NavigationService with route constants from app_paths.dart
- ✅ **Single-Operation CRUD**: Automatic state management with proper error handling
- ✅ **Responsive Design**: Proper breakpoints and adaptive layouts
- ✅ **Accessibility**: Semantic labels and screen reader support
- ✅ **ConsumerWidget** (never StatefulWidget)
- ✅ **AutoDispose providers** for temporary state
- ✅ **copyWith() methods** for immutable updates
- ✅ **Error boundaries** with fallback UI
- ✅ **Barrel exports** (index.dart) for clean imports

#### **Backend (Cloud Functions)**

- ✅ **Function Layer**: `FeatureFunctions` (onCall/onRequest) with decorators
- ✅ **Service Layer**: `FeatureService` (business logic) with proper error handling
- ✅ **Interface Layer**: `FeatureInterfaces` (server-specific) + TSCommon imports
- ✅ **Validator Layer**: `FeatureValidators` (input validation) with schemas
- ✅ **Response Layer**: `ApiResponse<T>` (standardized responses) with error handling
- ✅ **Decorators**: `withAuth`, `withRole`, `withValidation` for consistent middleware
- ✅ **Error Handling**: `HttpsError` with structured error responses
- ✅ **Logging**: Firebase Functions logger with structured data
- ✅ **Authentication**: Proper auth checks and role-based access
- ✅ **Rate Limiting**: Security measures and input validation

#### **Scripts (CLI Tools)**

- ✅ **Entry Layer**: `index.ts` (CLI entry point) with interactive menu
- ✅ **Command Layer**: `FeatureCommands` (CLI actions) with prompts and validation
- ✅ **Service Layer**: `FeatureServices` (Firebase operations) with singleton pattern
- ✅ **Story Layer**: `FeatureStories` (business logic) with proper error handling
- ✅ **Type Layer**: `FeatureTypes` (TypeScript types) for CLI interfaces
- ✅ **Interactive CLI**: Inquirer prompts with validation
- ✅ **Action Registry**: DRY approach with extensible CLI actions
- ✅ **Error Handling**: Try-catch blocks with proper exit codes
- ✅ **Environment Support**: Development, staging, and production configurations

#### **Rules Testing (Firebase Rules)**

- ✅ **Test Layer**: `FeatureSpec` (test files) with describe/it structure
- ✅ **Helper Layer**: `TestHelpers` (setup/teardown) with test data management
- ✅ **Assertion Layer**: `assertSucceeds/assertFails` (Firebase rules testing)
- ✅ **Environment Layer**: `TestEnvironment` (Firebase emulator setup) with cleanup
- ✅ **Data Layer**: `TestData` (mock data) with realistic test scenarios
- ✅ **Test Isolation**: Proper setup/teardown between test cases
- ✅ **Positive/Negative Cases**: Both success and failure scenarios
- ✅ **Test Reports**: HTML and JSON reports for CI/CD integration

### **DRY Principles**

- ✅ **Reuses existing services** from FlutterCommon/TSCommon
- ✅ **Extracts reusable widgets** to separate files
- ✅ **Follows established patterns** instead of reinventing
- ✅ **Consolidates similar functionality** using enums/constants
- ✅ **Single responsibility** - one provider per feature
- ✅ **Uses barrel exports** for clean imports and organization
- ✅ **Implements responsive utilities** for consistent breakpoints
- ✅ **Reuses error handling patterns** across all features

### **Quality Standards**

- ✅ **Proper documentation** with Dart Docs/JSDoc
- ✅ **Const constructors** where possible
- ✅ **Proper imports** and exports
- ✅ **Copyright headers** on all files
- ✅ **Linting compliance** - passes all rules
- ✅ **Responsive design** with proper breakpoints
- ✅ **Accessibility compliance** with semantic labels
- ✅ **Error handling** with user-friendly messages
- ✅ **Logging and monitoring** with structured data

## Examples

### Products Flow

```bash
/implement-feature products management
```

**Generates:**

- Product model with Firestore integration
- Product providers (data + UI state)
- Product pages (list, detail, form)
- Product widgets (cards, forms, uploads)
- Backend Cloud Functions
- Complete CRUD operations
- Responsive design with mobile/tablet/desktop layouts
- Accessibility support with semantic labels
- Error boundaries with fallback UI

### User Profile

```bash
/implement-feature user profile editing
```

**Generates:**

- Profile form with validation
- Image upload with preview
- Success/error states
- Integration with auth system
- Responsive design for all screen sizes
- Accessibility support with proper labels
- Error boundaries with fallback UI

### Notifications

```bash
/implement-feature notification system
```

**Generates:**

- Notification model and service
- Real-time updates
- Mark as read functionality
- Push notification integration
- Responsive notification UI
- Accessibility support for screen readers
- Error handling with fallback states

### Form Validation

```bash
/implement-feature form with validation
```

**Generates:**

- Form with proper validation
- Error handling and display
- Success states
- Integration with UIState pattern
- Responsive form layout
- Accessibility support with proper labels
- Error boundaries with fallback UI

### API Service

```bash
/implement-feature API service for external data
```

**Generates:**

- Service class with error handling
- TypeScript interfaces
- Proper logging
- Response parsing
- Proper error handling with HttpsError
- Structured logging with Firebase Functions logger
- Input validation with schemas

## File Structure

The AI automatically generates the correct file structure:

### Flutter/Dart (Unified Architecture)

```text
# FlutterCommon (Shared)
packages/FlutterCommon/lib/
├── models/
│   └── [feature]_model.dart
├── services/
│   └── [feature]_functions_service.dart
├── providers/
│   └── [feature]_providers.dart
└── validators/
    └── [feature]_validators.dart

# Client App
client/lib/
├── pages/
│   └── [feature]_page.dart
├── views/
│   └── [feature]_view.dart
└── widgets/
    ├── [feature]_card.dart
    ├── [feature]_form.dart
    ├── [feature]_actions.dart
    ├── [feature]_list.dart
    └── index.dart (barrel export)

# Admin App
admin/lib/
├── pages/
│   └── [feature]_page.dart
├── views/
│   └── [feature]_view.dart
└── widgets/
    ├── [feature]_card.dart
    ├── [feature]_form.dart
    ├── [feature]_actions.dart
    ├── [feature]_list.dart
    └── index.dart (barrel export)
```

### TypeScript/Node (Complete Backend)

```text
# Cloud Functions
server/functions/src/
├── interfaces/
│   └── [feature]_interfaces.ts
├── services/
│   └── [feature]_service.ts
├── validators/
│   └── [feature]_validators.ts
├── [feature]/
│   ├── create[Feature].ts
│   ├── update[Feature].ts
│   ├── delete[Feature].ts
│   └── get[Feature]s.ts
├── decorators/
│   ├── withAuth.ts
│   ├── withRole.ts
│   └── withValidation.ts
└── utils/
    └── error_handler.ts

# Scripts (CLI Tools)
scripts/src/
├── commands/
│   └── [feature]_commands.ts
├── services/
│   └── [feature]_service.ts
├── stories/
│   └── [feature]_stories.ts
├── interfaces/
│   └── [feature]_interfaces.ts
├── types/
│   └── [feature]_types.ts
└── index.ts (CLI entry point)

# Rules Testing
rules_testing/src/
├── firestore/
│   └── [feature].spec.ts
├── database/
│   └── [feature].spec.ts
├── storage/
│   └── [feature].spec.ts
├── helpers/
│   ├── test-helpers.ts
│   └── test-data.ts
└── reports/
    ├── test-report.html
    └── test-report.json

# TSCommon (Shared)
packages/TSCommon/src/
├── types/
│   └── [feature]_types.ts
├── enums/
│   └── [feature]_enums.ts
├── constants/
│   └── [feature]_constants.ts
└── interfaces/
    └── [feature]_interfaces.ts
```

## Integration Points

The AI automatically integrates with:

- **Existing services** (FirestoreService, FunctionsService, AuthService, StorageService, CrashlyticsService, RemoteConfigService)
- **UIState pattern** for consistent state management
- **NavigationService** for proper navigation
- **Route constants** from app_paths.dart
- **Design system** (AppColors, AppSizes, AppTypography)
- **Validation patterns** and error handling
- **Responsive utilities** for consistent breakpoints
- **Accessibility patterns** for inclusive design
- **Error handling patterns** with user-friendly messages
- **Logging patterns** with structured data

## Quality Assurance

All generated code:

- ✅ **Follows project.mdc rules** - Every architectural pattern applied
- ✅ **Uses established patterns** - No reinventing the wheel
- ✅ **Implements proper error handling** - Try-catch everywhere
- ✅ **Includes proper documentation** - Dart Docs/JSDoc
- ✅ **Passes linting rules** - Clean, formatted code
- ✅ **Is production-ready** - Immediate use without modifications
- ✅ **Follows DRY principles** - No code duplication
- ✅ **Uses type-safe code** - No dynamic types
- ✅ **Implements responsive design** - Works on all screen sizes
- ✅ **Includes accessibility support** - Screen reader compatible
- ✅ **Has proper error boundaries** - Graceful error handling
- ✅ **Includes proper logging** - Structured data for monitoring

## Smart Features

The AI automatically:

- **Detects existing patterns** and reuses them
- **Applies the right provider type** (AsyncNotifier, StateNotifier, Provider)
- **Generates proper state classes** with copyWith() methods
- **Creates reusable widgets** in separate files
- **Implements proper error handling** with user-friendly messages
- **Uses existing services** instead of duplicating logic
- **Follows naming conventions** consistently
- **Generates complete implementations** - no partial code
- **Implements responsive design** with proper breakpoints
- **Adds accessibility support** with semantic labels
- **Creates error boundaries** with fallback UI
- **Implements proper logging** with structured data

## Usage Tips

1. **Be descriptive** - The more details you provide, the better the output
2. **Reference existing features** - "Like the products flow but for categories"
3. **Specify requirements** - "With image upload and validation"
4. **Mention integrations** - "Integrate with existing auth system"
5. **Specify responsive needs** - "Mobile-first design with tablet and desktop layouts"
6. **Mention accessibility** - "With screen reader support and semantic labels"
7. **Specify error handling** - "With proper error boundaries and fallback UI"

## Usage Examples

### Complete Feature

```bash
/implement-feature products management system with CRUD operations, image upload, category integration, search, filtering, and real-time updates
```

### Quick Component

```bash
/implement-feature user profile form with image upload and validation
```

### Code Refactoring

```bash
/implement-feature refactor this form to use ConsumerWidget and UIState pattern
```

### Backend Integration

```bash
/implement-feature payment processing with Stripe integration and error handling
```

### Responsive Design

```bash
/implement-feature responsive dashboard with mobile, tablet, and desktop layouts
```

### Accessibility Features

```bash
/implement-feature accessible form with screen reader support and semantic labels
```

### Error Handling

```bash
/implement-feature error boundaries with fallback UI and proper error handling
```

The AI will generate **complete, production-ready code** that follows all architectural patterns and DRY principles! 🚀
