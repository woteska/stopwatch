import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/widgets/lap_table.widget.dart';
import 'package:stopwatch/widgets/pulsing_text.widget.dart';
import 'package:stopwatch/widgets/stopwatch.widget.dart';

void main() {
  const zeroTime = '00:00.000';

  testWidgets(
      'Pressing the Start button starts the stopwatch and the elapsed time increases over time & '
      'Pressing the Stop button stops the stopwatch and the elapsed time is not changing over time',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: StopwatchWidget(),
      ),
    );

    // Find the PulsingTextWidget
    final pulsingTextWidgets = find.byType(PulsingTextWidget);

    // Verify that the PulsingTextWidget is rendered on the screen
    expect(pulsingTextWidgets, findsOneWidget);

    // Verify that the time is zero initially and rendered on the screen
    expect(find.text(zeroTime), findsOneWidget);

    // Find the Start and Stop buttons
    final startButton = find.byIcon(Icons.play_arrow);
    final stopButton = find.byIcon(Icons.pause);

    // Verify that only the Start button visible
    expect(startButton, findsOneWidget);
    expect(stopButton, findsNothing);

    // Press the Start button
    await tester.tap(startButton);
    await tester.pump();

    // Verify that Start button is not visible, but Stop button
    expect(startButton, findsNothing);
    expect(stopButton, findsOneWidget);

    // Press the Stop button
    await tester.tap(stopButton);
    await tester.pump();

    // Find and get the first PulsingTextWidget instance
    final pulsingTextWidget =
        pulsingTextWidgets.evaluate().first.widget as PulsingTextWidget;

    // Saving the current time text for later
    final timeAfterStop = pulsingTextWidget.text.toString();

    // Verify that the time is not zero, so it has been started increasing
    expect(timeAfterStop != zeroTime, true);

    // Verify that the time is rendered on the screen
    expect(find.text(timeAfterStop), findsOneWidget);

    // Start the stopwatch again
    await tester.tap(startButton);
    await tester.pump(const Duration(microseconds: 1));

    // Verify that the time saved previously had been changed
    expect(find.text(timeAfterStop), findsNothing);

    // Stop the stopwatch again
    await tester.tap(stopButton);
    await tester.pump();
  });

  testWidgets(
      'Pressing the Reset button resets the stopwatch to 0 and stops the elapsed time',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: StopwatchWidget(),
      ),
    );

    // Find the relevant action buttons
    final startButton = find.byIcon(Icons.play_arrow);
    final resetButton = find.byIcon(Icons.replay);

    // Verify that the time is zero initially and rendered on the screen
    expect(find.text(zeroTime), findsOneWidget);

    // Press the Start button
    await tester.tap(startButton);
    await tester.pump(const Duration(microseconds: 1));

    // Verify that the time started increasing and the start button is not visible
    expect(find.text(zeroTime), findsNothing);
    expect(startButton, findsNothing);

    // Press the Reset button
    await tester.tap(resetButton);
    await tester.pump();

    // Verify that the time is 0 again and the start button is visible
    expect(find.text(zeroTime), findsOneWidget);
    expect(startButton, findsOneWidget);

    // Wait for a while
    await tester.pump(const Duration(microseconds: 1));

    // Verify that the time is still 0 and the start button is visible
    expect(find.text(zeroTime), findsOneWidget);
    expect(startButton, findsOneWidget);
  });

  testWidgets('Pressing the Lap button adds the lap rows to the DataTable',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: StopwatchWidget(),
      ),
    );

    // Find all action buttons
    final startButton = find.byIcon(Icons.play_arrow);
    final resetButton = find.byIcon(Icons.replay);
    final lapButton = find.byIcon(Icons.flag);

    // Find the LapTableWidget
    final lapTableWidget = find.byType(LapTableWidget);

    // Verify that LapTableWidget is not visible initially
    expect(lapTableWidget, findsNothing);

    // Press the Start button and the Lap button 3x
    await tester.tap(startButton);
    await tester.pump();
    await tester.tap(lapButton);
    await tester.tap(lapButton);
    await tester.tap(lapButton);
    await tester.pump();

    // Verify that LapTableWidget is visible now and has 3 rows
    expect(lapTableWidget, findsOneWidget);
    final firstLapTableWidget =
        lapTableWidget.evaluate().first.widget as LapTableWidget;
    expect(firstLapTableWidget.laps.length, 3);

    // Press the Reset button
    await tester.tap(resetButton);
    await tester.pump();

    // Verify that LapTableWidget is invisible again
    expect(lapTableWidget, findsNothing);
  });

  testWidgets('Complex testing of all action buttons between state changes',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: StopwatchWidget(),
      ),
    );

    // Find all action buttons
    final startButton = find.byIcon(Icons.play_arrow);
    final stopButton = find.byIcon(Icons.pause);
    final resetButton = find.byIcon(Icons.replay);
    final lapButton = find.byIcon(Icons.flag);
    final deleteAllLapsButton = find.byIcon(Icons.delete_forever);

    // Verify that only the Start button visible initially
    expect(startButton, findsOneWidget);
    expect(stopButton, findsNothing);
    expect(resetButton, findsNothing);
    expect(lapButton, findsNothing);
    expect(deleteAllLapsButton, findsNothing);

    // Press the Start button
    await tester.tap(startButton);
    await tester.pump();

    // Verify that Start button is not visible after start, but Stop button
    // Verify that Lap button and Reset button are visible
    // Verify that DeleteAllLaps button is not visible since there are no laps yet and the stopper is running
    expect(startButton, findsNothing);
    expect(stopButton, findsOneWidget);
    expect(resetButton, findsOneWidget);
    expect(lapButton, findsOneWidget);
    expect(deleteAllLapsButton, findsNothing);

    // Press the Lap button
    await tester.tap(lapButton);
    await tester.tap(lapButton);
    await tester.tap(lapButton);
    await tester.pump();

    // Verify that Start button is still not visible, but Stop button
    // Verify that Lap button and Reset button are still visible
    // Verify that DeleteAllLaps button is still not visible even if there are laps, but the stopper is still running
    expect(startButton, findsNothing);
    expect(stopButton, findsOneWidget);
    expect(resetButton, findsOneWidget);
    expect(lapButton, findsOneWidget);
    expect(deleteAllLapsButton, findsNothing);

    // Press the Stop button
    await tester.tap(stopButton);
    await tester.pump();

    // Verify that Stop button is visible now, but not Start button
    // Verify that the Reset button is still visible
    // Verify that Lap button is not visible since the stopper was stopped
    // Verify that DeleteAllLaps button now visible, because there are laps and the stopper is not running
    expect(startButton, findsOneWidget);
    expect(stopButton, findsNothing);
    expect(resetButton, findsOneWidget);
    expect(lapButton, findsNothing);
    expect(deleteAllLapsButton, findsOneWidget);

    // Press the Start button again
    await tester.tap(startButton);
    await tester.pump();

    // Verify that Start button is not visible, but Stop button
    // Verify that Lap button and Reset button are visible
    // Verify that DeleteAllLaps button is not visible even if there are laps, but the stopper is running
    expect(startButton, findsNothing);
    expect(stopButton, findsOneWidget);
    expect(resetButton, findsOneWidget);
    expect(lapButton, findsOneWidget);
    expect(deleteAllLapsButton, findsNothing);

    // Press the Stop button again
    await tester.tap(stopButton);
    await tester.pump();

    // Verify that the DeleteAllLaps button is visible
    expect(deleteAllLapsButton, findsOneWidget);

    // Press the DeleteAllLaps button to remove the laps
    await tester.tap(deleteAllLapsButton);
    await tester.pump();

    // Verify that the DeleteAllLaps is not visible now
    expect(deleteAllLapsButton, findsNothing);

    // Press the Reset button
    await tester.tap(resetButton);
    await tester.pump();

    // Verify that buttons visibility was set back to the initial state
    expect(startButton, findsOneWidget);
    expect(stopButton, findsNothing);
    expect(resetButton, findsNothing);
    expect(lapButton, findsNothing);
    expect(deleteAllLapsButton, findsNothing);
  });
}
