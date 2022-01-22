// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TrackingData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final int typeId = 0;

  @override
  Session read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Session()..locationList = (fields[0] as List).cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.locationList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrackingLocationDataAdapter extends TypeAdapter<TrackingLocationData> {
  @override
  final int typeId = 1;

  @override
  TrackingLocationData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrackingLocationData(
      longitude: fields[0] as double,
      latitude: fields[1] as double,
      altitude: fields[2] as double,
      speed: fields[3] as double,
      heading: fields[4] as double,
      accuracy: fields[5] as double,
      speedAccuracy: fields[6] as double,
      dateTimeString: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TrackingLocationData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.longitude)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.altitude)
      ..writeByte(3)
      ..write(obj.speed)
      ..writeByte(4)
      ..write(obj.heading)
      ..writeByte(5)
      ..write(obj.accuracy)
      ..writeByte(6)
      ..write(obj.speedAccuracy)
      ..writeByte(7)
      ..write(obj.dateTimeString);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackingLocationDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
