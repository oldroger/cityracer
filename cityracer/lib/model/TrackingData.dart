class CityracerPosition {
  final double? _longitude;
  final double? _latitude;
  final double? _altitude;
  final double? _speed;
  final double? _heading;
  final double? _accuracy;
  final double? _speedAccuracy;
  final String? _dateTimeString;
  final bool? _valid;

  const CityracerPosition(
      this._longitude,
      this._latitude,
      this._altitude,
      this._speed,
      this._heading,
      this._accuracy,
      this._speedAccuracy,
      this._dateTimeString) : _valid = true;

  double? get longitude => _longitude;
  double? get latitude => _latitude;
  double? get altitude => _altitude;
  double? get speed => _speed;
  double? get heading => _heading;
  double? get accuracy => _accuracy;
  double? get speedAccuracy => _speedAccuracy;
  String? get timeIso8601 => _dateTimeString;
  bool? get valid => _valid;
}

