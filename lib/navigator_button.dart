import 'package:flutter/material.dart';

class naviIcon extends StatelessWidget {
  naviIcon({
    super.key,
    required this.color,
  });

  Color color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context); // 버튼을 누르면 다이얼로그 닫기
      },
      icon: Icon(
        Icons.stop_circle,
        color: color,
        size: 40,
      ),
    );
  }
}
