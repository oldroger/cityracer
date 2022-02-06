import 'dart:async';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:location/location.dart';
import 'package:cityracer/model/TrackingData.dart';
import 'package:cityracer/model/DatabaseConfigurationData.dart';
import 'package:cityracer/control/TrackingLocation.dart';

//todo background mode
//todo registerForActivityResults(ActivityResultContracts.RequestPermissions())
class ControlMain {
  StreamController<TrackingLocationData> _locationController = StreamController<TrackingLocationData>();

  Stream<TrackingLocationData> get locationStream => _locationController.stream;
  StreamSubscription<LocationData>? _locationSubscription;
  TrackingLocation _trackingLocation = TrackingLocation();

  ControlMain() {}

  //provider better suited instead of callback?
  void startTracking(Function viewCallback) async {
    initializeDatabase().then((box) {
      _locationSubscription = _trackingLocation.getLocation().onLocationChanged.listen((locationData) {
        TrackingLocationData trackingData = _trackingLocation.locationToTracking(locationData);
        box.add(trackingData);
        viewCallback(trackingData);


      });
    });
  }

  //todo: cleanup database
  void stopTracking() async{
    var box = Hive.box(DatabaseConfigurationData().sessionBoxName);
    printDB();
    if (box.isOpen) {
      await box.clear();
      await box.close();

    }
    _trackingLocation.reset();
    _locationSubscription?.cancel();
  }

  void printDB(){
    var box = Hive.box(DatabaseConfigurationData().sessionBoxName);
    print(box.length);
    for(int i = 0; i < box.length; ++i){
      TrackingLocationData currentData = box.getAt(i);
      print(currentData.accuracy);
      print(currentData.altitude);
      print(currentData.latitude);
      print(currentData.longitude);
      print(currentData.dateTimeString);

    }
  }

  //todo should be part of database class
  Future<Box> initializeDatabase() async {
    //replace with app dir after prototyping - ext. storage not supported on ios
    final directory = await getExternalStorageDirectory();
    print(directory!.path);
    //todo: throw exception if path == null?
    Hive.init(directory.path);
    if (!Hive.isAdapterRegistered(sessionId)) {
      Hive.registerAdapter(SessionAdapter());
    } //no need to do anything
    if (!Hive.isAdapterRegistered(trackingDataLocationId)) {
      Hive.registerAdapter(TrackingLocationDataAdapter());
    } //no need to do anything
    return await Hive.openBox(DatabaseConfigurationData().sessionBoxName);
  }
}
