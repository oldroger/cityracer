import 'dart:async';
import 'package:location/location.dart';
import 'package:cityracer/model/TrackingData.dart';
import 'package:cityracer/model/TrackingConfigurationData.dart';

//todo background mode
class TrackingControl {
  var _location = Location();
  StreamController<TrackingData> _locationController = StreamController<TrackingData>();
  
  Stream<TrackingData> get locationStream => _locationController.stream;
  StreamSubscription<LocationData>? _locationSubscription;

  TrackingControl() {

  }

  /*private val requestPermissionLauncher = registerForActivityResults(ActivityResultContracts.RequestPermissions()){
    isGranted: Boolean ->
    if (isGranted){
      Log.i("Permission", "Granted");
    } else {
      Log.i("Permission", "Denied");
    }
  }

  private fun requestPermission(){
    when{
      ContextCompat.checkSelfPermissions()
    }

  }*/


  //provider better suited instead of callback?
  void startTracking(Function updateView){
    // Request permission to use location
    _location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {

        _location.changeSettings(
            accuracy: TrackingConfigurationData.locationAccuracy,
            interval: TrackingConfigurationData.interval,
            distanceFilter: TrackingConfigurationData.distanceFilter
        );
        //special permission required
        //_location.enableBackgroundMode(enable: true);
        // If granted listen to the onLocationChanged stream and emit over our controller
        //todo: check for null don't assume it
        //todo: stream better?
        _locationSubscription = _location.onLocationChanged.listen((locationData) {

          TrackingData trackingData = TrackingData(
            latitude: locationData.latitude!,
            longitude: locationData.longitude!,
            accuracy: locationData.accuracy!,
            altitude: locationData.altitude!,
            speed: locationData.speed!,
            speedAccuracy: locationData.speedAccuracy!,
            heading: locationData.heading!,
            dateTimeString: DateTime.fromMillisecondsSinceEpoch(locationData.time!.toInt()).toIso8601String(),
          ) ;
          
          updateView(trackingData);
        });
      }
    });
  }

  void stopTracking(){
    _location.enableBackgroundMode(enable: false);
    _locationSubscription?.cancel();
  }
}