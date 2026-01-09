// This source code was written for the khelkood monorepo.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common/providers/app_initialization_provider.dart';
import 'design/app_theme.dart';
import 'routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the preferred orientation to portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  debugPrint("KhelKhood App Starting...");
  runApp(const ProviderScope(child: KhelkoodApp()));
}

class KhelkoodApp extends ConsumerWidget {
  const KhelkoodApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialization = ref.watch(appInitializationProvider);

    return initialization.when(
      loading: () {
        debugPrint('App initialization in progress...');
        return MaterialApp(
          title: 'KhelKhood',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      },
      error: (error, stack) {
        debugPrint('App initialization failed: $error');
        debugPrint('Stack trace: $stack');
        return MaterialApp(
          title: 'KhelKhood',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: Scaffold(
            body: Center(child: Text('Error: ${error.toString()}')),
          ),
        );
      },
      data: (_) {
        debugPrint('App initialization completed successfully');
        return MaterialApp.router(
          title: 'KhelKhood',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: ref.watch(AppRouter.routerProvider),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KhelKhood',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
