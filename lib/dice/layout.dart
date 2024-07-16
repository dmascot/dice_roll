import 'package:dice_roll/dice/config.dart' as settings;
import 'package:flutter/material.dart';

import 'dice.dart';

/// This is arguably the most important class
/// - it defines layout of the app based on available height
/// - it uses LayoutBuilder to cater for layout change based on device height
///   i.e. portrait and landscape orientation for most devices, though it is
///   good practice to use height/width constrain instead of orientation
/// - it displays dice as a button, which on touch/tap calls rollAllDice
/// - it has buttons to add / remove dice from screen
/// - add/remove buttons are grey and non-functional when
///   maxDiceCount/minDiceCount is reached respectively
///
/// Params: All of these are provided by the stateful-class defined in page.dart
///  - diceFaceValues: list of values for dice to display
///  - isDiceCountMax: is a fn which returns a boolean value which returns true
///     if we have reached maxDiceCount
///  - isDiceCountMin: is a fn which returns boolean value which returns true
///    if we have reached minDiceCount
///  - addDice: is a fn to add more dice to screen until we reach maxDiceCount
///  - removeDice: is a fn to remove dice from screen until we reach minDiceCount
///  - rollAllDice: is a fn to regenerate random values and update dices on screen
///
/// Dependencies:
///  - dice.dart : displays dice with desired face on screen
///  - config.dart: provides constrains for app
///
/// Notes:
/// - We should enforce minimum width and height requirement and display a
///   message along line "not playable" for screen that does not meet these
///   requirements

class DiceLayout extends StatelessWidget {
  final List<int> diceFaceValues;
  final ValueGetter<bool> isDiceCountMax, isDiceCountMin;
  final VoidCallback addDice, removeDice, rollAllDice;

  const DiceLayout({
    required this.diceFaceValues,
    required this.isDiceCountMax,
    required this.isDiceCountMin,
    required this.addDice,
    required this.removeDice,
    required this.rollAllDice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool moveTotalToRight = constraints.maxHeight < 350;
      return moveTotalToRight
          ? Column(
              children: [
                Expanded(
                    child: Column(
                  children: [_buildSumLayout()],
                )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildDiceLayout(constraints),
                  ),
                ),
                _buildButtonsLayout()
              ],
            )
          : Column(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_buildSumLayout()],
                )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _buildDiceLayout(constraints),
                )),
                _buildButtonsLayout()
              ],
            );
    });
  }

  /// function to build layout to
  ///  - display dice
  ///  - call rollAllDice when any of the dice on screen is tapped
  List<Widget> _buildDiceLayout(BoxConstraints constraints) {
    List<Widget> rows = [];
    // ceil here makes sure we always have a number rounding - up
    int rowsCount = (diceFaceValues.length / settings.maxDicePerRow).ceil();

    for (int i = 0; i < rowsCount; i++) {
      List<Widget> rowChildren = [];

      for (int j = 0; j < settings.maxDicePerRow; j++) {
        int index = i * settings.maxDicePerRow + j;
        if (index < diceFaceValues.length) {
          rowChildren.add(
            GestureDetector(
              onTap: rollAllDice,
              child: Dice(faceValue: diceFaceValues[index]),
            ),
          );
        }
      }

      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowChildren,
        ),
      );
    }

    return rows;
  }

  /// this fn simply sums up all values in diceFaceValues
  Widget _buildSumLayout() {
    int sum = diceFaceValues.reduce((a, b) => a + b);

    return Container(
      margin: const EdgeInsets.all(4.0),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(color: Colors.white, width: 4.0)),
      child: Center(
        child: Text(
          "$sum",
          style: const TextStyle(
            fontSize: 30,
            letterSpacing: 3,
            color: Colors.deepPurpleAccent,
            fontFamily: "Norge",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// this fn builds button layout with
  /// - plus icon to add more dice on screen using addDice fn
  /// - minus icon to remove dice from screen using removeDice fn
  Widget _buildButtonsLayout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              size: 40,
              Icons.add_circle,
              color: isDiceCountMax() ? Colors.grey : Colors.green,
            ),
            onPressed: isDiceCountMax() ? null : addDice,
          ),
          IconButton(
            icon: Icon(
              size: 40,
              Icons.remove_circle,
              color: isDiceCountMin() ? Colors.grey : Colors.red,
            ),
            onPressed: isDiceCountMin() ? null : removeDice,
          ),
        ],
      ),
    );
  }
}
