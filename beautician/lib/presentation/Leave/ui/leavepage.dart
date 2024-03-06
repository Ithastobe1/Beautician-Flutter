import 'package:beautician/data/repositories/API_Calling/api_calling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../core/color.dart';

class LeaveView extends StatefulWidget {
  const LeaveView({super.key});

  @override
  State<LeaveView> createState() => _LeaveViewState();
}

class _LeaveViewState extends State<LeaveView> {
  TextEditingController DateOne = TextEditingController();
  TextEditingController DateTwo = TextEditingController();
  TextEditingController ReasonTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Leave".tr,
            style: const TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          backgroundColor: AppColors.themecolors,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: ListView(children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CupertinoButton(
                        child: Row(
                          children: [
                            Text("Select From Date"),
                            Icon(Icons.calendar_month)
                          ],
                        ),
                        onPressed: () async {
                          DateTime? datePicked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2024));
                          var formattedDate =
                              "${datePicked!.day}-${datePicked.month}-${datePicked.year}";
                          setState(() {
                            DateOne.text = formattedDate.toString();
                          });

                          print("$datePicked");
                        }),
                    Text("${DateOne.text.toString()}")
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CupertinoButton(
                        child: Row(
                          children: [
                            Text("Select Till Date"),
                            Icon(Icons.calendar_month)
                          ],
                        ),
                        onPressed: () async {
                          DateTime? datePicked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2024));
                          var formattedDate =
                              "${datePicked!.day}-${datePicked.month}-${datePicked.year}";
                          setState(() {
                            DateTwo.text = formattedDate.toString();
                          });

                          print("$datePicked");
                        }),
                    Text("${DateTwo.text.toString()}")
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: ReasonTextController,
                  decoration: InputDecoration(
                      labelText: "Reason For Leave",
                      hintText: "Reason For Leave"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please specify the reason!!';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CupertinoButton(
                  child: Text("Created Leave Request"),
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //         content: Text('Please Specify the reason!!')),
                    //   );
                    // }

                    CallApi.LeaveRequest(DateOne.text, DateTwo.text,
                        ReasonTextController.text.trim(), context);

                    setState(() {
                      ReasonTextController.text = "";
                      DateOne.clear();
                      DateTwo.clear();
                    });
                  },
                  color: AppColors.themecolors,
                )
              ]),
            ),
          ),
        ));
  }
}
