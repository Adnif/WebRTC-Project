import 'dart:math';

import 'package:bcall/Components/Drawer%20Components/CustomDrawer.dart';
import 'package:bcall/Components/Drawer%20Components/LeftPageDrawer.dart';
import 'package:bcall/Components/Drawer%20Components/MainPageDrawer.dart';
import 'package:bcall/Components/PlaceholderContainer.dart';
import 'package:bcall/Screens/VideoCallScreen.dart';
import 'package:bcall/Style/colors_style.dart';
import 'package:bcall/Style/text_style.dart';
import 'package:bcall/services/SignallingService.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_emoji_high_contrast.dart';
import 'package:overlapping_panels/overlapping_panels.dart';

class HomeScreen extends StatefulWidget {
  final String selfCallerID;

  const HomeScreen({super.key, required this.selfCallerID});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic incomingSDPOffer;
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
  void initState() {
    // TODO: implement initState
    super.initState();

    SignallingService.instance.socket!.on("newCall", (data) {
      if (mounted) {
        // set SDP Offer of incoming call
        setState(() => incomingSDPOffer = data);
      }
    });
  }

  _joinCall({
    required String callerId,
    required String calleeId,
    dynamic offer,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CallScreen(
          callerId: callerId,
          calleeId: calleeId,
          offer: offer,
        ),
      ),
    );
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
              _joinCall(
                callerId: widget.selfCallerID,
                calleeId: '232322323',
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