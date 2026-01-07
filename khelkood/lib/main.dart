// This source code was written for the khelkood monorepo.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common/providers/app_initialization_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the preferred orientation to portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: KhelkoodApp()));
}

class KhelkoodApp extends ConsumerWidget {
  const KhelkoodApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialization = ref.watch(appInitializationProvider);

    return MaterialApp(
      title: 'Khelkood',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: Center(
          child: initialization.when(
            loading: () {
              debugPrint('App initialization in progress...');
              return const Text('App initialization in progress...');
            },
            error: (error, stack) {
              debugPrint('App initialization failed: $error');
              debugPrint('Stack trace: $stack');
              return Text(error.toString());
            },
            data: (_) {
              debugPrint('App initialization completed successfully');
              return const Text('App initialization completed successfully');
            },
          ),
        ),
      ),
    );
  }
}
