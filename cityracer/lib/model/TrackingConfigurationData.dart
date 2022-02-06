import 'package:location/location.dart';

class TrackingConfigurationData{
  static int interval = 0;
  //todo has to be something reasonable for biking like 5.0=5m
  static double distanceFilter = 0.0;
  static LocationAccuracy locationAccuracy = LocationAccuracy.navigation;

  void configure(){

  }
}
