import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import 'package:cityracer/control/TrackingControl.dart';
import 'package:cityracer/model/DisplayConfigurationData.dart';
import 'package:cityracer/model/TrackingData.dart';

void main() {
  //todo use flutter errorWidget
  try {
    runApp(CityRacer());
  } on Exception catch (e) {
    //General exceptions
    print('Args - should\'nt happen: $e');
  } catch (e) {
    // all problems
    print('Damn - sorry: $e');
  }

}

class CityRacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();

    return MaterialApp(
            title: 'City Racer',
            theme: ThemeData(
              primarySwatch: DisplayConfigurationData.primaryColor,
            ),
          home: const MenuView(title: 'City Racer Menu')
    );
  }
}

class MenuView extends StatefulWidget {
  const MenuView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MenuView> createState() => MenuViewState();
}

@visibleForTesting
class MenuViewState extends State<MenuView> {
  TrackingLocationData _trackingData = TrackingLocationData.defaultValues();
  TrackingControl _trackingControl = TrackingControl();

  MenuViewState(){
  }

  void updateValues(TrackingLocationData trackingData) {
    setState(() {
      _trackingData = trackingData;
    });
  }

  void onStart() {
    _trackingControl.startTracking(updateValues);

  }
  void onStop() {
    _trackingControl.stopTracking();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    //var userLocation = Provider.of<TrackingData>(context);
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  'Lat: ${_trackingData.latitude}\n' +
                      'Long: ${_trackingData.longitude}\n' +
                      'Alt: ${_trackingData.altitude}\n' +
                      'Speed: ${_trackingData.speed}\n' +
                      'Head: ${_trackingData.heading}\n' +
                      'Accu: ${_trackingData.accuracy}\n' +
                      'SpAc: ${_trackingData.speedAccuracy}\n' +
                      'Time: ${_trackingData.dateTimeString}'
              ),
              ElevatedButton(
                style: style,
                onPressed: onStart,
                child: const Text('Start'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: style,
                onPressed: onStop,
                child: const Text('Stop'),
              ),
            ],
          ),
        ),

    );
  }
}
