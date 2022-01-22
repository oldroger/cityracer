import 'package:location/location.dart';
import 'package:cityracer/model/TrackingConfigurationData.dart';

class PermissionChecker{
  var _location = Location();
  PermissionChecker(){}
  Location getLocation(){
    bool success = false;

    _location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        _location.changeSettings(
            accuracy: TrackingConfigurationData.locationAccuracy,
            interval: TrackingConfigurationData.interval,
            distanceFilter: TrackingConfigurationData.distanceFilter
        );
        return _location;
      }//else success stays false
    });
    return _location;
  }
}
