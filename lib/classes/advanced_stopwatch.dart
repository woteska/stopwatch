import 'package:stopwatch/classes/stopwatch_lap.dart';
import 'package:stopwatch/mixins/stopwatch_time_format.mixin.dart';

class AdvancedStopwatch extends Stopwatch with StopwatchTimeFormatMixin {
  final List<StopwatchLap> laps = [];

  bool isZero() => elapsedMicroseconds == 0;

  String formatElapsed() => formatDuration(elapsed);

  @override
  void reset() {
    super.reset();
    laps.clear();
  }

  void removeAllLaps() {
    laps.clear();
  }

  void lap() {
    if (!isRunning) {
      return;
    }

    final currentElapsed = elapsed;
    var lapDifference = elapsed;

    if (laps.isNotEmpty) {
      final previousLap = laps.last;
      lapDifference = currentElapsed - previousLap.elapsed;
    }

    final newLap = StopwatchLap(currentElapsed, lapDifference);

    laps.add(newLap);
  }
}
