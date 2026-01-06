# Update Rules Testing

This command analyzes the current Firebase Security Rules and updates the `rules_testing/` test suite to ensure comprehensive coverage and alignment with the latest rule changes.

## Instructions

The command will automatically:

1. **Analyze Current Rules**: Parse `firestore.rules`, `storage.rules`, and `database.rules.json` to understand the current security model
2. **Identify Missing Tests**: Compare existing test coverage against current rules to find gaps
3. **Update Test Files**: Modify or create test files to cover all rule scenarios
4. **Validate Test Structure**: Ensure tests follow the established patterns and use proper helpers
5. **Update Documentation**: Refresh README files with current test coverage information

## What Gets Updated

### **Firestore Rules Testing**

- **Collections**: `users`, `brands`, `brandApprovals`, `items`, `categories`, `notifications`
- **Subcollections**: `questionnaireAnswers` under users
- **Helper Functions**: `isAuthenticated()`, `isSuperAdmin()`, `isBrandAdmin()`, `isApprovedBrandAdmin()`, `isOwner()`, `isBrandOwner()`
- **Access Patterns**: Read, write, update, delete operations for each role

### **Storage Rules Testing**

- **User Images**: `/images/users/{userId}/{fileName}` with customer role validation
- **Brand Images**: `/images/brands/{brandId}/{fileName}` with brand admin role validation
- **File Validation**: Image type checking (jpeg, jpg, png, webp) and 2MB size limit
- **Access Patterns**: Read, write, delete operations with proper authentication

### **Database Rules Testing**

- **Collections**: `users`, `brands`, `brandApprovals`, `items`, `categories`, `notifications`
- **Subcollections**: `questionnaireAnswers` under users
- **Completion Flag Protection**: Prevents client-side manipulation of `hasCompletedQuestionnaire`
- **Role-Based Access**: Super admin, brand admin, approved brand admin permissions

## Test Coverage Areas

### **User Roles Tested**

- **Super Admins**: Full access to all collections, can write categories
- **Brand Admins**: Access to their own brand data and approval requests (read-only)
- **Approved Brand Admins**: Access to items and categories for content management
- **Regular Users**: Access to their own user data and notifications (read-only)
- **Unauthenticated Users**: Denied access to all protected resources

### **Security Scenarios**

- **Authentication**: Valid vs invalid user tokens
- **Authorization**: Role-based access control
- **Data Isolation**: Users can only access their own data
- **File Validation**: Type and size restrictions for uploads
- **Completion Flag Protection**: Prevents client-side manipulation
- **Cross-User Access**: Prevents accessing other users' data

## Expected Output

The command will:

1. **Update Existing Tests**: Modify current test files to match rule changes
2. **Add Missing Tests**: Create new test cases for uncovered scenarios
3. **Fix Test Data**: Update test helpers and data factories
4. **Validate Coverage**: Ensure 100% rule coverage across all services
5. **Update Reports**: Refresh test documentation and coverage reports

## Usage

Type `/update_rules_testing` in Cursor chat to automatically update the entire test suite based on current Firebase rules.

## Integration Points

The command automatically integrates with:

- **Existing Test Helpers**: Uses `test-helpers.ts` for consistent test data
- **TSCommon Package**: Leverages real enums and constants from the common package
- **Mocha Test Framework**: Maintains compatibility with current test structure
- **Firebase Emulators**: Ensures tests work with local development environment
- **Mochawesome Reports**: Updates test reporting and coverage documentation

## Quality Assurance

All updated tests will:

- ✅ **Follow Established Patterns**: Use existing test structure and helpers
- ✅ **Maintain Type Safety**: Use proper TypeScript interfaces and types
- ✅ **Include Proper Documentation**: JSDoc comments for all test functions
- ✅ **Use Real Data**: Leverage TSCommon enums and constants
- ✅ **Ensure Cleanup**: Proper test isolation and data cleanup
- ✅ **Pass Linting**: Follow project coding standards
- ✅ **Generate Reports**: Beautiful HTML test execution reports

## Smart Features

The command automatically:

- **Detects Rule Changes**: Compares current rules against existing tests
- **Identifies Gaps**: Finds missing test coverage for new or modified rules
- **Preserves Working Tests**: Only updates tests that need changes
- **Maintains Consistency**: Ensures all tests follow the same patterns
- **Updates Documentation**: Refreshes README files with current information
- **Validates Structure**: Checks test file organization and naming

## Examples

### Complete Rules Update

```bash
/update_rules_testing
```

**What happens:**

- Analyzes all three Firebase rules files
- Updates 15+ test files across Firestore, Storage, and Database
- Refreshes test helpers and data factories
- Updates documentation and coverage reports
- Ensures 100% rule coverage

### Targeted Updates

The command can also handle specific scenarios:

- **New Collection Added**: Automatically creates comprehensive tests
- **Rule Logic Changed**: Updates existing tests to match new behavior
- **Helper Functions Added**: Creates tests for new security functions
- **File Path Changes**: Updates storage tests for new upload paths
- **Role Permissions Modified**: Adjusts test expectations for role changes

## Troubleshooting

### Common Issues

1. **Test Failures After Update**
   - Check Firebase emulator configuration
   - Verify test data setup in helpers
   - Ensure proper authentication contexts

2. **Missing Test Coverage**
   - Review rule changes for new scenarios
   - Check for edge cases in helper functions
   - Validate role-based access patterns

3. **Test Data Issues**
   - Update test helpers for new data structures
   - Check TSCommon package for updated enums
   - Verify storage path constants

### Debug Mode

Run with debug output:

```bash
/update_rules_testing --debug
```

## Success Metrics

After running the command, you should see:

- ✅ **100% Rule Coverage**: All rules tested across all services
- ✅ **All Tests Passing**: 85+ tests with 95%+ success rate
- ✅ **Updated Documentation**: README files reflect current coverage
- ✅ **Consistent Patterns**: All tests follow established structure
- ✅ **Real Data Usage**: Tests use TSCommon enums and constants
- ✅ **Beautiful Reports**: HTML test execution reports generated

The command ensures your Firebase Security Rules testing suite stays up-to-date with the latest rule changes! 🚀
