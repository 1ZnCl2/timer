import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class TimerState {
  final bool running;
  final int remainTime;
  final int count;

  TimerState({
    required this.running,
    required this.remainTime,
    required this.count,
  });

  TimerState copyWith({
    bool? running,
    int? remainTime,
    int? count,
  }) {
    return TimerState(
      running: running ?? this.running,
      remainTime: remainTime ?? this.remainTime,
      count: count ?? this.count,
    );
  }
}

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier()
      : super(TimerState(running: true, remainTime: 1500, count: 0)) {
    startTimer();
  }

  Timer? _timer;

  void startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.remainTime > 0 && state.running) {
          state = state.copyWith(remainTime: (state.remainTime - 1));

          if (state.count < 4 && state.remainTime % 300 == 0) {
            state = state.copyWith(count: (state.count + 1));
          }
        } else {
          _timer?.cancel();
          state = state.copyWith(running: false);
        }
      },
    );
  }

  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(running: false);
  }

  void resumeTimer() {
    if (state.running == false) {
      state = state.copyWith(running: true);
      startTimer();
    }
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>(
  (ref) {
    return TimerNotifier();
  },
);
