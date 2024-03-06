import 'dart:convert';
import 'dart:io';
import 'package:beautician/presentation/Inventary/model/Inventory_model.dart/Inventory_model.dart';
import 'package:flutter/material.dart';
import '../../../presentation/Inventary/model/Inventory_model.dart/transferDetails.dart';
import '../../../presentation/Service/model/servicepagemodel.dart';
import 'package:http/http.dart' as http;
import '../../../presentation/Stock/model/stockmodel.dart';
import '../APIs/api_url.dart';

class CallApi {
  static int time = 0;
  static Future<Booking?> getUserDetails() async {
    var apiUrl =
        'https://admin.glamcode.in/api/beautician-booking-deatils/4852';

    try {
      var response = await http.get(Uri.parse(apiUrl));
      print(response);

      if (response.statusCode == 200) {
        var jsonMap = json.decode(response.body.toString());
        print(jsonMap);
        time = jsonMap["sumTime"];
        return Booking.fromJson(jsonMap);
      } else {
        throw Exception(
            'Failed to fetch booking data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getUserDetails Failed to fetch booking data: $e');
    }
  }

  static Future<StartJourneyModel> startJourney() async {
    var data = {"booking_id": 5000.toString(), "user_id": 5413.toString()};

    try {
      var response = await http.post(
          Uri.parse("https://admin.glamcode.in/api/start-journy"),
          body: data);
      print(response.body);
      var data1 = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return StartJourneyModel.fromJson(data1);
      } else {
        return StartJourneyModel.fromJson(data1);
      }
    } catch (e) {
      throw Exception('startJourney Failed to fetch booking data: $e');
    }
  }

