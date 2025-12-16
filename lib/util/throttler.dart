import 'dart:async';

class Throttler<T> {
  final Duration delay;
  Timer? _timer;
  bool _ready = true;
  T? latest;

  Throttler({required this.delay});

  void run(T? value, void Function(T? value) action) {
    latest = value;

    if (!_ready) return;
    _ready = false;
    action(latest);

    _timer = Timer(delay, () {
      _ready = true;
      if (latest != null) {
        action(latest);
      }
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
