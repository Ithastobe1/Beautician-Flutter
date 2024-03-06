import 'dart:convert';
import 'dart:developer';

import 'package:beautician/presentation/Transportation/ui/addTransportationDetails.dart';
import 'package:flutter/material.dart';

import '../../../data/repositories/APIs/api_url.dart';
import '../../Dashboard/model/dashboardmodel.dart';
import 'package:http/http.dart' as http;

class Transportation extends StatefulWidget {
  final int? userID;
  const Transportation({super.key, this.userID});

  @override
  State<Transportation> createState() => _TransportationState();
}

class _TransportationState extends State<Transportation> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Transportation"),
      ),
      body: SafeArea(
          child: (dashboardModel == null)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: dashboardModel!.todaybooking!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTransportationDetails(
                                      userID: dashboardModel!
                                          .todaybooking![index]
                                          .assignedBookingID,
                                    )));
                      },
                      title: Text(dashboardModel!
                          .todaybooking![index].assignedBookingID
                          .toString()),
                    );
                  })),
    );
  }
}
