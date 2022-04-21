import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final int maxLength;
  final int currentIndex;

  static const Duration animationDuration = Duration(milliseconds: 300);

  const Progress({
    Key key,
    @required this.maxLength,
    @required this.currentIndex,
  }) : super(key: key);

  Widget buildBlankSpace() => const SizedBox(width: 10.0);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        maxLength * 2 - 1,
        (int index) => index % 2 == 1
            ? buildBlankSpace()
            : AnimatedContainer(
                duration: animationDuration,
                decoration: BoxDecoration(
                  color: index == currentIndex * 2
                      ? Color(0xFF6761D0)
                      : Color(0xFFCCD3DF),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                height: 8.0,
                width: index == currentIndex * 2 ? 36.0 : 8.0,
              ),
      ),
    );
  }
}
