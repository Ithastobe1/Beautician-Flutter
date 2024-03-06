import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/color.dart';
import '../../Leave/ui/leavepage.dart';
import '../../Service/ui/servicepage.dart';
import '../../Training/ui/trainingview.dart';
import '../bloc/dashboard_bloc.dart';
import '../model/dashboardmodel.dart';
import 'dashboard.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  // int _selectedIndex = 0;
  DashboardModel dashboardModel = DashboardModel();
  DashboardBloc dashboardBloc = DashboardBloc();
  // static const TextStyle optionStyle = TextStyle(
  //   fontSize: 30,
  //   fontWeight: FontWeight.bold,
  // );
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Booking',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: Insentive',
  //     style: optionStyle,
  //   ),
  //   // Text(
  //   //   'Index 3: Settings',
  //   //   style: optionStyle,
  //   // ),
  //   Text(
  //     'Index 3: Training',
  //     style: optionStyle,
  //   ),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });

  //   if (_selectedIndex == 0) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => DashboardView(
  //                 userID: 5413,
  //               )),
  //     );
  //   }
  //   if (_selectedIndex == 1) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => BookingView())
  //         // MaterialPageRoute(builder: (context) =>  Booking(bookingDate: )),
  //         //   //  MaterialPageRoute(builder: (context) => SearchPage()),
  //         );
  //   }
  //   if (_selectedIndex == 2) {
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(builder: (context) => const CategoryScreen()),
  //     // );
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => InsentiveView()));
  //   }
  //   // if (_selectedIndex == 3) {
  //   //   // Navigator.push(
  //   //   //   context,
  //   //   //   MaterialPageRoute(builder: (context) => dashbord_offers()),
  //   //   // );
  //   // }
  //   if (_selectedIndex == 3) {
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(builder: (context) => const ProfileScreen()),
  //     // );
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => TrainingView()));
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // CheckInternet.internet(context);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return BottomNavigationBar(
  //     backgroundColor: Colors.blueGrey,
  //     showSelectedLabels: true,
  //     items: const <BottomNavigationBarItem>[
  //       BottomNavigationBarItem(
  //         icon: Icon(
  //           Icons.home_filled,
  //           color: Color.fromARGB(255, 77, 74, 74),
  //         ),
  //         label: 'Home',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(
  //           Icons.book_online,
  //           color: Color.fromARGB(255, 77, 74, 74),
  //         ),
  //         label: 'Booking',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(
  //           Icons.money,
  //           color: Color.fromARGB(255, 77, 74, 74),
  //         ),
  //         label: 'Insentive',
  //       ),
  //       // BottomNavigationBarItem(
  //       //   icon: Icon(
  //       //     Icons.brightness_low_outlined,
  //       //     color: Colors.redAccent[700],
  //       //   ),
  //       //   label: 'Offers',
  //       // ),
  //       BottomNavigationBarItem(
  //         icon: Icon(
  //           Icons.model_training,
  //           color: Color.fromARGB(255, 77, 74, 74),
  //         ),
  //         label: 'Training',
  //       ),
  //     ],
  //     currentIndex: _selectedIndex,
  //     selectedItemColor: Colors.grey,
  //     onTap: _onItemTapped,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      bloc: dashboardBloc,
      listener: (context, state) {
        if (state is DashboardOpenDashboardPageState) {
          Navigator.pushNamed(context, "/Dashboard");
          // Navigator.push(
          //     context,
          //     CupertinoPageRoute(
          //         builder: (context) => BlocProvider(
          //               create: (context) => DashboardBloc(),
          //               child: DashboardView(userID: 5412),
          //             )));
        } else if (state is DashboardOpenLeavePageState) {
          Navigator.pushNamed(context, "/Leave");
          // Navigator.push(
          //     context,
          //     CupertinoPageRoute(
          //         builder: (context) => BlocProvider(
          //               create: (context) => DashboardBloc(),
          //               child: LeaveView(),
          //             )));
        } else if (state is DashboardOpenTrainingPageState) {
          Navigator.pushNamed(context, "/Training");
          // Navigator.push(
          //     context,
          //     CupertinoPageRoute(
          //         builder: (context) => BlocProvider(
          //               create: (context) => DashboardBloc(),
          //               child: TrainingView(),
          //             )));
          // Navigator.push(
          // context, MaterialPageRoute(builder: (context) => LeaveView()));
        }
      },
      child: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: AppColors.themecolors,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            if (index == 0) {
              dashboardBloc.add(DashboardOpenDashboardPageEvent());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => DashboardView(
              //             userID: 5413,
              //           )),
              // );
            }
            // if (index == 1) {
            //   dashboardBloc.add(DashboardOpenDashboardPageEvent());
            //   Navigator.push(
            //       context,
            //       CupertinoPageRoute(
            //           builder: (context) => const ServicePage()));
            // }
            if (index == 1) {
              dashboardBloc.add(DashboardOpenLeavePageEvent());
              // Navigator.push(context,
              //     CupertinoPageRoute(builder: (context) => const LeaveView()));
            }
            if (index == 2) {
              dashboardBloc.add(DashboardOpenTrainingPageEvent());
            }
          },
          items: [
            Icon(
              Icons.home_filled,
              color: AppColors.wordcolors,
            ),
            Icon(
              Icons.money,
              color: AppColors.wordcolors,
            ),
            Icon(
              Icons.model_training,
              color: AppColors.wordcolors,
            ),
          ]),
    );
  }
}
