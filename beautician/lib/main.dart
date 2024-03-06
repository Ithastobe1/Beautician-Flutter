import 'package:beautician/presentation/Dashboard/ui/dashboard.dart';
import 'package:beautician/presentation/Service/provider/servicepageprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'core/routes.dart';
import 'data/repositories/LanguageChange/languagechange.dart';
import 'firebase_options.dart';
import 'presentation/Home/homepage.dart';
import 'presentation/Login/ui/loginpage.dart';

Uuid uuid = const Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  SharedPreferences prefss = await SharedPreferences.getInstance();
  String? ACCESSTOKEN = prefss.getString("ACCESSTOKEN");
  String? USERID = prefss.getString("USERID");
  if (ACCESSTOKEN != null) {
    if (USERID != null) {
      runApp(MyAppLoggedIn(
        userid: USERID.toString(),
      )
      );
    } else {
      runApp(const MyApp());
    }
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<TimeProvider>(
          create: (context) => TimeProvider(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        // initialRoute: "/Login",
        locale: Locale('en', 'US'),
        translations: Languages(),
        fallbackLocale: Locale('en', 'US'),
        home: const LoginView(),
        // home: HomePage(pageindex: 0),
        // home:   DashboardView(userID: 10385),
      ),
    );
  }
}

class MyAppLoggedIn extends StatelessWidget {
  final String userid;
  const MyAppLoggedIn({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<TimeProvider>(
          create: (context) => TimeProvider(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        // initialRoute: "/Login",
        locale: Locale('en', 'US'),
        translations: Languages(),
        fallbackLocale: Locale('en', 'US'),
        // home: const LoginView(),
        home: HomePage(
          pageindex: 0,
          userId: int.parse(userid),
        ),
        // home: DashboardView(userID: int.parse(userid)),
      ),
    );
  }
}
