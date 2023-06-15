import 'package:stopwatch/mixins/stopwatch_time_format.mixin.dart';

class StopwatchLap with StopwatchTimeFormatMixin {
  Duration elapsed;
  Duration lapDifference;

  StopwatchLap(this.elapsed, this.lapDifference);

  String formatElapsed() => formatDuration(elapsed);

  String formatLapDifference() => formatDuration(lapDifference);
}
