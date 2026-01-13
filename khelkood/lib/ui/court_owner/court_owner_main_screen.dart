import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'widgets/court_owner_bottom_nav.dart';

class CourtOwnerMainScreen extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const CourtOwnerMainScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CourtOwnerBottomNav(
        navigationShell: navigationShell,
      ),
    );
  }
}
