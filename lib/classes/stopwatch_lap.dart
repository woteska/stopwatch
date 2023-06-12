import 'package:stopwatch/mixins/stopwatch_time_format.mixin.dart';

class StopwatchLap with StopwatchTimeFormatMixin {
  Duration elapsed = const Duration();
  Duration previousLapDifference = const Duration();

  StopwatchLap(this.elapsed, this.previousLapDifference);

  String formatElapsed() => formatDuration(elapsed);

  String formatPreviousLapDifference() => formatDuration(previousLapDifference);
}
