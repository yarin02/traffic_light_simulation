import 'dart:async';
import 'package:flutter/material.dart';

/// A provider that uses a single global timer to track the elapsed time.
class GlobalTimerProvider extends ChangeNotifier {
  DateTime _startTime;
  Timer? _timer;

  GlobalTimerProvider() : _startTime = DateTime.now() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      notifyListeners();
    });
  }

  /// Returns the duration elapsed since the provider started.
  Duration get elapsed => DateTime.now().difference(_startTime);

  /// Resets the timer.
  void reset() {
    _startTime = DateTime.now();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
