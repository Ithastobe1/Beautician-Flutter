import 'dart:io';

import 'package:beautician/data/repositories/API_Calling/api_calling.dart';
import 'package:beautician/presentation/Service/model/servicepagemodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TimeProvider extends ChangeNotifier {
  bool isLoading = false;
  StartJourneyModel startJourneyModel = StartJourneyModel();
  ReachedDestinationModel reachedDestinationModel = ReachedDestinationModel();
  StartServiceModel startServiceModel = StartServiceModel();
  StopServiceModel stopServiceModel = StopServiceModel();
  Future<void> StartJourney_Provider() async {
    isLoading = true;
    notifyListeners();
    startJourneyModel = await CallApi.startJourney();
    isLoading = false;
    notifyListeners();
  }

  Future<void> ReachedDestination_Provider() async {
    isLoading = true;
    notifyListeners();
    reachedDestinationModel = await CallApi.reachedDestination();
    isLoading = false;
    notifyListeners();
  }

  Future<void> startService_Provider(File? image) async {
    isLoading = true;
    notifyListeners();
    startServiceModel = await CallApi.startService(image);
    isLoading = false;
    notifyListeners();
  }

  Future<void> stopService_Provider() async {
    isLoading = true;
    notifyListeners();
    stopServiceModel = await CallApi.stopService();
    isLoading = false;
    notifyListeners();
  }
}