  static Future<ReachedDestinationModel> reachedDestination() async {
    //Todo make user model of this
    StartJourneyModel startJourneyModel = StartJourneyModel();
    var data = {
      "booking_report_id": startJourneyModel.bookingReportId.toString()
    };
    try {
      var response = await http.post(
          Uri.parse("https://admin.glamcode.in/api/reached-destination"),
          body: data);
      print(response.body);
      var data1 = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return ReachedDestinationModel.fromJson(data1);
      } else {
        return ReachedDestinationModel.fromJson(data1);
      }
    } catch (e) {
      throw Exception('reachedDestination Failed to fetch booking data: $e');
    }
  }

  static Future<StartServiceModel> startService(File? image) async {
    //Todo make user model of this
    StartJourneyModel startJourneyModel = StartJourneyModel();
    if (image == null) {
      print("Image null hai");
    }

    try {
      var stream = http.ByteStream(image!.openRead());
      var length = await image.length();
      var uri =
          Uri.parse("https://admin.glamcode.in/api/beautician-start-service");
      var request = http.MultipartRequest("POST", uri);
      request.fields['booking_report_id'] = 160.toString();
      // var multiport = http.MultipartFile('selfie', stream, length);
      // request.files.add(multiport);
      request.files
          .add(await http.MultipartFile.fromPath('selfie', image.path));
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var data = jsonDecode(responseString);
      if (response.statusCode == 200) {
        print('Hyginene image uploaded!!');
        print(data.toString());
        return StartServiceModel.fromJson(data);
      } else {
        print('Some Problem occured in image uploading...');
        print(data.toString());
        return StartServiceModel.fromJson(data);
      }
    } catch (e) {
      print('Error uploading image: $e');
      // Handle error accordingly
      throw e;
    }
  }

  static Future<StopServiceModel> stopService() async {
    //Todo make user model of this

    var data = {
      "booking_report_id": 160.toString(),
      // "booking_report_id": startJourneyModel.bookingReportId.toString(),
    };

    try {
      var response = await http.post(
          Uri.parse("https://admin.glamcode.in/api/beautician-stop-service"),
          body: data);
      print(response.body);
      var data1 = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        // setState(() {
        //   stopServiceModel = StopServiceModel.fromJson(data1);
        // });
        return StopServiceModel.fromJson(data1);
      } else {
        return StopServiceModel.fromJson(data1);
      }
    } catch (e) {
      throw Exception('stopService Failed to fetch booking data: $e');
    }
  }

  static callCustomer(BuildContext context) async {
    //Todo make user model of this
    print("API check");
    var data = {
      "from_number": 7355017567.toString(),
      "to_number": 7390990227.toString()
    };
    Map<String, String> header;
    header = {
      "Authorization": "Bearer 289322|fY6HKG25SZnGjqMsy9Y4H896AWCTDJ4GcMI8of4R"
    };
    try {
      var response = await http.post(Uri.parse("${URLapi.callMasking}"),
          body: data, headers: header);
      print(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Conneting..."),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 8),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Call not connected"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print('Error : $e');
      return null;
    }
  }

  static Future<void> RateUser(
      double hygiene, double papering, double pampering, String comment) async {
    //Todo make user model of this
    StartJourneyModel startJourneyModel = StartJourneyModel();
    var data = {
      "user_id": 5413.toString(),
      "booking_id": 1.toString(),
      "hygiene": hygiene.toString(),
      "papering": papering.toString(),
      "pampering": pampering.toString(),
      "beautician": comment.toString(),
      "review": comment.toString()
    };

    try {
      var response = await http.post(Uri.parse(URLapi.Rating), body: data);
      print(response.body);
      var data1 = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        print(data1.toString());
      }
    } catch (e) {
      throw Exception('Rating Failed to fetch booking data: $e');
    }
  }

  static Future<void> LeaveRequest(String startDate, String endDate,
      String reason, BuildContext context) async {
    //Todo make user model of this
    StartJourneyModel startJourneyModel = StartJourneyModel();
    var data = {
      "id": 10385.toString(),
      "startdate": startDate.toString(),
      "enddate": endDate.toString(),
      "reason": reason.toString(),
    };
    try {
      var response =
          await http.post(Uri.parse(URLapi.LeaveRequest), body: data);
      print(response.body);
      var data1 = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        print(data1.toString());
        print("Leave Request created SuccessFully!!");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Leave Request Create Successfully!!"),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Some error occured"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Some error occured"),
        backgroundColor: Colors.red,
      ));
      throw Exception('Rating Failed to fetch booking data: $e');
    }
  }

  static Future<void> SaveTransport(
      String startPoint,
      String endPoint,
      String bookingId,
      BuildContext context,
      File image,
      String cost,
      bool paid) async {
    //Todo make user model of this
    StartJourneyModel startJourneyModel = StartJourneyModel();
    var data = {
      "id": 10385.toString(),
      "start_point": startPoint.toString(),
      "end_point": endPoint.toString(),
      "booking_id": bookingId.toString(),
    };
    try {
      var response =
          await http.post(Uri.parse(URLapi.transportation), body: data);
      print(response.body);
      var data1 = jsonDecode(response.body.toString());

      if (response.statusCode == 201) {
        print(data1.toString());
        print("transportation details saved Successfully!!");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Leave Request Create Successfully!!"),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Some error occured"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Some error occured"),
        backgroundColor: Colors.red,
      ));
      throw Exception('transportation Failed to fetch booking data: $e');
    }
  }

  static Future<InventoryModel?> getTransferList() async {
    try {
      var response = await http.get(Uri.parse("${URLapi.transferList}/10385"));
      print(response);

      if (response.statusCode == 200) {
        var jsonMap = json.decode(response.body.toString());
        print(jsonMap);

        return InventoryModel.fromJson(jsonMap);
      } else {
        throw Exception(
            'Failed to fetch booking data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getUserDetails Failed to fetch booking data: $e');
    }
  }

  static Future<void> acceptProduct(
      String beautician_id, String transaction_id, BuildContext context) async {
    var data = {"beautician_id": beautician_id, "id": transaction_id};
    try {
      var response = await http.post(
        Uri.parse("https://admin.glamcode.in/api/acceptProduct"),
        body: data,
      );
      print(" print(response.body);");
      print(response.body);
      var data1 = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        print(data1.toString());
        print(" Accept Product created SuccessFully!!");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data1.toString()),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Some error occured"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Some error occured"),
        backgroundColor: Colors.red,
      ));
      throw Exception('Rating Failed to fetch booking data: $e');
    }
  }

  static Future<TransferDetailsModel?> getTransferDetails(
      String transferid) async {
    try {
      var response =
          await http.get(Uri.parse("${URLapi.transferDetails}$transferid"));
      print(response);

      if (response.statusCode == 200) {
        var jsonMap = json.decode(response.body.toString());
        print(jsonMap);
        return TransferDetailsModel.fromJson(jsonMap);
      } else {
        throw Exception(
            'Failed to fetch booking data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getTransferDetails Failed to fetch booking data: $e');
    }
  }

  static Future<StockModel?> getStockDetails(String beauticianId) async {
    try {
      var response =
          await http.get(Uri.parse("${URLapi.beauticianStock}$beauticianId"));
      print(response);

      if (response.statusCode == 200) {
        var jsonMap = json.decode(response.body.toString());
        print(jsonMap);
        return StockModel.fromJson(jsonMap);
      } else {
        throw Exception(
            '$beauticianId to fetch getStockDetails data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getStockDetails Failed to fetch booking data: $e');
    }
  }
}
