import 'package:hive/hive.dart';

part 'TrackingData.g.dart';


@HiveType(typeId: 0)
class Session {
  @HiveField(0)
  List locationList = <TrackingLocationData>[];
}

@HiveType(typeId: 1)
class TrackingLocationData{
  @HiveField(0)
  final double longitude;
  @HiveField(1)
  final double latitude;
  @HiveField(2)
  final double altitude;
  @HiveField(3)
  final double speed;
  @HiveField(4)
  final double heading;
  @HiveField(5)
  final double accuracy;
  @HiveField(6)
  final double speedAccuracy;
  @HiveField(7)
  final String dateTimeString;

  const TrackingLocationData({
    required this.longitude,
    required this.latitude,
    required this.altitude,
    required this.speed,
    required this.heading,
    required this.accuracy,
    required this.speedAccuracy,
    required this.dateTimeString
  });

  const TrackingLocationData.defaultValues() :
        this.longitude = 0.0,
        this.latitude = 0.0,
        this.altitude = 0.0,
        this.speed = 0.0,
        this.heading = 0.0,
        this.accuracy = 0.0,
        this.speedAccuracy = 0.0,
        this.dateTimeString = "-";
}



