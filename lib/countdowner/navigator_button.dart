import 'package:flutter/material.dart';

class NaviIcon extends StatelessWidget {
  const NaviIcon({
    super.key,
    required this.color,
    required this.icon,
  });

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context); // 버튼을 누르면 다이얼로그 닫기
      },
      icon: Icon(
        icon,
        color: color,
        size: 40,
      ),
    );
  }
}
