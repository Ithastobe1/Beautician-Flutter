import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:beautician/presentation/Dashboard/ui/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../core/color.dart';
import '../../../core/screen_size.dart';
import '../../../data/repositories/API_Calling/api_calling.dart';
import '../../../data/repositories/APIs/api_url.dart';

import '../../Chat/ui/chatroom.dart';
import '../../Chat/ui/model/chatroomModel.dart';
import '../../Chat/ui/model/usermodel.dart';
import '../../Service/ui/servicepage.dart';
import '../bloc/dashboard_bloc.dart';
import '../model/dashboardmodel.dart';
import 'package:http/http.dart' as http;
import 'bottomnavigationbarscreen.dart';
import 'mydrawer.dart';

class DashboardView extends StatefulWidget {
  final int userID;

  const DashboardView({
    super.key,
    required this.userID,
  });

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  DashboardBloc dashboardBloc = DashboardBloc();
  LocationService locationService = LocationService();
  bool toggle = true;
  double myLongitude = 0;
  double myLatitude = 0;
  @override
  void initState() {
    super.initState();
    // CheckInternet.internet(context);

    getDashboard();
    getCurrentPosition();
  }

  final beuticianId = "123";
  final userid = "456";
  final bookingid = "111";

  Future<ChatRoomModel?> getChatroomModel() async {
    ChatRoomModel? chatroom;

    // QuerySnapshot snapshot = await FirebaseFirestore.instance
    //     .collection(bookingid)
    //     .where("participants.${beuticianId}", isEqualTo: true)
    //     .where("participants.${userid}", isEqualTo: true)
    //     .get();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("119") //booking id
        .where("participants.${"456"}", isEqualTo: true)
        .where("participants.${"123"}", isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      //Fetch the existing one
      log("Chatroom already creatred!");

      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatroom = existingChatroom;
    } else {
      //create a new one
      ChatRoomModel newChatroom =
          ChatRoomModel(chatroomid: bookingid, lastmessage: "", participants: {
        beuticianId: true,
        userid: true,
      });
      await FirebaseFirestore.instance
          .collection("chatroom")
          .doc(newChatroom.chatroomid)
          .set(newChatroom.toMap());
      log("newchatroom created");
      chatroom = newChatroom;
    }
    return chatroom;
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Are you sure?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text('Do you want to exit an App',
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(displayHeight(context) * 0.01),
                  child: const Text('No'),
                )),
          ),
          SizedBox(
            width: displayWidth(context) * 0.02,
          ),
          GestureDetector(
            onTap: () => exit(0),
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(displayHeight(context) * 0.01),
                  child: const Text('Yes'),
                )),
          ),
        ],
      ),
    ).then((value) => value as bool);
  }

  DashboardModel? dashboardModel;
  getDashboard() async {
    final response =
        await http.get(Uri.parse("${URLapi.dashboard}${widget.userID}"));
    log("response.toString()");
    print(response.body.toString());

    if (response.statusCode == 200) {
      setState(() {
        dashboardModel = DashboardModel.fromJson(jsonDecode(response.body));
      });
      log("log of responce");
      log(dashboardModel.toString());
    } else {
      throw Exception('Failed to load product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Dashboard'.tr,
              style: const TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            backgroundColor: AppColors.themecolors,
            actions: [
              IconButton(
                onPressed: () {
                  if (toggle == true) {
                    setState(() {
                      toggle = false;
                      Get.updateLocale(Locale('hn', 'IN'));
                    });
                  } else if (toggle == false) {
                    setState(() {
                      toggle = true;
                      Get.updateLocale(Locale('en', 'US'));
                    });
                  }
                },
                icon: Icon(Icons.language),
              ),
              // IconButton(
              //     onPressed: () async {
              //       ChatRoomModel? chatRoomModel = await getChatroomModel();
              //       log(chatRoomModel.toString());
              //       if (chatRoomModel != null) {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => const ChatRoom()));
              //       }
              //     },
              //     icon: const Icon(Icons.chat))
            ],
          ),
          drawer: DrawerWidget(
            userid: widget.userID,
          ),
          body: dashboardModel == null
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 12,
                      shadowColor: Colors.blue,
                      child: Container(
                        height: displayHeight(context) * 0.3,
                        width: displayWidth(context),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                  color: AppColors.themecolors,
                                  elevation: 3,
                                  shadowColor: AppColors.themecolors,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Location".tr,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                              " :  ${dashboardModel!.location}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ],
                                      ))),
                              // Row(
                              //   children: [
                              //     Expanded(flex: 1, child: Container()),
                              //     const Expanded(flex: 2, child: Text("Amount ")),
                              //     const Expanded(flex: 3, child: Text("No")),
                              //   ],
                              // ),
                              const Divider(thickness: 2),
                              Row(
                                children: [
                                  Text(
                                    "Total booking Done".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    " :  ${dashboardModel!.totalbooking.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ],
                              ),

                              const Divider(thickness: 2),
                              Row(
                                children: [
                                  Text(
                                    "Sale Done".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    ":  ${dashboardModel!.saledone.toString()}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 2),

                              Row(
                                children: [
                                  Text(
                                    "Incentive Target".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    ":  ${dashboardModel!.incentiveTarget.toString()}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 2),
                              Row(
                                children: [
                                  Text(
                                    "Incentive  Amount ".tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    ": ${dashboardModel!.incentiveAmount.toString()}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 2),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      "Today\'s Booking".tr,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                    SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        color: AppColors.themecolors,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 0,
                              ),
                              Text(
                                "Sr.".tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text("Date".tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Status".tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              // Container(
                              //   width: 3,
                              // )
                              SizedBox(
                                width: 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   width: displayWidth(context),
                    //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //   child: DropdownButtonFormField(
                    //     // autofocus: true,
                    //     // validator: (value) => value == null
                    //     //     ? 'Select Specialization required !!'
                    //     //     : null,
                    //     decoration: const InputDecoration(
                    //         filled: true,
                    //         fillColor: Color.fromARGB(255, 142, 173, 188),
                    //         labelText: 'Today booking',
                    //         border: InputBorder.none),
                    //     items: dashboardModel!.todaybooking!.map((value) {
                    //       return DropdownMenuItem(
                    //         value: value,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(value.bookingDate.toString()),
                    //                 Text(value.bookingStatus.toString()),
                    //                 Icon(Icons.call),
                    //                 Icon(Icons.directions),
                    //                 Icon(Icons.arrow_forward_ios_rounded)
                    //               ],
                    //             ),
                    //             Text(value.bookingTime.toString()),
                    //           ],
                    //         ),
                    //       );
                    //     }).toList(),
                    //     onChanged: (val) {
                    //       setState(() {
                    //         // getSpecial = val;
                    //         // doctorSpl = getSpecial.specializationName;
                    //         // doctorSplID = getSpecial.specializationTid;
                    //       });
                    //     },
                    //   ),
                    // ),

                    SizedBox(
                      height: displayHeight(context) * 0.4,
                      child: ListView.builder(
                        itemCount: dashboardModel?.todaybooking?.length,
                        // itemCount: 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          dashboardModel!
                                              .todaybooking![index].sr
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              dashboardModel!
                                                  .todaybooking![index]
                                                  .bookingDate
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              dashboardModel!
                                                  .todaybooking![index]
                                                  .bookingTime
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          dashboardModel!.todaybooking![index]
                                              .paymentStatus
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 40,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                duration: Duration(seconds: 6),
                                                content: Text(
                                                    "Please wait Connecting..."),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                            CallApi.callCustomer(context);
                                          },
                                          icon: const Icon(Icons.call),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              ChatRoomModel? chatRoomModel =
                                                  await getChatroomModel();
                                              log(chatRoomModel.toString());
                                              if (chatRoomModel != null) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ChatRoom()));
                                              }
                                            },
                                            icon: Icon(Icons.message)),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            getCurrentPosition();
                                            LocationService.openMap(
                                                myLongitude.toString(),
                                                myLatitude.toString());
                                          },
                                          icon: const Icon(Icons.directions),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, "/ServicePage");
                                            },
                                            icon: const Icon(
                                                Icons.arrow_forward_ios))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // const Card(
                    //     child: Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text("Transaction Pending Amount"),
                    //       Icon(Icons.arrow_forward_ios)
                    //     ],
                    //   ),
                    // )),
                  ],
                ),
        ),
      ),
    );
  }

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      myLongitude = currentPosition.longitude;
      myLatitude = currentPosition.latitude;
      print("Longitude: " + currentPosition.longitude.toString());
      print("Latitude: " + currentPosition.latitude.toString());
    }
  }
}
