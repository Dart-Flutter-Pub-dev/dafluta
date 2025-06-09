import 'package:flutter/widgets.dart';

class OnClose extends StatelessWidget {
  final VoidCallback onClose;
  final Widget child;

  const OnClose({required this.onClose, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          onClose();
        }
      },
      child: child,
    );
  }
}
