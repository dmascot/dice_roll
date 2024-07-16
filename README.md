# Dice Roll

A simple app which can be used to play dice games

### Features
 - Add up to 6 dice 
 - use (sudo) random number generator to set dice face to be displayed on screen
 - switch layout dynamically based on available height ( i.e. orientation )
 - displays total count of all dice on screen

### Class Layout

```mermaid
---
title: Class layout
---
%%{
  init: {
    'theme': 'base',
    'themeVariables': {
      'darkMode': flase,
      'fontSize': '16px',
      'background': '#ffff',
      'primaryColor': '#dddd',
      'primaryTextColor': '#ffff',
      'primaryBorderColor': '#fff',
      'lineColor': '#F8B229',
      'secondaryColor': '#ffff',
      'tertiaryColor': '#ffff'
    }
  }
}%%
classDiagram
    App --|> DicePage
    DicePage --|> _DicePageState
    _DicePageState --|> DiceLayout
    _DicePageState --|> Config
    DiceLayout --|> LayoutBuilder
    DiceLayout --|> Dice
    DiceLayout --|> Config

    class App{
        Widget build(BuildContext context)
    }
    class Config {
        const int maxDiceCount = 6;
        const int maxDicePerRow = 3;
        const int minDiceCount = 1;
    }
    
    class DicePage{
        State<DicePage> createState() => _DicePageState();
    }
    class _DicePageState{
        List<int> diceFaceValues
        constructor _DicePageState()
        bool _isDiceCountMax()
        bool _isDiceCountMin()
        int _getFaceValue()
        void _addDice()
        void _removeDice()
        void _rollAllDice()
        Widget build(BuildContext context)
    }

    class DiceLayout { 
        List<int> diceFaceValues;
        ValueGetter<bool> isDiceCountMax, isDiceCountMin;
        VoidCallback addDice, removeDice, rollAllDice;

        constructor DiceLayout();
        Widget build(BuildContext context)
    }
    
    class Dice{
        final int faceValue
        constructor const Dice(required this.faceValue, super.key);
        Widget build(BuildContext context)
    }
    
    class LayoutBuilder{ 
        List<Widget> _buildDiceLayout(BoxConstraints constraints)
        Widget _buildSumLayout()
        Widget _buildButtonsLayout() 
        }
```

### Demo

### Portrait orientation

![](assets/readme/portrait.gif)

### Landscape orientation orientation
![](assets/readme/landscape.gif)

### Possible improvements
 - Write Tests
 - Setting page to configure colour 
 - better dice image (perhaps one with illusion of 3D)
 - optimise code/logic
 - custom hand-crafted icons
 - attractive dice-roll animation


