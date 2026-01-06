# Example Usage

This file demonstrates how to use the `/implement-feature` command for various scenarios.

## Products Flow Example

```bash
/implement-feature products management system
```

**What the AI generates:**

- Complete Product model with Firestore integration
- Product providers using UIState pattern
- Product pages (list, detail, form) as ConsumerWidgets
- Product widgets (cards, forms, uploads) in separate files
- Backend Cloud Functions with proper error handling
- Integration with existing services (FirestoreService, StorageService)

## Form Example

```bash
/implement-feature contact form with validation
```

**What the AI generates:**

- Contact form as ConsumerWidget
- Form validation with error handling
- UIState pattern for loading/success/error states
- Integration with existing validation patterns
- Proper error display and success feedback

## Refactoring Example

```bash
/implement-feature refactor this StatefulWidget to ConsumerWidget
```

**What the AI does:**

- Converts StatefulWidget to ConsumerWidget
- Implements proper Riverpod providers
- Uses UIState pattern for state management
- Extracts reusable widgets to separate files
- Follows all architectural patterns

## API Integration Example

```bash
/implement-feature payment processing with Stripe
```

**What the AI generates:**

- Payment service class with error handling
- TypeScript interfaces for payment data
- Cloud Functions for payment processing
- Proper validation and error responses
- Integration with existing error handling patterns

## Key Benefits

- **Single command** - No need to remember multiple commands
- **Auto-detection** - AI determines the best approach
- **Complete implementation** - Generates all necessary files
- **Architectural compliance** - Follows all project.mdc rules
- **DRY principles** - Reuses existing patterns and services
- **Production-ready** - Code is immediately usable
