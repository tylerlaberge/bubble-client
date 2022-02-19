import 'dart:async';

class Schedule {

  static interval(Function() f, Duration duration) {
    f();
    Timer.periodic(duration, (_) => f());
  }
}