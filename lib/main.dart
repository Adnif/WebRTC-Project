import 'package:bcall/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // theme: ThemeData.dark().copyWith(
        //     scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47)),
        home: SplashScreen());
  }
}
