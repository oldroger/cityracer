import 'dart:async';

import 'package:location/location.dart';
//import 'package:city_racer/control/AppBloc.dart';
import 'package:cityracer/model/PositionData.dart';

class LocationFetcher {
  Location _location = Location();
  bool _fetchShouldRun = false;
  //RecordingBloc _recordingBloc;
  //StreamSubscription<RecordingStates> _stream;
  //StreamSubscription<LocationData> _locationStream;

  double get distance => _currentDistance;
  double _currentDistance = 0;

//todo: permissions should be user interactive
/*  LocationFetcher() {
    _recordingBloc = BlocList().getBloc<RecordingBloc>();
    _stream = _recordingBloc.listen((state) {
      if (state == RecordingStates.recording) {
        start();
      }
      if (state == RecordingStates.stopped) {
        stop();
      }
    });
  }*/

  void start() {
    assert(_fetchShouldRun == false);
    _fetchShouldRun = true;
    _updateLocationLoop();
  }

  void stop() {
    assert(_fetchShouldRun == true);
    _fetchShouldRun = false;
    //_locationStream.cancel();
    //BlocList().getBloc<PositionBloc>().add(PositionEvent(PositionEventType.reset));
  }

  void _handlePosition(final CrPosition position) async {
    //BlocList().getBloc<PositionBloc>().add(PositionEvent(PositionEventType.updateRawData, position));
    //necessary to get back to state processing - otherwise updateData will not be thrown again
    //in other events event onto state itself is not supported
    //BlocList().getBloc<PositionBloc>().add(PositionEvent(PositionEventType.fetchData));
  }

  Future<void> _updateLocationLoop() async {
    _location.changeSettings(accuracy: LocationAccuracy.high, interval: 100, distanceFilter: 3);
    //_locationStream =
      //    _location.onLocationChanged.listen((LocationData currentLocation) {
            //nal currentLocation = await _location.getLocation();
            //final CrPosition position = toCrPosition(currentLocation);
            //_handlePosition(position);
         // });
  }

  CrPosition toCrPosition(LocationData currentLocation) {
    return CrPosition(
      currentLocation.longitude,
      currentLocation.latitude,
      currentLocation.altitude,
      currentLocation.speed,
      currentLocation.heading,
      currentLocation.accuracy,
      currentLocation.speedAccuracy,
      DateTime.fromMillisecondsSinceEpoch(currentLocation.time!.toInt()).toIso8601String(),
    );
  }

  void dispose(){
    //_stream?.cancel();
    //_recordingBloc?.close();
  }
}