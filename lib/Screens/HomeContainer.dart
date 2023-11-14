// Stack(
//         children: [
//           Center(
//             child: Column(
//               children: [
//                 TextField(
//                   controller: remoteCallerIdController,
//                   textAlign: TextAlign.center,
//                   decoration: InputDecoration(
//                     hintText: "Remote Caller ID",
//                     alignLabelWithHint: true,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0)
//                     )
//                   ),
//                 ),
//                 const SizedBox(height: 12,),
//                 ElevatedButton(
//                   child: const Text("Invite"),
//                   onPressed: (){
//                     _joinCall(callerId: selfCallerId, calleeId: remoteCallerIdController.text);
//                   },
//                 )
//               ],
//             ),
//           ),
//           incomingSDPOffer != null 
//           ? Positioned(
//               child: Column(
//                   children: [
//                     Text("Incoming Call from ${incomingSDPOffer["callerId"]}"),
//                     IconButton(
//                       icon: const Icon(Icons.call_end),
//                       color: Colors.redAccent,
//                       onPressed: (){
//                         setState(() {
//                           incomingSDPOffer = null;
//                         });
//                       },
//                     ),
//                     IconButton(
//                         icon: const Icon(Icons.call),
//                         color: Colors.greenAccent,
//                         onPressed: () {
//                           _joinCall(
//                             callerId: incomingSDPOffer["callerId"]!,
//                             calleeId: selfCallerId,
//                             offer: incomingSDPOffer["sdpOffer"],
//                           );
//                         },
//                       )
//                   ],
//                 ),
//               )
            
//           : Container()
          
//         ],
//       ),