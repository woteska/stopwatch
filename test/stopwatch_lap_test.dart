import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/classes/stopwatch_lap.dart';

void main() {
  test('Should display times in mm:ss.SSS format', () {
    final lap = StopwatchLap(const Duration(minutes: 10, seconds: 2),
        const Duration(seconds: 0, milliseconds: 123));

    expect(lap.formatElapsed(), '10:02.000');
    expect(lap.formatPreviousLapDifference(), '00:00.123');
  });
}
