import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common/common.dart';

final feedbackServiceProvider = Provider((ref) => FeedbackService());

class FeedbackService {
  OverlayEntry? _currentEntry;

  void showSuccess(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    _show(
      context,
      title: title,
      message: message,
      type: KhelKhoodFeedbackType.success,
    );
  }

  void showError(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    _show(
      context,
      title: title,
      message: message,
      type: KhelKhoodFeedbackType.error,
    );
  }

  void _show(
    BuildContext context, {
    required String title,
    required String message,
    required KhelKhoodFeedbackType type,
  }) {
    _currentEntry?.remove();
    _currentEntry = null;

    final overlay = Overlay.of(context);

    _currentEntry = OverlayEntry(
      builder: (context) => _FeedbackOverlay(
        title: title,
        message: message,
        type: type,
        onDismiss: () {
          _currentEntry?.remove();
          _currentEntry = null;
        },
      ),
    );

    overlay.insert(_currentEntry!);
  }
}

class _FeedbackOverlay extends StatefulWidget {
  final String title;
  final String message;
  final KhelKhoodFeedbackType type;
  final VoidCallback onDismiss;

  const _FeedbackOverlay({
    required this.title,
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  @override
  State<_FeedbackOverlay> createState() => _FeedbackOverlayState();
}

class _FeedbackOverlayState extends State<_FeedbackOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    // Auto-dismiss after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  void _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: KhelKhoodFeedback(
              title: widget.title,
              message: widget.message,
              type: widget.type,
              onClose: _dismiss,
            ),
          ),
        ),
      ),
    );
  }
}
