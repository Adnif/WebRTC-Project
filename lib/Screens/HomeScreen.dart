
import 'dart:developer';

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
  final String selfCallerId;

  const HomeScreen({super.key, required this.selfCallerId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic incomingSDPOffer;
  int _currentIndex = 0;
  TextEditingController remoteCallerIdController = TextEditingController();

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
    log("My caller ID: ${widget.selfCallerId}");
    SignallingService.instance.socket!.on("newCall", (data) {
      log(incomingSDPOffer.toString());
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
        title: Text('A Awaluddin ${widget.selfCallerId}', style: title,),
        actions: [
          IconButton(
            icon: const Iconify(Ph.video_camera_fill, color: Colors.white,), // widget,
            onPressed: () {
              _joinCall(
                callerId: widget.selfCallerId,
                calleeId: '232322323',
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                TextField(
                  controller: remoteCallerIdController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Remote Caller ID",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    )
                  ),
                ),
                const SizedBox(height: 12,),
                ElevatedButton(
                  child: const Text("Invite"),
                  onPressed: (){
                    _joinCall(callerId: widget.selfCallerId, calleeId: remoteCallerIdController.text);
                  },
                )
              ],
            ),
          ),
          incomingSDPOffer != null 
          ? Positioned(
              child: Column(
                  children: [
                    Text("Incoming Call from ${incomingSDPOffer["callerId"]}"),
                    IconButton(
                      icon: const Icon(Icons.call_end),
                      color: Colors.redAccent,
                      onPressed: (){
                        setState(() {
                          incomingSDPOffer = null;
                        });
                      },
                    ),
                    IconButton(
                        icon: const Icon(Icons.call),
                        color: Colors.greenAccent,
                        onPressed: () {
                          _joinCall(
                            callerId: incomingSDPOffer["callerId"]!,
                            calleeId: widget.selfCallerId,
                            offer: incomingSDPOffer["sdpOffer"],
                          );
                        },
                      )
                  ],
                ),
              )
            
          : Container()
          
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