import 'dart:async';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:location/location.dart';
import 'package:cityracer/model/TrackingData.dart';
import 'package:cityracer/model/TrackingConfigurationData.dart';
import 'package:cityracer/model/DatabaseConfigurationData.dart';


//todo background mode
//todo registerForActivityResults(ActivityResultContracts.RequestPermissions())
class TrackingControl {
  var _location = Location();

  StreamController<TrackingLocationData> _locationController = StreamController<TrackingLocationData>();
  
  Stream<TrackingLocationData> get locationStream => _locationController.stream;
  StreamSubscription<LocationData>? _locationSubscription;

  TrackingControl() {

  }

  Future<Box> initializeDatabase() async {
    //replace with app dir after prototyping - ext. storage not supported on ios
    final directory = await getExternalStorageDirectory();
    print(directory!.path);
    //todo: throw exception if path == null?
    Hive.init(directory.path);
    if(!Hive.isAdapterRegistered(sessionId)){
      Hive.registerAdapter(SessionAdapter());
    }//no need to do anything
    if(!Hive.isAdapterRegistered(trackingDataLocationId)) {
      Hive.registerAdapter(TrackingLocationDataAdapter());
    }//no need to do anything
    return await Hive.openBox(DatabaseConfigurationData().sessionBoxName);
  }

  //provider better suited instead of callback?
  void startTracking(Function viewCallback) async{
    initializeDatabase().then((box){
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

            TrackingLocationData trackingData = TrackingLocationData(
              latitude: locationData.latitude!,
              longitude: locationData.longitude!,
              accuracy: locationData.accuracy!,
              altitude: locationData.altitude!,
              speed: locationData.speed!,
              speedAccuracy: locationData.speedAccuracy!,
              heading: locationData.heading!,
              dateTimeString: DateTime.fromMillisecondsSinceEpoch(locationData.time!.toInt()).toIso8601String(),
            ) ;

            box.add(trackingData);
            viewCallback(trackingData);

            print(box.length);

          });
        }
      });
    });
  }

  void stopTracking() {
    var box = Hive.box(DatabaseConfigurationData().sessionBoxName);
    if (box.isOpen){ box.close();}
    _location.enableBackgroundMode(enable: false);
    _locationSubscription?.cancel();
  }
}