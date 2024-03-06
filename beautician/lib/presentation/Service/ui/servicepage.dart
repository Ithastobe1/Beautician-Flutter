import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:beautician/presentation/Service/model/UsedProductModel.dart';
import 'package:beautician/presentation/Service/ui/productalloted.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

import 'package:shimmer/shimmer.dart';

import '../../../core/color.dart';
import '../../../data/repositories/API_Calling/api_calling.dart';
import '../../Dashboard/ui/geolocator.dart';
import '../model/servicepagemodel.dart';
import '../provider/servicepageprovider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  int _timerMinutes = CallApi.time; // initial minutes
  int _timerSeconds = 0; // initial seconds
  late Timer _timer;

  void _startTimer() {
    const oneSecond = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      if (_timerMinutes == 0 && _timerSeconds == 0) {
        timer.cancel();
        // You can perform any action when the timer reaches 0
      } else {
        setState(() {
          if (_timerSeconds == 0) {
            _timerMinutes--;
            _timerSeconds = 59;
          } else {
            _timerSeconds--;
          }
        });
      }
    });
  }

  Booking? booking1;
  int timetimer = 0;
  bool showSpinner = false;
  File? image;
  PlatformFile? pickedFile;
  Future selectFile() async {
    try {
      final image1 = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
      if (image1 == null) {
        print("Unable to Capture the Image...");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.themecolors,
            content: Text("Could not capture Image please try again...")));
        return;
      }
      // final imageTemporary = XFile(image1.path);
      setState(() {
        image = File(image1.path);
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  double myLongitude = 0; //pass user latitude and longitude
  double myLatitude = 0;

  StartJourneyModel startJourneyModel = StartJourneyModel();
  ReachedDestinationModel reachedDestinationModel = ReachedDestinationModel();
  StartServiceModel startServiceModel = StartServiceModel();
  StopServiceModel stopServiceModel = StopServiceModel();

  final _dialog = RatingDialog(
      title: const Text("Rate The Customer"),
      message: const Text("Tap a start to rate a customer"),
      submitButtonText: 'Submit',
      enableComment: true,
      onSubmitted: (response) {
        CallApi.RateUser(response.rating, response.rating, response.rating,
            response.comment.toString());
        print('rating: ${response.rating}, comment: ${response.comment}');
      });
  late Booking? bookingDetails;
  @override
  void initState() {
    bookingDetails = Booking();
    //TODO: implement initState
    // CheckInternet.internet(context);
    super.initState();
  }

  void imagePickerOption() {
    Get.bottomSheet(SingleChildScrollView(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          color: Colors.white,
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Pick Image From",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                CupertinoButton(
                    color: AppColors.themecolors,
                    onPressed: () {
                      selectFile();
                    },
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 80,
                        ),
                        Icon(Icons.camera),
                        Text("CAMERA"),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                CupertinoButton(
                    color: AppColors.themecolors,
                    onPressed: () {
                      Get.back();
                    },
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 80,
                        ),
                        Icon(Icons.close),
                        Text("CANCEL"),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  bool rememberMe = false;

  List<Service> list = [];

  Future<void> sendProductData() async {
    final String apiUrl = 'https://admin.glamcode.in/api/useProductOnsite';
    Map<String, dynamic> Data = {
      "productUse": {"beauticianId": 10386, "Bookingid": 4832, "services": list}
    };
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(Data),
    );

    if (response.statusCode == 200) {
      print('POST request successful');
      print(response.body);
    } else {
      print('Failed to make POST request');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }
  }

  _onRememberMeChanged(newValue, int serviceId, List<Product>? product) =>
      setState(() {
        log(newValue.toString());
        rememberMe = newValue;

        // TODO: Here goes your functionality that remembers the user.
        Service service = Service(serviceId: serviceId, products: product);

        if (rememberMe == true) {
          addProduct(service);
        } else if (rememberMe == false) {
          log("removed called");
          removeProduct(service);
        }
      });

  void addProduct(Service service) {
    setState(() {
      list.add(service);
    });
    log("list added");
    log(list.toString());
  }

  void removeProduct(Service service) {
    setState(() {
      list.clear();
      rememberMe = false;
    });
    log("list removed");
    log(list.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Service Page",
                style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              backgroundColor: AppColors.themecolors),
          body: SafeArea(
            child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  SizedBox(
                    child: FutureBuilder(
                      future: CallApi.getUserDetails(),
                      builder: (context, AsyncSnapshot<Booking?> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          Booking booking = snapshot.data!;

                          return Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            booking.date.toString() +
                                                ", " +
                                                booking.time.toString(),
                                            // "Today, 7:30 AM",
                                            style: const TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            snapshot.data!.name.toString(),
                                            // "Shreyas",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            snapshot.data!.name.toString() +
                                                ", " +
                                                snapshot.data!.address!.address
                                                    .toString(),
                                            // "Shreyas, 3.45 , Vineet Khand, Gomti Nagar",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            snapshot.data!.address!.street
                                                    .toString() +
                                                ", " +
                                                snapshot.data!.address!.pincode
                                                    .toString(),
                                            // "Lucknow, Uttar Pradesh, 22610, india",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: booking.bookingsItems?.length,
                                itemBuilder: (context, index) {
                                  BookingsItems bookingItem =
                                      booking.bookingsItems![index];
                                  List<Product> products = [];

                                  if (bookingItem.productUse != null) {
                                    for (ProductUse productUse
                                        in bookingItem.productUse!) {
                                      products.add(Product(
                                        productId: productUse.productID,
                                        productName: productUse.productName,
                                        quantity: bookingItem.qunitity,
                                        unit: productUse.unit,
                                        qualityPresent: "updated",
                                      ));
                                    }
                                  }

                                  return Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${bookingItem.service.toString()}  ${bookingItem.qunitity.toString()} ",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          if (bookingItem.productUse != null)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: products.map((product) {
                                                return Row(
                                                  children: [
                                                    Checkbox(
                                                      value: rememberMe,
                                                      onChanged: (bool? value) {
                                                        // Handle checkbox change here
                                                        _onRememberMeChanged(
                                                            value,
                                                            int.parse(bookingItem
                                                                .serviceID
                                                                .toString()),
                                                            products);
                                                      },
                                                    ),
                                                    Text(
                                                      "${product.productName}  ${product.quantity}",
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: SizedBox(
                                      height: 40,
                                      width: 400,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Total Amount = ${booking.totalAmount.toString()}"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: SizedBox(
                                      height: 40,
                                      width: 400,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Time Slot starts at = ${booking.time.toString()}"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.black12,
                                child: dummyListviewCell()),
                          );
                        }
                      },
                    ),
                  ),
                  SingleChildScrollView(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 180,
                                    child: TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black)),
                                        child: (startJourneyModel.status !=
                                                'success')
                                            ? const Text(
                                                'Start Journey',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )
                                            : (const Text(
                                                "Journey Started",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        onPressed: () {
                                          if (startJourneyModel.status !=
                                              'success') {
                                            Provider.of<TimeProvider>(context,
                                                    listen: false)
                                                .StartJourney_Provider();
                                          } else {
                                            if (reachedDestinationModel
                                                    .status ==
                                                'success') {
                                              SnackBar snackBar = const SnackBar(
                                                  content: Text(
                                                      "You have reached your destination!"));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              SnackBar snackBar = SnackBar(
                                                content: const Text(
                                                    "Hello your journey has already started"),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          }
                                        }),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Consumer<TimeProvider>(
                                      builder: (context, value, child) {
                                    return Text(value
                                        .startJourneyModel.startTime
                                        .toString());
                                  })
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 180,
                                    child: CupertinoButton(
                                        color: Colors.black,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Reached  Destination',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          if (startJourneyModel.status !=
                                              'success') {
                                            SnackBar snackBar = const SnackBar(
                                                content: Text(
                                                    "Please start the journey!!"));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          } else {
                                            if (reachedDestinationModel
                                                    .status !=
                                                'success') {
                                              // CallApi.reachedDestination();
                                              Provider.of<TimeProvider>(context,
                                                      listen: false)
                                                  .ReachedDestination_Provider();
                                            } else {
                                              SnackBar snackBar = const SnackBar(
                                                  content: Text(
                                                      "You have reached your destination!"));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          }
                                        }),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Consumer<TimeProvider>(
                                      builder: (context, value, child) {
                                    return Text(value
                                        .reachedDestinationModel.reachedTime
                                        .toString());
                                  })
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50,
                                  width: 400,
                                  child: CupertinoButton(
                                      color: Colors.black,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Capture Hygiene',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        imagePickerOption();
                                      }
                                      //  selectFile
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // if (pickedFile != null)
                              //   Expanded(child: Text(pickedFile!.name)),

                              /*
                          Expanded(
                            child: Container(
                              color: Colors.blue[100],
                              child: Image.file(
                                File(pickedFile!.path!),
                                width: double.infinity,
                                fit: Boxfit.cover,
                              ),
                            ),
                          ),
                          
                          
                          
                           */
                              Container(
                                  child: image == null
                                      ? Center(
                                          child: Text("No image Captured"),
                                        )
                                      : Container(
                                          child: Center(
                                              child: Image.file(
                                            File(image!.path).absolute,
                                            height: 100,
                                            width: 100,
                                          )),
                                        )),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 180,
                                    child: CupertinoButton(
                                        color: Colors.black,
                                        child: const Text(
                                          'Start service',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                        onPressed: () {
                                          Provider.of<TimeProvider>(context,
                                                  listen: false)
                                              .startService_Provider(image);

                                          _startTimer();
                                        }),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Consumer<TimeProvider>(
                                      builder: (context, value, child) {
                                    return Text(value
                                            .startServiceModel.startServiceTime
                                            .toString() ??
                                        "");
                                  })
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Timer: $_timerMinutes:${_timerSeconds.toString().padLeft(2, '0')}',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(height: 20),
                                    // ElevatedButton(
                                    //   onPressed: () {
                                    //     // Restart the timer with a new duration
                                    //     _timer.cancel();
                                    //     _timerMinutes = 0;
                                    //     _timerSeconds = 0;
                                    //     _startTimer();
                                    //   },
                                    //   child: Text('Restart Timer'),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 180,
                                    child: CupertinoButton(
                                        color: Colors.black,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Add Service',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {}),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text("No Services added"),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 180,
                                    child: CupertinoButton(
                                        color: Colors.black,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Stop service',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          _timer.cancel();
                                          Provider.of<TimeProvider>(context,
                                                  listen: false)
                                              .stopService_Provider();
                                          sendProductData();

                                          showDialog(
                                              context: context,
                                              builder: (context) => _dialog);
                                        }),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Consumer<TimeProvider>(
                                      builder: (context, value, child) {
                                    return Text(value
                                        .stopServiceModel.stopServiceTime
                                        .toString());
                                  })
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CupertinoButton(
                                  color: Colors.black,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'chech for data upload ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    sendProductData();
                                  }),
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Column(children: [
                      Row(
                        children: [
                          CupertinoButton(
                              child: const Icon(
                                Icons.call,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Please Wait Connecting..."),
                                  duration: Duration(seconds: 8),
                                  backgroundColor: Colors.green,
                                ));
                                CallApi.callCustomer(context);
                              }),
                          CupertinoButton(
                              child: const Icon(
                                Icons.directions,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                LocationService.openMap(myLongitude.toString(),
                                    myLatitude.toString());
                              }),
                          const SizedBox(
                            width: 200,
                          ),
                          Expanded(
                              child: CupertinoButton(
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    sendProductData();
                                  })),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: CupertinoButton(
                                  child: const Icon(
                                    Icons.question_answer,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/ChatPage");
                                  })),
                          const SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   width: 400,
                      //   height: 50,
                      //   child: CupertinoButton(
                      //     child: Text("Marked Arrived"),
                      //     onPressed: () {},
                      //     color: Colors.black,
                      //   ),
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
                  )
                ]),
          )),
    );
  }
}

Widget dummyListviewCell() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Container(
        width: 48.0,
        height: 48.0,
        color: Colors.white,
      ),
      const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 8,
            color: Colors.white,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Container(
            width: double.infinity,
            height: 8.0,
            color: Colors.white,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Container(
            width: double.infinity,
            height: 8.0,
            color: Colors.white,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Container(
            width: 40.0,
            height: 8.0,
            color: Colors.black,
          ),
        ],
      ))
    ]),
  );
}
