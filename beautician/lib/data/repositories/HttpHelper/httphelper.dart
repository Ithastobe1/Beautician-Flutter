import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../SharedPrefrences/shared_prefrences.dart';

class HttpHelpers {
  static bool sessionTimeout = false;
  static getRefreshToken(String refresh) async {
    http.Response response;
    var access = "";
    var data = json.encode({"refresh": refresh});
    var urlUri = Uri.parse(""); //Refresh Token API
    var header = {"Content-Type": "application/json"};
    response = await http.post(urlUri, headers: header, body: data);

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      access = jsondata['access'];
    }
    return access;
  }

  static getRequestWithoutToken(String url) async {
    http.Response? response;

    try {
      var urlUri = Uri.parse(url);
      // var header;
      // if (SharedHelper.accessToken != "") {
      //   header = {
      //     "Content-Type": "application/json",
      //     // "Authorization": "Bearer " + SharedHelper.accessToken
      //   };
      // } else {
      //   header = {"Content-Type": "application/json"};
      // }
      response = await http.get(urlUri, headers: {});
    } catch (ex) {
      Get.snackbar(
        'Error',
        '$ex',
        icon: const Icon(Icons.miscellaneous_services_rounded,
            size: 50, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent[700],
        borderRadius: 20,
        margin: const EdgeInsets.all(20),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }

    return response;
  }

  static getRequest(String url) async {
    http.Response? response;

    try {
      var urlUri = Uri.parse(url);
      Map<String, String> header;
      if (SharedHelper.accessToken != "") {
        header = {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${SharedHelper.accessToken}"
        };
      } else {
        header = {"Content-Type": "application/json"};
      }
      response = await http.get(urlUri, headers: header);

      if (response.statusCode == 401 && SharedHelper.accessToken != "") {
        if (SharedHelper.refreshToken != "") {
          String token = await getRefreshToken(SharedHelper.refreshToken);

          SharedHelper.accessToken = token;
          if (SharedHelper.accessToken != "") {
            header = {
              "Content-Type": "multipart/form-data",
              "Authorization": "Bearer ${SharedHelper.accessToken}"
            };
          } else {
            header = {"Content-Type": "application/json"};
          }
          response = await http.get(urlUri, headers: {
            "Authorization": "Bearer $token",
          });
        }
      }
    } catch (ex) {
      Get.snackbar(
        'Error',
        '$ex',
        icon: const Icon(Icons.miscellaneous_services_rounded,
            size: 50, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent[700],
        borderRadius: 20,
        margin: const EdgeInsets.all(20),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }

    return response;
  }

  static postRequest(String url, var param) async {
    http.Response? response;

    try {
      var urlUri = Uri.parse(url);
      var data = json.encode(param);
      Map<String, String> header;
      if (SharedHelper.accessToken != "") {
        header = {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${SharedHelper.accessToken}"
        };
      } else {
        header = {"Content-Type": "application/json"};
      }
      response = await http.post(urlUri, body: data, headers: header);

      if (response.statusCode == 401 && SharedHelper.accessToken != "") {
        if (SharedHelper.refreshToken != "") {
          String token = await getRefreshToken(SharedHelper.refreshToken);

          SharedHelper.accessToken = token;
          if (SharedHelper.accessToken != "") {
            header = {
              "Content-Type": "multipart/form-data",
              "Authorization": "Bearer ${SharedHelper.accessToken}"
            };
          } else {
            header = {"Content-Type": "application/json"};
          }
          response = await http.post(urlUri, body: data, headers: {
            "Authorization": "Bearer ${SharedHelper.accessToken}",
          });
        }
      }
    } catch (ex) {
      Get.snackbar(
        'Error',
        '$ex',
        icon: const Icon(Icons.miscellaneous_services_rounded,
            size: 50, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent[700],
        borderRadius: 20,
        margin: const EdgeInsets.all(20),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }

    return response;
  }
}
