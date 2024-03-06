// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import '../../../core/color.dart';
// import '../model/chatmodel.dart';


// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   TextEditingController messageController = TextEditingController();
//   String locationMessage = 'Current Location of the User';
//   late String lat;
//   late String long;
 
//   Future<void> sendChatMessage(int senderId, int recpId, String message) async {
//     var apiUrl = 'https://admin.glamcode.in/api/chat';
//     try {
//       var response = await http.post(
//         Uri.parse(apiUrl),
//         body: {
//           'sender_id': senderId.toString(),
//           'recp_id': recpId.toString(),
//           'message': message,
//         },
//       );
//       if (response.statusCode == 200) {
//         print('Chat message sent successfully');
//       } else {
//         throw Exception(
//             'Failed to send chat message. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to send chat message: $e');
//     }
//   }

//   Future<ChatData> fetchChatData() async {
//     var apiUrl =
//         'https://admin.glamcode.in/api/chat-retrive/4637/5413'; // Replace with your API URL

//     try {
//       var response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         var jsonMap = json.decode(response.body);
//         print(jsonMap);
//         return ChatData.fromJson(jsonMap);
//       } else {
//         throw Exception(
//             'Failed to fetch chat data. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to fetch chat data: $e');
//     }
//   }

//   sendmessage() {
//     sendChatMessage(4637, 5413, messageController.text);
//     messageController.text = "";
//     fetchChatData();
//   }

//   ChatData chatModelRetrive = ChatData();
//   @override
//   void initState() {
//     // Timer.periodic(Duration(seconds: 1), (timer) {
//     //   fetchChatData();
//     // });
//     // TODO: implement initState
//     // chatmodel = ChatModel();
//     // sendchat();
//     // retrievechat();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Chat"),
//         backgroundColor: AppColors.black,
//       ),
//       body: SafeArea(
//           child: Container(
//         child: Column(children: [
//           //This is where the chats will go
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: StreamBuilder(
//                   stream: Stream.periodic(Duration(seconds: 1))
//                       .asyncMap((i) => fetchChatData()),
//                   // future: fetchChatData(),
//                   builder: (context, snapshot) {
//                     // if (snapshot.connectionState == ConnectionState.active) {
//                     if (snapshot.hasData) {
//                       return ListView.builder(
//                           reverse: false,
//                           itemCount: snapshot.data?.chat?.length,
//                           itemBuilder: (context, index) {
//                             // MessageModel currentMessage = MessageModel.fromMap(
//                             //     datasnapshot.docs[index].data()
//                             // as Map<String, dynamic>);
//                             return Row(
//                               mainAxisAlignment:
//                                   (snapshot.data?.chat?[index].recpId == 5413)
//                                       ? MainAxisAlignment.end
//                                       : MainAxisAlignment.start,
//                               children: [
//                                 Container(
//                                     margin: EdgeInsets.symmetric(vertical: 2),
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: 10, horizontal: 10),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       // color: (currentMessage.sender ==
//                                       //         widget.userModel.uid)
//                                       //     ? Colors.grey
//                                       //     : Theme.of(context)
//                                       //         .colorScheme
//                                       //         .secondary,
//                                     ),
//                                     child: Text(
//                                       snapshot.data!.chat![index].message
//                                           .toString(),
//                                       style: TextStyle(color: Colors.black),
//                                     )),
//                               ],
//                             );
//                           });
//                     } else if (snapshot.hasError) {
//                       return Center(
//                         child: Text(
//                             "An error occurd! Please check your internet connection"),
//                       );
//                     } else {
//                       return Center(
//                         child: Text("send message to your customer"),
//                       );
//                     }
//                   }
//                   // else {
//                   //   return Center(
//                   //     child: CircularProgressIndicator(),
//                   //   );
//                   // }

//                   ),
//             ),
//           ),

//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(30)),
//               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//               child: Row(children: [
//                 Flexible(
//                   child: TextField(
//                     controller: messageController,
//                     maxLines: null,
//                     decoration: InputDecoration(
//                         border: InputBorder.none, hintText: "  Enter message"),
//                   ),
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       sendmessage();
//                     },
//                     icon: Icon(
//                       Icons.send,
//                       // color: Theme.of(context).colorScheme.secondary,
//                       color: AppColors.black,
//                     )),
//               ]),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           )
//         ]),
//       )),
//     );
//   }
// }
//       //                 Container(
//       //                   child: IconButton(
//       //                       onPressed: () {}, icon: Icon(Icons.send)),
//       //                 ),
//       //               ],
//       //             ),
//       //             Container(
//       //               child: IconButton(
//       //                   onPressed: () {
//       //                     _getCurrentLocation().then((value) {
//       //                       lat = '${value.latitude}';
//       //                       long = '${value.longitude}';
//       //                       setState(() {
//       //                         locationMessage =
//       //                             'Latitude: $lat , Longitude: $long';
//       //                         print(locationMessage.toString());
//       //                       });
//       //                     });
//       //                   },
//       //                   icon: Icon(Icons.share_location)),
//       //             )
//       //           ],
//       //         ),
//       //       ),
//       //     )
//       //   ],
//       // )),
    


