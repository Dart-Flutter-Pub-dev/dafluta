import 'package:flutter/widgets.dart';

class HBox extends StatelessWidget {
  final double size;

  const HBox(this.size);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
    );
  }
}
