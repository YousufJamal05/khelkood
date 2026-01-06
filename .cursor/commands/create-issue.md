# Create GitHub Issue

This command generates a GitHub issue description using the existing [.github/ISSUE_TEMPLATE/](../../.github/ISSUE_TEMPLATE/) templates and commit/PR information.

## Instructions

The command will automatically:

1. **Detect Latest Commit**: Read the most recent commit message from git history
2. **Analyze Changes**: Determine which repositories were modified
3. **Generate Issue content with title and description**: Create a complete issue description following the appropriate template ([bug_report.md](../../.github/ISSUE_TEMPLATE/bug_report.md) or [feature_request.md](../../.github/ISSUE_TEMPLATE/feature_request.md)) and generate a title based on the commit message.

4. **Forecast Content**: Generate realistic issue content based on the commit/PR changes

## Optional Parameters

- **Specific Commit**: If you want to use a different commit, mention the commit hash
- **Issue Type**: Specify "bug" or "feature" to force a specific template (auto-detected if not specified)
- **PR Content**: Provide PR description content to generate a corresponding issue

## Expected Output

Generate a complete issue description in markdown format following the [bug_report.md](../../.github/ISSUE_TEMPLATE/bug_report.md) or [feature_request.md](../../.github/ISSUE_TEMPLATE/feature_request.md) template and generate a title based on the commit message, with:

- Proper issue type detection (bug vs feature) based on commit/PR content
- Concise title using present tense action verbs (Create, Implement, Fix, etc.)
- Detailed description that forecasts what the original issue would have contained
- Proper formatting preserved from the original templates
- Present tense throughout (e.g., "Add login feature" instead of "Added login feature")

## Usage

Type `/create-issue` in Cursor chat for automatic issue generation from the latest commit, or `/create-issue [commit-hash]` for a specific commit. You can also provide PR content directly for issue generation.

## Template Selection Logic

- **Bug Report**: Selected when commit/PR contains words like "fix", "bug", "error", "issue", "resolve", "correct"
- **Feature Request**: Selected when commit/PR contains words like "add", "implement", "create", "new", "feature", "enhance"
- **Default**: Feature Request if unclear