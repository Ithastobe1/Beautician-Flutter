import 'package:beautician/presentation/Dashboard/ui/dashboard.dart';
import 'package:beautician/presentation/Home/widget/bottom_nav_bar.dart';
import 'package:beautician/presentation/Leave/ui/leavepage.dart';
import 'package:beautician/presentation/Training/ui/trainingview.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int pageindex;
  final int userId;
  const HomePage({super.key, required this.pageindex, required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  late List<BottomNavigationBarItem> bottomNavbarList;

  int _pageIndex = 0;

  late final List<Widget> _screens = [
    // DashboardView(userID: widget.userId),
    DashboardView(userID: 10385),
    TrainingView(),
    LeaveView(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageIndex = widget.pageindex;

    _pageController = PageController(initialPage: widget.pageindex);

    bottomNavbarList = [
      bottomNavigationBarItem(context, Icons.home, "home"),
      bottomNavigationBarItem(context, Icons.track_changes, "training"),
      bottomNavigationBarItem(context, Icons.access_alarm, "leave")
    ];
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavbarList,
        onTap: _setPage,
        currentIndex: _pageIndex,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _screens,
      ),
    );
  }
}
