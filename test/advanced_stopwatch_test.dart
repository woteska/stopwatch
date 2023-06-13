import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/classes/advanced_stopwatch.dart';
import 'package:stopwatch/classes/stopwatch_lap.dart';

void main() {
  test('Should not running and be zero if instantiated', () {
    final stopwatch = AdvancedStopwatch();
    expect(stopwatch.isRunning, false);
    expect(stopwatch.isZero(), true);
  });

  test('Should be increasing if started', () async {
    final stopwatch = AdvancedStopwatch();

    stopwatch.start();

    expect(stopwatch.isRunning, isTrue);

    await Future.delayed(const Duration(milliseconds: 100), () {});

    expect(stopwatch.elapsedMicroseconds > 0, isTrue);

    stopwatch.stop();

    expect(stopwatch.isRunning, isFalse);
  });

  test('Should add laps if running', () {
    final stopwatch = AdvancedStopwatch();

    expect(stopwatch.laps.isEmpty, true);

    stopwatch.start();

    stopwatch.lap();
    stopwatch.lap();

    stopwatch.stop();

    expect(stopwatch.laps.length, 2);
  });

  test('Should not add laps if not running', () {
    final stopwatch = AdvancedStopwatch();

    expect(stopwatch.laps.isEmpty, true);

    stopwatch.lap();

    expect(stopwatch.laps.isEmpty, true);
  });

  test('Should display elapsed time in mm:ss.SSS format', () {
    final stopwatch = AdvancedStopwatch();
    expect(stopwatch.formatElapsed(), '00:00.000');
  });

  test('Should clear the laps out when reset() called', () {
    final stopwatch = AdvancedStopwatch();

    stopwatch.laps.addAll([
      StopwatchLap(Duration.zero, Duration.zero),
      StopwatchLap(Duration.zero, Duration.zero)
    ]);

    expect(stopwatch.laps.isEmpty, false);

    stopwatch.reset();

    expect(stopwatch.laps.isEmpty, true);
  });

  test('Should clear the laps out when reset() called', () {
    final stopwatch = AdvancedStopwatch();

    stopwatch.laps.addAll([
      StopwatchLap(Duration.zero, Duration.zero),
      StopwatchLap(Duration.zero, Duration.zero)
    ]);

    expect(stopwatch.laps.isEmpty, false);

    stopwatch.reset();

    expect(stopwatch.laps.isEmpty, true);
  });
}
