import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/SharedPrefrences/shared_prefrences.dart';
import '../../Login/ui/loginpage.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  // String SavedId = (SharedHelper.userId.toString());
  // String SavedName = (SharedHelper.username.toString());
  // String SavedEmail = (SharedHelper.useremail.toString());
  // String SavedMobile = (SharedHelper.usernumber.toString());
  // String SavedimageUrl = (SharedHelper.userImage.toString());
  late final SharedPreferences prefs;
  // String? SavedId;
  // String? SavedName;
  // String? SavedEmail;
  // String? SavedMobile;
  // String? SavedimageUrl;

  void initialize() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs.getString('email'));
    print(prefs.getString('mobile'));
    print(prefs.getString('id'));
    print(prefs.getString('name'));
    print(prefs.getString('image'));

    print(SharedHelper.email);
    print(SharedHelper.userId);
    print(SharedHelper.userNumber);
    print(SharedHelper.userImage);
    print(SharedHelper.userName);
  }

  late final SharedPreferences prefss;
  void removeSharedPreferences() async {
    prefss = await SharedPreferences.getInstance();
    await prefss.remove('email');
    await prefss.remove('mobile');
    await prefss.remove('id');
    await prefss.remove('name');
    await prefss.remove('image');
    await prefss.remove('ACCESSTOKEN');
    await prefss.remove('USERID');
  }

  @override
  void initState() {
    initialize();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " My Profile",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                          image:
                              NetworkImage(SharedHelper.userImage.toString()))),
                ),
                Text(
                  "${SharedHelper.userName}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("${SharedHelper.email}"),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "${SharedHelper.userId}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${SharedHelper.userNumber}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                CupertinoButton(
                  child: Text("Logout"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Do want to Logout?"),
                              actions: [
                                Row(
                                  children: [
                                    CupertinoButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          removeSharedPreferences();
                                          NavigatorState navigatorState =
                                              Navigator.of(this.context);
                                          while (navigatorState.canPop()) {
                                            navigatorState.pop();
                                          }
                                          Navigator.pushReplacement(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const LoginView()));
                                        }),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CupertinoButton(
                                        child: const Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                )
                              ],
                            ));
                  },
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
