import 'package:beautician/data/SharedPrefrences/shared_prefrences.dart';
import 'package:beautician/data/repositories/InternetConnection/ui/internetconnection.dart';
import 'package:beautician/presentation/Dashboard/bloc/dashboard_bloc.dart';
import 'package:beautician/presentation/Dashboard/ui/dashboard.dart';
import 'package:beautician/presentation/Leave/ui/leavepage.dart';
import 'package:beautician/presentation/Service/bloc/service_bloc.dart';
import 'package:beautician/presentation/Service/ui/servicepage.dart';
import 'package:beautician/presentation/Training/ui/trainingview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/Chat/ui/chatroom.dart';
import '../presentation/Chat2/ui/chatpage.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/Login":
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => DashboardBloc(),
                  child: DashboardView(
                    userID: int.parse(SharedHelper.userID),
                  ),
                ));
      case "/Dashboard":
        return CupertinoPageRoute(
            builder: ((context) =>
                DashboardView(userID: int.parse(SharedHelper.userId))));
      // return CupertinoPageRoute(
      //     builder: (context) => BlocProvider(
      //           create: (context) => DashboardBloc(),
      //           child: DashboardView(
      //             userID: int.parse(SharedHelper.userId),
      //           ),
      //         ));
      case "/Leave":
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => DashboardBloc(),
                  child: const LeaveView(),
                ));
      case "/Training":
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => DashboardBloc(),
                  child: const TrainingView(),
                ));
      case "/ServicePage":
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ServiceBloc(),
                  child: const ServicePage(),
                ));
      // return CupertinoPageRoute(builder: (context) => ServicePage());
      case "/ChatPage":
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => DashboardBloc(),
                  child: const ChatRoom(),
                ));
      
    }
  }
}
