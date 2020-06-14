import 'package:flutter/widgets.dart';

class VBox extends StatelessWidget {
  final double size;

  const VBox(this.size);

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}
