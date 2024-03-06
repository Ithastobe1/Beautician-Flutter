import 'dart:convert';
import 'package:beautician/presentation/Home/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/color.dart';
import '../../../core/screen_size.dart';
import '../../../data/SharedPrefrences/shared_prefrences.dart';
import '../../../data/repositories/APIs/api_url.dart';
import '../../../data/repositories/HttpHelper/httphelper.dart';
import '../../Dashboard/ui/dashboard.dart';
import '../model/loginpagemodel.dart';

//https://admin.glamcode.in/api/beautician-bookings/7446
class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginModel? loginModel1;
  User? user;
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

  void saveText(String value) async {
    //value pass krao jo a rhi hai
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("text", value);
  }

  void readText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedValue = prefs.getString("text");
    if (savedValue != null) {
      emailController.text = savedValue;
    }
  }

  late final SharedPreferences prefss;
  void intitialize() async {
    prefss = await SharedPreferences.getInstance();
  }

  String? SavedId;
  String? SavedName;
  String? SavedEmail;
  String? SavedMobile;
  String? SavedimageUrl;

  void toprint() async {
    print(loginModel1?.user?.email.toString());
    print(loginModel1?.user?.mobile.toString());
    print(loginModel1?.user?.id.toString());
    print(loginModel1?.user?.name.toString());
    print(loginModel1?.user?.userImageUrl.toString());
    String? email1 = loginModel1!.user!.email.toString();
    String? mobile1 = loginModel1!.user!.mobile.toString();
    String? id1 = loginModel1!.user!.id.toString();
    String? name1 = loginModel1!.user!.name.toString();
    String? userimage1 = loginModel1!.user!.userImageUrl.toString();
    await prefss.setString('email', email1);
    await prefss.setString('mobile', mobile1);
    await prefss.setString('id', id1);
    await prefss.setString('name', name1);
    await prefss.setString('image', userimage1);
    SharedHelper.userId = prefss.getString('id').toString();
    SharedHelper.email = prefss.getString('email').toString();
    SharedHelper.userNumber = prefss.getString('mobile').toString();
    SharedHelper.userImage = prefss.getString('image').toString();
    SharedHelper.userName = prefss.getString('name').toString();
  }

  @override
  void initState() {
    intitialize();
    // CheckInternet.internet(context);
    readText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        height: displayHeight(context),
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topLeft,
        //         end: Alignment.bottomRight,
        //         colors: [
        //       Color.fromARGB(255, 77, 167, 241),
        //       Color.fromARGB(255, 229, 170, 87),
        //       Color.fromARGB(255, 69, 177, 74)
        //     ])),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: displayHeight(context) * 0.02),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "GC",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Beautician",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  )
                  // const CircleAvatar(
                  //   // radius: 120,
                  //   radius: 120,
                  //   backgroundImage: AssetImage('assets/images/logos.png'),
                  //   // child: Image.asset(
                  //   //   "assets/images/logos.png",
                  //   //   // width: 200,
                  //   //   height: displayHeight(context) * 0.35,
                  //   // ),
                  // ),
                  ),
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 40,
                  ),
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Login to your Account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ],
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                        width: displayWidth(context) * 0.8,
                        child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                // Container(
                                //     alignment: Alignment.center,
                                //     padding: EdgeInsets.all(
                                //         displayHeight(context) * 0.01),
                                //     child: Text(
                                //       "Login",
                                //       textScaleFactor: 1.0,
                                //       style: TextStyle(
                                //           // color: Colors.pink,
                                //           color: Colors.indigo[900],
                                //           fontSize: displayHeight(context) * 0.03,
                                //           fontWeight: FontWeight.w500),
                                //     )),
                                Container(
                                  padding: EdgeInsets.all(
                                      displayHeight(context) * 0.01),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: emailController,
                                    onChanged: (val) {
                                      print(val);
                                      saveText(val);
                                    },
                                    textInputAction: TextInputAction.next,
                                    // maxLength: 10,
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter User Email',
                                    ),
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return 'UserId is required!!';
                                    //   } else if (value.length != 5) {
                                    //     return 'null';
                                    //   }

                                    //   return null;
                                    // },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(
                                      displayHeight(context) * 0.01),
                                  child: TextFormField(
                                    obscureText: _isObscure,
                                    enableSuggestions: false,
                                    textInputAction: TextInputAction.next,
                                    autocorrect: false,
                                    autofocus: true,
                                    controller: passwordController,
                                    // onChanged: (val) {
                                    //   saveText(val);
                                    // },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Password is required!!';
                                      } else if (value.length <= 4) {
                                        return 'Password must be 6 digits';
                                      }

                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        labelText: 'Enter Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: AppColors.wordcolors,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          },
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // print('good');
                                        //forgot password screen
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           DashbordMain()),
                                        // );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            displayHeight(context) * 0.01),
                                        child: Text(
                                          'Forget Password?',
                                          style: TextStyle(
                                              color: AppColors.themecolors,
                                              fontWeight: FontWeight.normal,
                                              fontSize: displayHeight(context) *
                                                  0.018),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const SignupScreen()));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            displayHeight(context) * 0.01),
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              color: AppColors.themecolors,
                                              fontWeight: FontWeight.normal,
                                              fontSize: displayHeight(context) *
                                                  0.018),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                    width: displayWidth(context) * 0.9,
                                    height: displayHeight(context) * 0.07,
                                    padding: EdgeInsets.all(
                                        displayHeight(context) * 0.0),
                                    child: Card(
                                      color: AppColors.themecolors,
                                      child: TextButton(
                                        // textColor: Colors.white,
                                        // color: Colors.indigo[900],
                                        child: Text('Sign In',
                                            style: TextStyle(
                                                color: AppColors.wordcolors,
                                                fontSize:
                                                    displayHeight(context) *
                                                        0.022)),
                                        onPressed: () {
                                          login(context);
                                        },
                                      ),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )))
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  moveToDashboard(int userid) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(pageindex: 0, userId: userid)));
  }

  login(BuildContext context) async {
    print("Login Model called");
    // printloginModel!.user!.id);
    if (!formkey.currentState!.validate()) {
      return;
    }
    var url = URLapi.logInUrl;
    var data = {
      "email":
          // "techinspire321@gmail.com",
          emailController.text.trim(),
      "password":
          // "secret"
          passwordController.text.trim()
    };

    var response = await HttpHelpers.postRequest(url, data);

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      print(jsondata);
      print(user?.name.toString());
      if (jsondata["status"] == "success") {
        var loginModel = LoginModel.fromJson(jsondata);
        setState(() {
          loginModel1 = loginModel;
          prefss.setString("ACCESSTOKEN", loginModel.accessToken.toString());
          prefss.setString("USERID", loginModel.user!.id.toString());
          var key = loginModel.accessToken;
        });

        toprint();
        moveToDashboard(loginModel.user!.id!);
        //userID: loginModel.user!.id!
      } else {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text("Check your Email and Password"),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    }
  }
}
