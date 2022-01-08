import 'dart:async';
import 'package:location/location.dart';
import 'package:cityracer/model/TrackingData.dart';

class LocationService {
  TrackingData? _currentLocation;

  var location = Location();
  StreamController<TrackingData> _locationController =
  StreamController<TrackingData>();

  Stream<TrackingData> get locationStream => _locationController.stream;

  LocationService() {
    // Request permission to use location
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        //todo: check for null don't assume it
        location.onLocationChanged.listen((locationData) {
          _locationController.add(TrackingData(
            latitude: locationData.latitude!,
            longitude: locationData.longitude!,
            accuracy: locationData.accuracy!,
            altitude: locationData.altitude!,
            speed: locationData.speed!,
            speedAccuracy: locationData.speedAccuracy!,
            heading: locationData.heading!,
            dateTimeString: DateTime.fromMillisecondsSinceEpoch(locationData.time!.toInt()).toIso8601String(),
          ));
        });
      }
    });
  }
}