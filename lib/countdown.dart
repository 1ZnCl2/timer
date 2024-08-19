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
  final List<CountDownController> _controllers =
      List.generate(5, (_) => CountDownController());
  bool _running = true;
  int count = 0;
  List<Widget> fiveTimers = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fiveTimers.add(firstFive(count));

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

  void conversion() {
    if (_running == true) {
      for (var controller in _controllers) {
        controller.pause();
      }
    } else {
      for (var controller in _controllers) {
        controller.resume();
      }
    }

    setState(() {
      _running = !_running;
    });
  }

  Widget basicTimer() {
    return CircularCountDownTimer(
      width: 200,
      height: 200,
      duration: 1500,
      controller: _controllers[0],
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

  Widget fiveTimer(int count) {
    return Transform.rotate(
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
        basicTimer(),
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
                for (var controller in _controllers) {
                  controller.pause();
                }
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true, // 사용자가 다이얼로그 바깥을 누르면 창을 닫음
                  barrierLabel: "",
                  barrierColor:
                      Colors.black.withOpacity(0.5), // 배경을 반투명 검은색으로 설정
                  transitionDuration:
                      const Duration(milliseconds: 200), // 애니메이션 시간
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
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context); // 버튼을 누르면 다이얼로그 닫기
                                  },
                                  icon: const Icon(
                                    Icons.stop_circle,
                                    color: Color(0xFFFF614C),
                                    size: 40,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF8AC000),
                                    size: 40,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
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
