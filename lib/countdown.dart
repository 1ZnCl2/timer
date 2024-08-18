import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'dart:math';
import 'dart:async';

class Countdowner extends StatefulWidget {
  const Countdowner({super.key});

  @override
  State<Countdowner> createState() => _Countdowner();
}

class _Countdowner extends State<Countdowner> {
  final CountDownController _controller = CountDownController();
  int count = 0;

  List<Widget> fiveTimers = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // 5분마다 fiveTimer를 생성
    _timer = Timer.periodic(
      const Duration(minutes: 5),
      (timer) {
        setState(
          () {
            if (count < 4) {
              count++;
              fiveTimers.add(fiveTimer(count));
            } else {
              // 타이머를 최대 4번 생성 후 초기화
              count = 0;
              fiveTimers.clear();
            }
          },
        );
      },
    );
  }

  Widget basicTimer() {
    return CircularCountDownTimer(
      width: 200,
      height: 200,
      duration: 1500,
      controller: _controller,
      fillColor: const Color.fromARGB(255, 26, 26, 26),
      ringColor: Colors.white,
      strokeCap: StrokeCap.round,
      strokeWidth: 10,
      isReverseAnimation: true,
      isReverse: true,
      isTimerTextShown: true,
    );
  }

  Widget fiveTimer(int count) {
    return Transform.rotate(
      angle: 2 * (4 - count) * pi / 5,
      child: CircularCountDownTimer(
        width: 200,
        height: 200,
        initialDuration: 1200,
        controller: _controller,
        duration: 1500,
        fillColor: Colors.lightBlueAccent,
        ringColor: const Color.fromARGB(0, 255, 255, 255),
        strokeCap: StrokeCap.round,
        strokeWidth: 10,
        isReverse: true,
        isReverseAnimation: true,
        isTimerTextShown: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        basicTimer(),
        ...fiveTimers,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 40,
            ),
            IconButton(
              onPressed: () => _controller.pause,
              icon: const Icon(
                Icons.stop,
              ),
            ),
          ],
        )
      ],
    );
  }
}
