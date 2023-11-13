import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:bcall/Screens/ChatScreen.dart';
import 'package:bcall/Providers/UserProvider.dart';
import 'package:bcall/Style/colors_style.dart';
import 'package:bcall/Style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_emoji_high_contrast.dart';
import 'package:iconify_flutter/icons/radix_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  List<dynamic> friendList;
  CustomDrawer({super.key, required, required this.friendList});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>{
  final TextEditingController phoneNumController = TextEditingController();

  Future<void> addFriend(String phoneNum) async {
    log('Masuk ke log addFriend(), notelp: $phoneNum');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await UserProvider().addFriend(token, phoneNum);

    Map<String, dynamic> responseBody = json.decode(response.body);
    
    if(response.statusCode == 200){
      Fluttertoast.showToast(
        msg: "Teman berhasil ditambah",
        toastLength: Toast.LENGTH_SHORT
      );
      setState(() {
        
      });
    } else if(response.statusCode == 404){
      Fluttertoast.showToast(
        msg: responseBody["message"]
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    //log(friendList.toString());
    return Container(
      color: secondary,
      width: 350, // Set the desired width here
      child: Row(
          children: [
            SizedBox(
              width: 70,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                  ),
                ],
              )
                  //  children: servers
                  //     .map((server) => Padding(
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 8, vertical: 4),
                  //           child: CircleAvatar(
                  //             backgroundColor: Colors.white,
                  //             radius: 30,
                  //             foregroundImage: NetworkImage(server),
                  //           ),
                  //         ))
                  //     .toList()),
            ),
            Expanded(
              child: SafeArea(
                child: Container(
                    decoration: BoxDecoration(
                        color: secondary2,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // decoration: BoxDecoration(
                          //     border: Border(
                          //         bottom:
                          //             BorderSide(color: Colors.grey[100]!))),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SizedBox(
                                  width: 220,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: secondary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0)
                                        ),
                                        context: context,
                                        builder: (BuildContext context){
                                          return Padding(
                                            padding: MediaQuery.of(context).viewInsets,
                                            child: Container(                                        
                                              height: 300,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 10,),
                                                    Center(
                                                      child: Text(
                                                        'Invite a Friend',
                                                        style: headline,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    Center(
                                                      child: Text(
                                                        'You can add friends with their phone number',
                                                        style: bodyGray,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    TextFormField(
                                                      controller: phoneNumController,
                                                      decoration: const InputDecoration(
                                                        labelText: 'Phone Number',
                                                        prefixIcon: Icon(Icons.call),
                                                        border: const OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                                        ),
                                                        focusedBorder: const OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.black, width: 1)
                                                        ),
                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                                        filled: true,
                                                        fillColor: Colors.white
                                                      ),
                                                    ),
                                                    SizedBox(height: 20,),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 50,
                                                      child: ElevatedButton(
                                                        onPressed: (){
                                                          log('ini notelp ${phoneNumController.text}');
                                                          addFriend(phoneNumController.text);                                
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:  primary,
                                                          disabledBackgroundColor: bodyc,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10.0)
                                                          ),
                                                          
                                                          //padding: EdgeInsets.only(left: 1, right: 1)
                                                        ),
                                                        child: Text(
                                                          'Send Friend Request'
                                                        )
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      );
                                    },
                                    child: Text('Add Friend', style: subheader,),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: secondary2,
                            child: ListView(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 16,
                                      left: 16,
                                      right: 16
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Private Messages',
                                      style: subheader,
                                    ),
                                  ),
                                ),
                                //...["Bambang Kuncoro", "A. Awalludin", "Buyung Ahmad Yani"]
                                ...widget.friendList
                                    .map((channel) => ListTile(
                                          leading: const CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            radius: 20,
                                          ),
                                          horizontalTitleGap: 7,
                                          title: Text(channel['username'], style: subheader,),
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ChatScreen(friendList: widget.friendList, name: channel['username'], callId: channel['_id'].substring(channel['_id'].length - 6),),
                                              )
                                            );
                                          },
                                        )),                                
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              width: 30,
            )
          ],
        ),
    );
  }
}
