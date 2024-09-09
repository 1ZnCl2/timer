import 'package:flutter/material.dart';

class SmallTask extends StatelessWidget {
  SmallTask({
    super.key,
    required this.list,
  });
  List<String> list;

  List<Widget> listup(list) {
    List<Widget> buttons = [];

    for (int i = 0; i < 3; i++) {
      buttons.add(
        ElevatedButton(
          onPressed: () {},
          child: Text(list[i]),
        ),
      );
    }
    return buttons;
  }

  @override
  Widget build(context) {
    return Column(
      children: listup(list),
    );
  }
}
