import 'package:flutter/scheduler.dart';

class Delayed {
  static void post(Function callback) => SchedulerBinding.instance
      .addPostFrameCallback((Duration duration) => callback());
}
