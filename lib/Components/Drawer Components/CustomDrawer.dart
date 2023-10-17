import 'package:bcall/Style/colors_style.dart';
import 'package:bcall/Style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                                    onPressed: (){},
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
                                ...["Bambang Kuncoro", "A. Awalludin", "Buyung Ahmad Yani"]
                                    .map((channel) => ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            radius: 20,
                                          ),
                                          horizontalTitleGap: 7,
                                          title: Text(channel, style: subheader,),
                                          onTap: () {},
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
