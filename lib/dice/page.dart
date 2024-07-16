import 'dart:math';

import 'package:dice_roll/dice/config.dart' as settings;
import 'package:dice_roll/dice/layout.dart';
import 'package:flutter/material.dart';

/// This is where core logic resides to maintain app state used by layout.dart
/// it provides logic for
/// - _addDice: fn to add more dice on screen until we reach maxDiceCount
/// - _removeDice: fn to remove dice from screen until we reach minDiceCount
/// - _rollAllDice: fn to update diceFaveValues with new random values of roll
/// - _isDiceCountMax: fn returning boolean value to check if we have reached
///   maxDiceCount
/// - _isDiceCountMin: fn returning boolean value to check if we have reached
///   minDiceCount
/// - _getFaceValue: fn to get random value between 0 to 6 and, retry if value
///   is 0, since we do not have dice with face having nothing a.k.a. 0
/// Params: none
///
/// Dependencies:
///  - config.dart: provides app constrains
///  - layout.dart: provides DiceLayout
class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  List<int> diceFaceValues = []; // Initialize with one dice

  _DicePageState() {
    if (diceFaceValues.isEmpty) {
      diceFaceValues.add(_getFaceValue());
    }
  }

  bool _isDiceCountMax() => diceFaceValues.length == settings.maxDiceCount;
  bool _isDiceCountMin() => diceFaceValues.length == settings.minDiceCount;

  int _getFaceValue() {
    int value = 0;
    while (value == 0) {
      value = Random().nextInt(7);
    }
    return value;
  }

  void _rollAllDice() {
    setState(() {
      for (int i = 0; i < diceFaceValues.length; i++) {
        diceFaceValues[i] = _getFaceValue();
      }
    });
  }

  void _removeDice() {
    setState(() {
      if (diceFaceValues.length > settings.minDiceCount) {
        diceFaceValues.removeLast();
      }
    });
  }

  void _addDice() {
    setState(() {
      if (diceFaceValues.length < settings.maxDiceCount) {
        diceFaceValues.add(_getFaceValue());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DiceLayout(
            diceFaceValues: diceFaceValues,
            rollAllDice: _rollAllDice,
            addDice: _addDice,
            removeDice: _removeDice,
            isDiceCountMin: _isDiceCountMin,
            isDiceCountMax: _isDiceCountMax,
          ),
        ),
      ],
    );
  }
}
