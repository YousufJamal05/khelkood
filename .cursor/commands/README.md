# Cursor Commands

This directory contains AI command templates for the justpark monorepo. These commands leverage the comprehensive `project.mdc` rules to generate consistent, high-quality code.

## Main Command

### `/implement-feature`

The **single, powerful command** for all feature implementation and refactoring. It automatically applies all architectural patterns and follows DRY principles.

**Usage:** `/implement-feature [description]`

**Examples:**

```bash
/implement-feature products management system
/implement-feature contact form with validation
/implement-feature refactor this StatefulWidget to ConsumerWidget
/implement-feature payment integration with Stripe
/implement-feature user profile editing with image upload
```

## Specialized Commands

### `/update_rules_testing`

Analyzes current Firebase Security Rules and updates the `rules_testing/` test suite to ensure comprehensive coverage and alignment with the latest rule changes.

**Usage:** `/update_rules_testing`

**What it does:**
- Analyzes `firestore.rules`, `storage.rules`, and `database.rules.json`
- Updates test files to cover all rule scenarios
- Ensures 100% rule coverage across all Firebase services
- Maintains test consistency and follows established patterns

## Legacy Commands

### `/create-issue`

Generate GitHub issue descriptions from commit/PR information.

### `/create-pr`

Generate GitHub Pull Request descriptions from commit information.

## How It Works

1. **AI reads `project.mdc`** - Comprehensive architectural rules
2. **AI analyzes requirements** - Determines the best approach
3. **AI applies patterns** - Consistent code generation
4. **AI follows DRY principles** - Reuses existing patterns
5. **AI ensures quality** - Type-safe, documented, tested code

## Benefits

- ✅ **Single command** - No need to remember multiple commands
- ✅ **Auto-detection** - AI determines the best approach
- ✅ **Consistent code quality** across all features
- ✅ **Reduced development time** - AI gets it right the first time
- ✅ **Architectural compliance** - Follows all project rules
- ✅ **DRY implementation** - No code duplication
- ✅ **Production-ready code** - Immediate use without modifications
- ✅ **Rules testing automation** - Keeps Firebase security tests up-to-date

## Usage Tips

1. **Be descriptive** - The more details you provide, the better the output
2. **Reference existing features** - "Like the products flow but for categories"
3. **Specify requirements** - "With image upload and validation"
4. **Mention integrations** - "Integrate with existing auth system"

## Examples

### Complete Feature

```bash
/implement-feature products management system with CRUD operations, image upload, category integration, search, filtering, and real-time updates
```

### Quick Component

```bash
/implement-feature user profile form with image upload and validation
```

### Refactoring

```bash
/implement-feature refactor this form to use ConsumerWidget and UIState pattern
```

### Backend Integration

```bash
/implement-feature payment processing with Stripe integration and error handling
```

### Rules Testing Update

```bash
/update_rules_testing
```

The AI will generate **complete, production-ready code** that follows all architectural patterns and DRY principles! 🚀
