//to check database directly
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:cityracer/model/TrackingData.dart';

final String database_path='database';

void main() {
  setUpAll(() async{
      Hive.init(database_path);
      Hive.registerAdapter(SessionAdapter());
      Hive.registerAdapter(TrackingLocationDataAdapter());
  });

  setUp(() {

  });

  tearDown(() async{
    var box = await Hive.openBox('sessionBox');
    await box.close();

    final dir = Directory(database_path);
    if(await dir.exists()) {
      await dir.delete(recursive: true);
    }
  });

  test('Is the content of the first location in a sesssion correct', () async{
    var box = await Hive.openBox('sessionBox');
    Session session = Session();

    session.locationList.add(
        TrackingLocationData(
            latitude: 1.0,
            longitude: 2.0,
            altitude: 3.0,
            speed: 4.0,
            heading: 5.0,
            accuracy: 6.0,
            speedAccuracy: 7.0,
            dateTimeString: "Datum"
        )
    );

    box.put('test',session);
    List readSessionList = box.getAt(0).locationList;
    expect(readSessionList[0].latitude, 1.0);
    expect(readSessionList[0].longitude, 2.0);
    expect(readSessionList[0].altitude, 3.0);
    expect(readSessionList[0].speed, 4.0);
    expect(readSessionList[0].heading, 5.0);
    expect(readSessionList[0].accuracy, 6.0);
    expect(readSessionList[0].speedAccuracy, 7.0);
    expect(readSessionList[0].dateTimeString, "Datum");

  });

  test('Are multiple sessions stored', () async{
    var box = await Hive.openBox('sessionBox');
    Session session = Session();

    session.locationList.add(
        TrackingLocationData(
            latitude: 1.0,
            longitude: 2.0,
            altitude: 3.0,
            speed: 4.0,
            heading: 5.0,
            accuracy: 6.0,
            speedAccuracy: 7.0,
            dateTimeString: "Datum"
        )
    );

    //box takes key value pairs, thus first param must be unique
    box.put('test1',session);
    box.put('test2',session);

    expect(box.length, 2);

  });

  test('Is the content of the list stored correctly', () async{
    var box = await Hive.openBox('sessionBox');
    Session session = Session();

    box.put('test',session);

    session.locationList.add(
        TrackingLocationData(
            latitude: 1.0,
            longitude: 2.0,
            altitude: 3.0,
            speed: 4.0,
            heading: 5.0,
            accuracy: 6.0,
            speedAccuracy: 7.0,
            dateTimeString: "Datum"
        )
    );

    session.locationList.add(
        TrackingLocationData(
            latitude: 1.1,
            longitude: 2.1,
            altitude: 3.1,
            speed: 4.1,
            heading: 5.1,
            accuracy: 6.1,
            speedAccuracy: 7.1,
            dateTimeString: "Datum 2"
        )
    );

    List readSessionList = box.getAt(0).locationList;
    expect(readSessionList.length, 2);

    expect(readSessionList[0].latitude, 1.0);
    expect(readSessionList[0].longitude, 2.0);
    expect(readSessionList[0].altitude, 3.0);
    expect(readSessionList[0].speed, 4.0);
    expect(readSessionList[0].heading, 5.0);
    expect(readSessionList[0].accuracy, 6.0);
    expect(readSessionList[0].speedAccuracy, 7.0);
    expect(readSessionList[0].dateTimeString, "Datum");

    expect(readSessionList[1].latitude, 1.1);
    expect(readSessionList[1].longitude, 2.1);
    expect(readSessionList[1].altitude, 3.1);
    expect(readSessionList[1].speed, 4.1);
    expect(readSessionList[1].heading, 5.1);
    expect(readSessionList[1].accuracy, 6.1);
    expect(readSessionList[1].speedAccuracy, 7.1);
    expect(readSessionList[1].dateTimeString, "Datum 2");
  });

  test('Is DateTime as String stored correctly', () async{
    var box = await Hive.openBox('sessionBox');
    Session session = Session();

    String timeString = DateTime.now().toIso8601String();

    session.locationList.add(
        TrackingLocationData(
            latitude: 1.0,
            longitude: 2.0,
            altitude: 3.0,
            speed: 4.0,
            heading: 5.0,
            accuracy: 6.0,
            speedAccuracy: 7.0,
            dateTimeString: timeString
        )
    );

    //box takes key value pairs, thus first param must be unique
    box.put('test',session);

    List readSessionList = box.getAt(0).locationList;
    expect(readSessionList[0].dateTimeString, timeString);
  });

}