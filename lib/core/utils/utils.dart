import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

bool checkNullOrEmpty(List<dynamic> params) {
  for (var param in params) {
    if (param == null || param.toString().isEmpty) {
      return true; // Return true if any parameter is null or empty
    }
  }
  return false; // Return false if all parameters are non-null and non-empty
}

void launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch url');
  }
}

const kCenterLatlng = LatLng(23.148742739195544, 83.18000424131255);
