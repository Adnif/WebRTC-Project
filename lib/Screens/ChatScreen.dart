
import 'dart:convert';
import 'dart:developer';
import 'dart:math'as math;

import 'package:bcall/Components/Drawer%20Components/CustomDrawer.dart';
import 'package:bcall/Components/Drawer%20Components/LeftPageDrawer.dart';
import 'package:bcall/Components/Drawer%20Components/MainPageDrawer.dart';
import 'package:bcall/Components/PlaceholderContainer.dart';
import 'package:bcall/Providers/UserProvider.dart';
import 'package:bcall/Screens/VideoCallScreen.dart';
import 'package:bcall/Style/colors_style.dart';
import 'package:bcall/Style/text_style.dart';
import 'package:bcall/services/SignallingService.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_emoji_high_contrast.dart';
import 'package:overlapping_panels/overlapping_panels.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String callId;
  const ChatScreen({super.key, required this.name, required this.callId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String websocketUrl = "http://10.0.2.2:5001/";
  //final String websocketUrl = "http://localhost:5001/";
  //final String websocketUrl = "http://192.168.17.160:5001/";
  //final String selfCallerId = math.Random().nextInt(999999).toString().padLeft(6, '0');
  
  dynamic incomingSDPOffer;
  TextEditingController chatController = TextEditingController();

  
  String id = 'DNS';
  String selfCallerId = '000000';


  List<Map<String, dynamic>> chatStream = [];

  final socket = SignallingService.instance.socket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socket!.on('chat', (data) {
      if(mounted && data['sender'] == widget.callId){
        setState(() {
          chatStream.add(data);
        });
      }
      
    });
    
    //log("My caller ID: ${selfCallerId}");
  }

 void sendMessage(message) {
    if (message.isNotEmpty) {
      // Emit the 'chat' event to the server
      socket!.emit('chat', {
        'calleeId': widget.callId,
        'msg': message,
      });

      // Update the local UI with the sent message
      setState(() {
        chatStream.add({'sender' : 'You', 'msg': message});
        chatController.clear();
      });
    }
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
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: secondary2,
      //   title: Text('${widget.name} ${widget.callId}', style: title,),
      //   actions: [
      //     IconButton(
      //       icon: const Iconify(Ph.video_camera_fill, color: Colors.white,), // widget,
      //       onPressed: () {
      //         _joinCall(
      //           callerId: selfCallerId,
      //           calleeId: '232322323',
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: chatStream.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> chatData = chatStream[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: chatData['sender'] == 'You' ? Colors.blueGrey : Colors.amber,
                        radius: 20,
                      ),
                      subtitle: Text(chatData['msg'], style: subheaderBody,),
                      title: chatData['sender'] == 'You' ? Text('You', style: subheaderBody,) : Text('${widget.name}', style: subheaderBody,),
                    );
                  }
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: chatController,
                          decoration: InputDecoration.collapsed(
                            hintText: "Send a message",
                            hintStyle: subheaderBody,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send,color: bodyc,),
                    onPressed: (){
                      sendMessage(chatController.text);
                    },
                  ),
                ],
              ),
              SizedBox(height: 5,)
            ],
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
                            calleeId: selfCallerId,
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
    );
  }
}