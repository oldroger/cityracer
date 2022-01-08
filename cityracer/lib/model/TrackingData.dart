class TrackingData{
  final double longitude;
  final double latitude;
  final double altitude;
  final double speed;
  final double heading;
  final double accuracy;
  final double speedAccuracy;
  final String dateTimeString;

  const TrackingData({
    required this.longitude,
    required this.latitude,
    required this.altitude,
    required this.speed,
    required this.heading,
    required this.accuracy,
    required this.speedAccuracy,
    required this.dateTimeString
  });

  const TrackingData.defaultValues() :
        this.longitude = 0.0,
        this.latitude = 0.0,
        this.altitude = 0.0,
        this.speed = 0.0,
        this.heading = 0.0,
        this.accuracy = 0.0,
        this.speedAccuracy = 0.0,
        this.dateTimeString = "-";
}

