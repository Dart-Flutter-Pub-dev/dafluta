import 'package:flutter/scheduler.dart';

class InitCallback {
  static void register(Function callback) =>
      SchedulerBinding.instance!.addPostFrameCallback(
        (Duration duration) => callback(),
      );
}
