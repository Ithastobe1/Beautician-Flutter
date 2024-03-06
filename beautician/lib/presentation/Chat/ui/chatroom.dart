import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import 'model/messageModel.dart';

class ChatRoom extends StatefulWidget {
  
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController messageController = TextEditingController();

  void sendMessage(String lat, String long) async {
    String msg = messageController.text.trim();
    messageController.clear();

    if (msg != "" || lat != "" && long != "") {
      MessageModel newMessage = MessageModel(
          messageid: uuid.v1(),
          sender: "123",
          createdOn: DateTime.now(),
          text: msg,
          lat: lat,
          long: long,
          seen: false);

      FirebaseFirestore.instance
          .collection("chatroom")
          .doc("111")
          .collection("messages")
          .doc(newMessage.messageid)
          .set(newMessage.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 10,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  NetworkImage("widget.targetUser.profilepic.toString()"),
            ),
            const SizedBox(
              width: 10,
            ),
            Text("Name")
            // Text("widget.targetUser.fullname.toString()"),
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatroom")
                    .doc("111")
                    .collection("messages")
                    .orderBy("createdOn", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot datasnapshot =
                          snapshot.data as QuerySnapshot;
                      log(datasnapshot.toString());
                      return ListView.builder(
                          reverse: true,
                          itemCount: datasnapshot.docs.length,
                          itemBuilder: (context, index) {
                            MessageModel currentMessage = MessageModel.fromMap(
                                datasnapshot.docs[index].data()
                                    as Map<String, dynamic>);
                            return Row(
                              mainAxisAlignment:
                                  (currentMessage.sender == "123")
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (currentMessage.sender == "123")
                                            ? Colors.pink
                                            : Colors.blue,
                                      ),
                                      child:(currentMessage.lat != "" &&
                                              currentMessage.long != "")
                                          ? SizedBox(
                                              height: 90,
                                              width: 150,
                                              child: Card(
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    InkWell(
                                                        onTap: () {},
                                                        child: const Text(
                                                          "view Location",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      123,
                                                                      45,
                                                                      218)),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            )
                                          :  Text(
                                        currentMessage.text.toString(),
                                        textWidthBasis:
                                            TextWidthBasis.longestLine,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        maxLines: null,
                                        overflow: TextOverflow.visible,
                                      )),
                                ),
                              ],
                            );
                          });
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            "An error occured! Please check your internet connection"),
                      );
                    } else {
                      return const Center(
                        child: Text("end-to-end Entrypedted with Pink chat"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(children: [
                 IconButton(
                    onPressed: () {
                      sendMessage("26.8467° N", "80.9462° E");
                    },
                    icon: Icon(
                      Icons.location_searching,
                      color: Colors.pink,
                    )),
                Flexible(
                  child: TextField(
                    controller: messageController,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "  Enter message"),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      sendMessage("","");
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.pink,
                    )),
              ]),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }
}
