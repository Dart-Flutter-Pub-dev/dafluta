import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class KeyboardController extends StatelessWidget {
  final Widget child;

  const KeyboardController({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => Keyboard.hide(context), child: child);
  }
}
