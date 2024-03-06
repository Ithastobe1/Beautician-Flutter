import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/color.dart';
import '../../../data/repositories/APIs/api_url.dart';
import '../../Dashboard/model/dashboardmodel.dart';
import 'package:http/http.dart' as http;

class AddTransportationDetails extends StatefulWidget {
  final int? userID;
  final int? bookingID;
  const AddTransportationDetails({super.key, this.userID, this.bookingID});

  @override
  State<AddTransportationDetails> createState() =>
      _AddTransportationDetailsState();
}

class _AddTransportationDetailsState extends State<AddTransportationDetails> {
  TextEditingController startPointEditingController = TextEditingController();
  TextEditingController endPointEditingController = TextEditingController();
  TextEditingController startPointCostController = TextEditingController();
  TextEditingController endPointCostController = TextEditingController();

  DashboardModel? dashboardModel;
  getDashboard() async {
    // final response = await http.get(Uri.parse("${URLapi.dashboard}${widget.userID}"));
    final response = await http.get(Uri.parse("${URLapi.dashboard}${10385}"));
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

  updateTransportationDetails() async {
    // final response = await http.get(Uri.parse("${URLapi.dashboard}${widget.userID}"));

    final Map<String, dynamic> data = {
      "booking_id": widget.bookingID,
      "start_point": startPointEditingController.text,
      "end_point": endPointCostController.text,
      "start_point_image": image2,
      "end_point_image": image3,
      "beautician_id": widget.userID,
      "end_point_cost": endPointCostController,
      "start_point_cost": startPointCostController,
      "status": true
    };
    final response =
        await http.post(Uri.parse("${URLapi.transportation}"), body: data);

    log("response.toString()");
    print(response.body.toString());
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.body.toString())));
      log("log of responce");
      log(dashboardModel.toString());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.body.toString())));
      throw Exception('Failed to load product');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  File? image;
  File? image2;
  File? image3;
  PlatformFile? pickedFile;
  Future selectFile1() async {
    try {
      final image1 = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (image1 == null) {
        print("Unable to Capture the Image...");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.themecolors,
            content: Text("Could not capture Image please try again...")));
        return;
      }
      // final imageTemporary = XFile(image1.path);
      setState(() {
        image2 = File(image1.path);
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future selectFile2() async {
    try {
      final image1 = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (image1 == null) {
        print("Unable to Capture the Image...");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.themecolors,
            content: Text("Could not capture Image please try again...")));
        return;
      }
      // final imageTemporary = XFile(image1.path);
      setState(() {
        image3 = File(image1.path);
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Fill journey Details"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Starting Point Address"),
              controller: startPointEditingController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Cost Starting Point to Ending point"),
              controller: startPointCostController,
            ),
            SizedBox(
              height: 20,
            ),
            CupertinoButton(
              onPressed: () {
                selectFile1();
              },
              color: Colors.black,
              child: Text("Receipt 1"),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                child: image2 == null
                    ? Center(
                        child: Text("No image Captured"),
                      )
                    : Container(
                        child: Center(
                            child: Image.file(
                          File(image2!.path).absolute,
                          height: 100,
                          width: 100,
                        )),
                      )),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(labelText: "End Point Address"),
              controller: endPointEditingController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Cost Ending Point to Starting Point"),
              controller: endPointCostController,
            ),
            SizedBox(
              height: 20,
            ),
            CupertinoButton(
              onPressed: () {
                selectFile2();
              },
              color: Colors.black,
              child: Text("Receipt 2 "),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: image3 == null
                    ? Center(
                        child: Text("No image Captured"),
                      )
                    : Container(
                        child: Center(
                            child: Image.file(
                          File(image3!.path).absolute,
                          height: 100,
                          width: 100,
                        )),
                      )),
            SizedBox(
              height: 30,
            ),
            CupertinoButton(
              onPressed: () {
                updateTransportationDetails();
                Navigator.pop(context);
              },
              color: Colors.black,
              child: const Text("Upload Details"),
            )
          ],
        ),
      )),
    );
  }
}
