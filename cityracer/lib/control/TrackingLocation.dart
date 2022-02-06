import 'package:location/location.dart';
import 'package:cityracer/model/TrackingData.dart';
import 'package:cityracer/model/TrackingConfigurationData.dart';

class TrackingLocation {
  var _location = Location();

  Location getLocation()
  {
      _location.requestPermission().then((permissionStatus) {
        if (permissionStatus == PermissionStatus.granted) {
          _location.changeSettings(
              accuracy: TrackingConfigurationData.locationAccuracy,
              interval: TrackingConfigurationData.interval,
              distanceFilter: TrackingConfigurationData.distanceFilter
          );
        }
      });
      return _location;
  }

  void reset(){
    _location.enableBackgroundMode(enable: false);
  }


  TrackingLocationData locationToTracking(LocationData locationData) {
    return TrackingLocationData(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
      accuracy: locationData.accuracy!,
      altitude: locationData.altitude!,
      speed: locationData.speed!,
      speedAccuracy: locationData.speedAccuracy!,
      heading: locationData.heading!,
      dateTimeString:
      DateTime.fromMillisecondsSinceEpoch(locationData.time!.toInt())
          .toIso8601String(),
    );
  }

}
