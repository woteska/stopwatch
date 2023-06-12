mixin StopwatchTimeFormatMixin {
  String formatDuration(Duration duration) {
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    String milliseconds =
        duration.inMilliseconds.remainder(1000).toString().padLeft(3, "0");

    return "$minutes:$seconds.$milliseconds";
  }
}
