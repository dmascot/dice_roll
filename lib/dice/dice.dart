import 'package:flutter/material.dart';

/// This class has a single function , i.e. to display appropriate dice on screen
///
/// Params: None
///
/// Dependencies:
/// - assets/dice/dice[1-6].png
///
/// Notes:
/// - width and height of SizeBox can be more dynamic
/// - colours should be set using theme instead of manual pick

class Dice extends StatelessWidget {
  final int faceValue;

  const Dice({required this.faceValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: 100,
        height: 100,
        child: ColorFiltered(
          colorFilter:
              const ColorFilter.mode(Colors.deepPurple, BlendMode.color),
          child: Image.asset(
            "assets/dice/dice$faceValue.png",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
