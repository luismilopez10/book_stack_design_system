import 'dart:async';

class BsDebouncer<T> {
  BsDebouncer({required this.duration, this.onValue});

  final Duration duration;
  void Function(T value)? onValue;

  T? _value;
  Timer? _timer;

  T get value => _value as T;

  set value(T newValue) {
    _value = newValue;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue?.call(_value as T));
  }

  void dispose() {
    _timer?.cancel();
  }
}
