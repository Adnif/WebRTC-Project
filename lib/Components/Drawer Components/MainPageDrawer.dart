import 'package:flutter/material.dart';
import 'package:overlapping_panels/overlapping_panels.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: const [
                  Text(
                    '@',
                    style: TextStyle(color: Colors.white54),
                  ),
                  Text('notgr')
                ]),
                const Text(
                  'Playing Fornite Creative',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                )
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            OverlappingPanels.of(context)?.reveal(RevealSide.left);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              OverlappingPanels.of(context)?.reveal(RevealSide.right);
            },
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              OverlappingPanels.of(context)?.reveal(RevealSide.right);
            },
          ),
          IconButton(
            icon: const Icon(Icons.group),
            onPressed: () {
              OverlappingPanels.of(context)?.reveal(RevealSide.right);
            },
          )
        ],
      ),
      
        // [...chat, ...chat]
        //     .map((chatEntry) => ListTile(
        //           contentPadding:
        //               const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        //           leading: CircleAvatar(
        //             foregroundImage: NetworkImage(chatEntry['user']['avatar']),
        //           ),
        //           title: Row(
        //             children: [
        //               Text(
        //                 chatEntry['user']['name'],
        //                 style: const TextStyle(fontWeight: FontWeight.bold),
        //               ),
        //               const SizedBox(
        //                 width: 16,
        //               ),
        //               Text(
        //                 chatEntry["time"],
        //                 style:
        //                     const TextStyle(color: Colors.grey, fontSize: 12),
        //               )
        //             ],
        //           ),
        //           subtitle: Text(
        //             chatEntry['message'],
        //             style: const TextStyle(fontSize: 16),
        //           ),
        //           onTap: () {},
        //           onLongPress: () {},
        //         ))
        //     .toList(),
      
    );
  }
}