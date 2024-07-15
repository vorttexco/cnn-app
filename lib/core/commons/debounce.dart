import 'dart:async';

class Debounce {
  Duration delay;
  Timer? _timer;

  Debounce({this.delay = const Duration(milliseconds: 600)});

  call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}
