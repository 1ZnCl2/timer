import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'dart:math';
import 'dart:async';
import 'package:timer3/navigator_button.dart';

class Countdowner extends StatefulWidget {
  const Countdowner({super.key});

  @override
  State<Countdowner> createState() => _Countdowner();
}

class _Countdowner extends State<Countdowner> {
  final List<CountDownController> _controllers =
      List.generate(3, (_) => CountDownController());
  bool _running = true;
  int count = 0;
  List<Widget> fiveTimers = [];
  Timer? _timer;
  int remainTime = 1500;

  @override
  void initState() {
    super.initState();
    fiveTimers.add(firstFive(count));
    startTimer(); // 위젯이 생성될 때 자동으로 타이머를 시작합니다.
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainTime > 0 && _running) {
          print("remainTime : $remainTime, count : $count");
          remainTime--; // remainTime만 감소시킴
          if (count < 4 && remainTime % 300 == 0) {
            setState(() {
              // 위젯 추가 시에만 setState를 호출
              count++;
              fiveTimers.add(fiveTimer(count));
            });
          }
          setState(() {}); // 기본적인 상태 변경을 위해 호출
        } else {
          _timer?.cancel();
          setState(() {
            _running = false;
          });
        }
      },
    );
  }

  void pauseTimer() {
    _timer?.cancel();

    setState(
      () {
        _running = false;
      },
    );
  }

  void resumeTimer() {
    setState(
      () {
        _running = true;
      },
    );
    startTimer();
  }

  // 아래에 깔릴 basic timer입니다.
  Widget basicTimer(int count) {
    return CircularCountDownTimer(
      width: 200,
      height: 200,
      controller: _controllers[0],
      initialDuration: count * 300,
      duration: 1500,
      fillColor: const Color(0xFFFFFFFF),
      ringColor: const Color(0xFF000000),
      strokeCap: StrokeCap.round,
      strokeWidth: 10,
      isReverseAnimation: true,
      isReverse: true,
      isTimerTextShown: true,
      textStyle: const TextStyle(
        fontSize: 30,
        color: Color(0xFFACF000),
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // 소현님께서 원하시는 게 최초 5분 타이머는 트리거를 위한 5분인 것 같아서 first five minute timer를 만들었습니다.
  // firstFive는 최초 한 번만 호출됩니다.
  Widget firstFive(int count) {
    return Transform.rotate(
      angle: 2 * (4 - count) * pi / 5,
      child: CircularCountDownTimer(
        width: 200,
        height: 200,
        initialDuration: 1200,
        controller: _controllers[1],
        duration: 1500,
        fillColor: const Color(0xFF00C3CC),
        ringColor: const Color.fromARGB(0, 255, 255, 255),
        strokeCap: StrokeCap.round,
        strokeWidth: 10,
        isReverse: true,
        isReverseAnimation: true,
        isTimerTextShown: false,
      ),
    );
  }

  // first five timer 이후에 호출되는 5분짜리 타이머입니다.
  Widget fiveTimer(int count) {
    return Transform.rotate(
      // 5분이 지날 때마다 각도가 달라지도록 설정했습니다.
      angle: 2 * (4 - count) * pi / 5,
      child: CircularCountDownTimer(
        width: 200,
        height: 200,
        initialDuration: 1200,
        controller: _controllers[2],
        duration: 1500,
        fillColor: const Color(0xFF8097FF),
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
        basicTimer(count),
        ...fiveTimers,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "남은 시간",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            // IconButton(
            // onPressed: conversion,
            // icon: Icon(
            // _running ? Icons.stop : Icons.play_arrow,
            // ),
            // ),
            IconButton(
              onPressed: () {
                pauseTimer();
                for (var controller in _controllers) {
                  controller.pause();
                }

                showGeneralDialog(
                  context: context,
                  barrierDismissible: true, // 사용자가 다이얼로그 바깥을 누르면 창을 닫습니다
                  barrierLabel: "",
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration:
                      const Duration(milliseconds: 200), // 애니메이션 시간입니다
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
                            const SizedBox(
                              height: 5,
                            ),
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
                                    resumeTimer();
                                    for (var controller in _controllers) {
                                      controller.resume();
                                    }
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
