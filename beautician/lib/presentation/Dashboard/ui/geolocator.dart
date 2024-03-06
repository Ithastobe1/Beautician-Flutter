import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocationService {
  double myLongitude = 0;
  double myLatitude = 0;
  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      myLongitude = currentPosition.longitude;
      myLatitude = currentPosition.latitude;
      print("Longitude: " + currentPosition.longitude.toString());
      print("Latitude: " + currentPosition.latitude.toString());

      // var DistanceInMeter = Geolocator.distanceBetween(
      //     myLongitude, myLatitude, endLatitude, endLongitude);
    }
  }

  static Future<void> openMap(String long, String lat) async {
    // final googleURL = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    final Uri url =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
