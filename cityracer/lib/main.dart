import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import 'package:cityracer/control/TrackingControl.dart';
import 'package:cityracer/model/DisplayConfigurationData.dart';
import 'package:cityracer/model/TrackingData.dart';

void main() {
  runApp(CityRacer());
}

class CityRacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    /*return StreamProvider<TrackingData>(
        initialData: TrackingData.defaultValues(),
        create: (context) => TrackingControl().locationStream,
        child: MaterialApp(
          title: 'Cityracer',
          theme: ThemeData(
            primarySwatch: DisplayConfigurationData.primaryColor,
          ),
          home: const MenuView(title: 'City Racer'),
        ));*/
    return MaterialApp(
            title: 'Cityracer',
            theme: ThemeData(
              primarySwatch: DisplayConfigurationData.primaryColor,
            ),
          home: const MenuView(title: 'City Racer')
    );
  }
}

class MenuView extends StatefulWidget {
  const MenuView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MenuView> createState() => _MenuView();
}

class _MenuView extends State<MenuView> {
  TrackingData _trackingData = TrackingData.defaultValues();
  TrackingControl _trackingControl = TrackingControl();

  _MenuView(){
    _trackingControl.startTracking(updateValues);

  }

  void updateValues(TrackingData trackingData) {
    setState(() {
      _trackingData = trackingData;
    });
  }

  @override
  Widget build(BuildContext context) {

    //var userLocation = Provider.of<TrackingData>(context);
    return Scaffold(
        body: Center(
      child: Text(
          'Lat${_trackingData.latitude} \n' +
          'Long: ${_trackingData.longitude}\n' +
          'Alt${_trackingData.altitude}\n' +
          'Speed: ${_trackingData.speed}\n' +
          'Head${_trackingData.heading}\n' +
          'Accu: ${_trackingData.accuracy}\n' +
          'SpAc${_trackingData.speedAccuracy}\n' +
          'Time: ${_trackingData.dateTimeString}\n'
        ),
    ));
  }
}
