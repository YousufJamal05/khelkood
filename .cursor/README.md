# Cursor IDE Configuration

This directory contains IDE-specific configuration files for the JustPark monorepo.

## Files

### `.vscode/launch.json`
Debug configurations for all modules:
- **Consumer App** - Debug the consumer module
- **Enforcer App** - Debug the enforcer module  
- **Admin App** - Debug the admin module
- **Server** - Debug the Node.js backend
- **Compounds** - Launch multiple configurations simultaneously

Usage: Press `F5` or use the debug panel to select and run configurations.

### `.vscode/tasks.json`
Predefined tasks for common operations:
- `Consumer: Pub Get` - Install dependencies for consumer module
- `Enforcer: Pub Get` - Install dependencies for enforcer module
- `Admin: Pub Get` - Install dependencies for admin module
- `All Modules: Pub Get` - Install dependencies for all modules
- `Consumer/Enforcer/Admin: Clean` - Clean build artifacts
- `Server: Install Dependencies` - Install npm packages
- `Server: Run Dev Mode` - Start server in development mode
- `Flutter: Analyze All` - Run Flutter analyzer

Usage: Press `Ctrl+Shift+P` → "Tasks: Run Task" → Select task.

### `.vscode/settings.json`
Workspace-specific settings for VS Code/Cursor including:
- Dart/Flutter configuration
- File exclusions for build artifacts
- Format on save
- Editor settings

### `justpark.code-workspace`
Multi-root workspace configuration that organizes the monorepo structure for easy navigation between modules.

Usage: Open `justpark.code-workspace` in VS Code/Cursor.

### `.cursor/rules`
Project guidelines and conventions that help the AI assistant understand the project structure and best practices.

## Quick Start

1. **Open the workspace:**
   ```bash
   # In VS Code/Cursor
   File → Open Workspace from File → Select justpark.code-workspace
   ```

2. **Install dependencies:**
   - Press `Ctrl+Shift+P` → "Tasks: Run Task" → "All Modules: Pub Get"
   - For server: "Tasks: Run Task" → "Server: Install Dependencies"

3. **Start debugging:**
   - Press `F5` to select a debug configuration
   - Choose Consumer, Enforcer, Admin, Server, or a compound configuration

4. **Develop:**
   - Each module is independent
   - Hot reload works for Flutter modules
   - Server supports hot reload with nodemon (requires npm install nodemon --save-dev)

## Tips

- Use compound configurations to run multiple modules at once
- Each module can be developed independently
- The workspace provides easy navigation between consumer, enforcer, admin, and server folders
- Debugging configurations include proper cwd and program paths

