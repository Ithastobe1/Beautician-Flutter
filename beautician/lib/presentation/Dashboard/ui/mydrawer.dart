import 'package:beautician/presentation/Home/homepage.dart';
import 'package:beautician/presentation/Inventary/ui/inventory.dart';
import 'package:beautician/presentation/MyProfile/ui/profile.dart';
import 'package:beautician/presentation/Transportation/ui/transportation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/color.dart';
import '../../../core/screen_size.dart';
import '../../../data/SharedPrefrences/shared_prefrences.dart';
import '../../Leave/ui/leavepage.dart';
import '../../Stock/ui/stock.dart';
import '../../Training/ui/trainingview.dart';
import 'dashboard.dart';

class DrawerWidget extends StatefulWidget {
  final int userid;
  const DrawerWidget({Key? key, required this.userid}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
    // CheckInternet.internet(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.black,
      child: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(80, 10),
                      bottomRight: Radius.elliptical(80, 10))),
              height: displayHeight(context) * 0.15),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 5.0, color: Colors.black45),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(90.0)),
                      ),
                      child: const CircleAvatar(
                        maxRadius: 60,
                        backgroundImage: AssetImage('assets/images/logos.png'),
                        // child: Image.asset("assets/images/logos.png"),
                        // borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      height: displayHeight(context) * 0.01,
                    ),
                    Text(
                      SharedHelper.username,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontSize: displayHeight(context) * 0.02),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.01,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: displayWidth(context) * 0.05),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      // Divider(
                      //   color: Colors.blue[200],
                      // ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const BookingView()),
                          // );
                        },
                        child: Row(
                          children: <Widget>[
                            // Expanded(
                            //     flex: 2,
                            //     child: Icon(
                            //       Icons.shopping_bag_outlined,
                            //       color: AppColors.deepRed,
                            //     )),
                            Expanded(
                              flex: 8,
                              child: Text(
                                '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white54,
                                    fontSize: displayHeight(context) * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppColors.wordcolors,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const BookingView()),
                      //     );
                      //   },
                      //   child: Row(
                      //     children: <Widget>[
                      //       const Expanded(
                      //           flex: 2,
                      //           child: Icon(Icons.book_online,
                      //               color: Colors.white)),
                      //       Expanded(
                      //         flex: 8,
                      //         child: Text(
                      //           "Booking",
                      //           // 'रिक्वेस्ट आइटम',
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.white54,
                      //               fontSize: displayHeight(context) * 0.02),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Divider(
                      //   color: Colors.blue[200],
                      // ),
                      // Divider(
                      //   color: Colors.blue[200],
                      // ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                      pageindex: 0, userId: widget.userid)));
                        },
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                                flex: 2,
                                child: Icon(
                                  Icons.home,
                                  color: Colors.white,
                                )),
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Dashboard".tr,
                                // 'रिक्वेस्ट आइटम',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.wordcolors,
                                    fontSize: displayHeight(context) * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: AppColors.wordcolors,
                      ),
                      Divider(
                        color: AppColors.wordcolors,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           const RequestItemScreen()),
                          // );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                      pageindex: 1, userId: widget.userid)));
                        },
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                                flex: 2,
                                child: Icon(
                                  Icons.model_training,
                                  color: Colors.white,
                                )),
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Training".tr,
                                // 'रिक्वेस्ट आइटम',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.wordcolors,
                                    fontSize: displayHeight(context) * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: AppColors.wordcolors,
                      ),

                      Divider(
                        color: AppColors.wordcolors,
                      ),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences prefss =
                              await SharedPreferences.getInstance();
                          String? USERID = prefss.getString("USERID");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StockPage(
                                        beauticianId: USERID.toString(),
                                      )));
                        },
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                                flex: 2,
                                child: Icon(
                                  Icons.stacked_bar_chart,
                                  color: Color(0xFFFFFFFF),
                                )),
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Stock".tr,
                                // 'रिक्वेस्ट आइटम',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.wordcolors,
                                    fontSize: displayHeight(context) * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: AppColors.wordcolors,
                      ),

                      //   color: Colors.blue[200],
                      // ),
                      Divider(
                        color: AppColors.wordcolors,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Inventory()),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                                flex: 2,
                                child:
                                    Icon(Icons.inventory, color: Colors.white)),
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Inventory".tr,
                                // 'रिक्वेस्ट आइटम',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.wordcolors,
                                    fontSize: displayHeight(context) * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: AppColors.wordcolors,
                      ),
                      Divider(
                        color: AppColors.wordcolors,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Transportation()));
                        },
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                                flex: 2,
                                child: Icon(Icons.track_changes_sharp,
                                    color: Colors.white)),
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Transportation".tr,
                                // 'रिक्वेस्ट आइटम',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.wordcolors,
                                    fontSize: displayHeight(context) * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: AppColors.wordcolors,
                      ),
                      Divider(
                        color: AppColors.wordcolors,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                    pageindex: 2, userId: widget.userid)),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                                flex: 2,
                                child: Icon(
                                  Icons.leak_remove,
                                  color: Colors.white,
                                )),
                            Expanded(
                              flex: 8,
                              child: Text(
                                "Leave".tr,
                                // 'रिक्वेस्ट आइटम',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.wordcolors,
                                    fontSize: displayHeight(context) * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppColors.wordcolors,
                      ),
                      Divider(
                        color: AppColors.wordcolors,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyProfilePage()),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                                flex: 2,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )),
                            Expanded(
                              flex: 8,
                              child: Text(
                                "My Profile".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.wordcolors,
                                    fontSize: displayHeight(context) * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppColors.wordcolors,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// class _drawer extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(0, size.height - 40);
// path.quadraticBezierTo(size.width/2, size.height, size.width, size.height - 40)
//     path.lineTo(size.width, 0);
//     path.lineTo(0, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

