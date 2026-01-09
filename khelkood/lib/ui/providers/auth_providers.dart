// This source code was written for the khelkood monorepo.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the phone input controller
/// Automatically disposes the controller when the provider is no longer watched
final authPhoneControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) {
    final controller = TextEditingController();
    ref.onDispose(controller.dispose);
    return controller;
  },
);

/// Provider for the OTP input controllers (6 digits)
final otpControllersProvider =
    Provider.autoDispose<List<TextEditingController>>((ref) {
      final controllers = List.generate(6, (_) => TextEditingController());
      ref.onDispose(() {
        for (var controller in controllers) {
          controller.dispose();
        }
      });
      return controllers;
    });

/// Provider for the OTP focus nodes
final otpFocusNodesProvider = Provider.autoDispose<List<FocusNode>>((ref) {
  final nodes = List.generate(6, (_) => FocusNode());
  ref.onDispose(() {
    for (var node in nodes) {
      node.dispose();
    }
  });
  return nodes;
});

/// Provider for loading state during auth operations

final authLoadingProvider = NotifierProvider<AuthLoadingNotifier, bool>(
  AuthLoadingNotifier.new,
);

class AuthLoadingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setLoading(bool value) => state = value;
}
