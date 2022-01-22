// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:cityracer/model/TrackingData.dart';

import 'package:cityracer/main.dart';

void main() {
  testWidgets('Check if update mechanism works', (WidgetTester tester) async {

    //todo: howto pumpWidget MenuView?
    await tester.pumpWidget(CityRacer());
    final MenuViewState myWidgetState = tester.state<MenuViewState>(find.byType(MenuView));

    expect(find.text(
        'Lat: 0.0\n' +
        'Long: 0.0\n' +
        'Alt: 0.0\n' +
        'Speed: 0.0\n' +
        'Head: 0.0\n' +
        'Accu: 0.0\n' +
        'SpAc: 0.0\n' +
        'Time: -'), findsOneWidget);

    TrackingLocationData trackingData = TrackingLocationData(
        latitude: 1.0,
        longitude: 2.0,
        altitude: 3.0,
        speed: 4.0,
        heading: 5.0,
        accuracy: 6.0,
        speedAccuracy: 7.0,
        dateTimeString: "Datum"
    );
    myWidgetState.updateValues(trackingData);

    //await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text(
        'Lat: 1.0\n' +
        'Long: 2.0\n' +
        'Alt: 3.0\n' +
        'Speed: 4.0\n' +
        'Head: 5.0\n' +
        'Accu: 6.0\n' +
        'SpAc: 7.0\n' +
        'Time: Datum'), findsOneWidget);
  });
}
