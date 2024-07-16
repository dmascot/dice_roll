/// These are constants that defines constrain for app
/// - maxDiceCount: This is maximum number of dice app can display
/// - maxDicePerRow: This is maximum number of dice one row can hold
/// - minDiceCount: This is minimum number of dices an app can have
///
/// These constant imposes some indirect constrains, listed below
/// - We can only have maxDiceCount/maxDicePerRow number of rows
/// - We must initialize app with minimum of minDiceCount
///
/// Params: None
///
/// Dependencies: None
///
/// Notes:
/// -ideally, this should be configured using config file
const int maxDiceCount = 6;
const int maxDicePerRow = 3;
const int minDiceCount = 1;
