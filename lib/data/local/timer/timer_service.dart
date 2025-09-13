import 'dart:async';

import 'package:whispr/util/constants.dart';

class TimerService {
  final int tickMillis;
  final _controller = StreamController<Duration>.broadcast();
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _ticker;

  TimerService({
    this.tickMillis = WhisprDuration.timerTickUpdateMillis,
  });

  Stream<Duration> get timerStream => _controller.stream;

  bool get isRunning => _stopwatch.isRunning;

  Duration get elapsed => _stopwatch.elapsed;

  void start() {
    if (isRunning || _ticker != null) return;
    _stopwatch.start();
    _subscribeTick();
  }

  void pause() {
    if (!isRunning) return;
    _stopwatch.stop();

    // Stop and dispose ticker.
    _ticker?.cancel();
    _ticker = null;
  }

  void resume() {
    if (isRunning) return;
    _stopwatch.start();
    _subscribeTick();
  }

  void reset() {
    _stopwatch.reset();
    _controller.add(Duration.zero);

    // Stop and dispose ticker.
    _ticker?.cancel();
    _ticker = null;
  }

  void dispose() {
    _ticker?.cancel();
    _ticker = null;
    _stopwatch.stop();
    _controller.close();
  }

  void _subscribeTick() {
    _ticker ??= Timer.periodic(Duration(milliseconds: tickMillis), (_) {
      if (!_controller.isClosed) _controller.add(_stopwatch.elapsed);
    });
  }
}
