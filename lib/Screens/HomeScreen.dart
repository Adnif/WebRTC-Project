import 'package:bcall/Components/Drawer%20Components/CustomDrawer.dart';
import 'package:bcall/Components/Drawer%20Components/LeftPageDrawer.dart';
import 'package:bcall/Components/Drawer%20Components/MainPageDrawer.dart';
import 'package:bcall/Components/PlaceholderContainer.dart';
import 'package:bcall/Screens/VideoCallScreen.dart';
import 'package:bcall/Style/colors_style.dart';
import 'package:bcall/Style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_emoji_high_contrast.dart';
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
    return Scaffold(
      backgroundColor: secondary2,
      appBar: AppBar(
        backgroundColor: secondary2,
        title: Text('A Awaluddin', style: title,),
        actions: [
          IconButton(
            icon: const Iconify(Ph.video_camera_fill, color: Colors.white,), // widget,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoCall(),
                  )
              );
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),

    );
    // return Stack(
    //   children: [
    //     OverlappingPanels(
    //       left: Builder(
    //         builder: (context) => const LeftPage(),
    //       ),
    //       main: Builder(
    //         builder: (context) => const MainPage(),
    //       )
    //     )
    //   ],
    // );

    
  }
}