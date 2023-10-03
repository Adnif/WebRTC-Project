import 'package:bcall/Style/text_style.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 87, 101, 242),
      body: Stack(
        children: [
          Center(
            child: Text(
              'LOGO',
              style: bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 715.0, left: 143),
            child: Column(
              children: [
                Text(
                  'FROM',
                  style: medium,
                ),
                Text(
                  'BP JAMSOSTEK',
                  style: medium,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
