import 'package:stopwatch/mixins/stopwatch_time_format.mixin.dart';

class StopwatchLap with StopwatchTimeFormatMixin {
  Duration elapsed;
  Duration previousLapDifference;

  StopwatchLap(this.elapsed, this.previousLapDifference);

  String formatElapsed() => formatDuration(elapsed);

  String formatPreviousLapDifference() => formatDuration(previousLapDifference);
}
