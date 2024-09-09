import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:timer_riverpod/countdowner/navigator_button.dart';
import 'dart:math';
import 'package:timer_riverpod/countdowner/state.dart';

class Countdowner extends ConsumerStatefulWidget {
  const Countdowner({super.key});

  @override
  _CountdownerState createState() => _CountdownerState();
}

class _CountdownerState extends ConsumerState<Countdowner> {
  final _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(timerProvider);
    final timerNotifier = ref.read(timerProvider.notifier);

    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: 2 * (4 - timerState.count) * pi / 5,
          child: CircularCountDownTimer(
            width: 220,
            height: 220,
            initialDuration: 1200,
            controller: _controller,
            duration: 1500,
            strokeWidth: 10,
            isTimerTextShown: false,
            isReverseAnimation: true,
            isReverse: true,
            strokeCap: StrokeCap.round,
            fillColor: const Color.fromARGB(0, 255, 255, 255),
            ringColor: const Color(0xFF8097FF),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "남은 시간",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "${timerState.remainTime ~/ 60}분 ${timerState.remainTime % 60}초",
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 5),
            IconButton(
              onPressed: () {
                timerNotifier.pauseTimer();
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: "",
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (context, animation1, animation2) {
                    return Center(
                      child: Container(
                        width: 300,
                        height: 180,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "잠시 정지했어요",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF424454),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const NaviIcon(
                                  color: Color(0xFFFF614C),
                                  icon: Icons.stop_circle,
                                ),
                                const NaviIcon(
                                  color: Color(0xFF8AC000),
                                  icon: Icons.check_circle,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    timerNotifier.resumeTimer();
                                    _controller.resume();
                                  },
                                  icon: const Icon(
                                    Icons.play_circle,
                                    color: Color(0xFF00C3CC),
                                    size: 40,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.stop),
            ),
          ],
        )
      ],
    );
  }
}
