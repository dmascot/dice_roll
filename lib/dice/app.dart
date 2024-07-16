import 'package:flutter/material.dart';

import 'page.dart';

/// This is App class which provides
/// - Global background color
/// - App bar , holding title of app
/// - SafeArea for rest of the App
///
/// Params: None
///
/// Dependencies:
/// - page.dart: This is in-nutshell homepage of app , which holds logic and,
/// layout of the app
///
/// Notes:
/// - colours should be set using theme instead of manual pick

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Dice Roll",
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Colors.blueGrey[900],
          titleTextStyle: const TextStyle(
              fontSize: 30, letterSpacing: 3, fontFamily: "Norge"),
        ),
        body: const SafeArea(child: DicePage()),
      ),
    );
  }
}
