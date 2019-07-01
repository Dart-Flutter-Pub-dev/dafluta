import 'package:flutter/widgets.dart';

class DialogController {
  final BuildContext _context;

  const DialogController(this._context);

  void close() {
    Navigator.of(_context).pop();
  }
}
