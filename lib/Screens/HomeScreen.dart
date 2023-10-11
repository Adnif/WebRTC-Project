import 'package:bcall/Components/Drawer%20Components/LeftPageDrawer.dart';
import 'package:bcall/Components/Drawer%20Components/MainPageDrawer.dart';
import 'package:bcall/Components/PlaceholderContainer.dart';
import 'package:flutter/material.dart';
import 'package:overlapping_panels/overlapping_panels.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    PlaceholderWidget('Friends'),
    PlaceholderWidget('Video')
  ];

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OverlappingPanels(
          left: Builder(
            builder: (context) => const LeftPage(),
          ),
          main: Builder(
            builder: (context) => const MainPage(),
          )
        )
      ],
    );
  }
}