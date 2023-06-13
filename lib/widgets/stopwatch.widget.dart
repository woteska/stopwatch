import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stopwatch/classes/advanced_stopwatch.dart';
import 'package:stopwatch/mixins/stopwatch_time_format.mixin.dart';
import 'package:stopwatch/widgets/lap_table.widget.dart';
import 'package:stopwatch/widgets/pulsing_text.widget.dart';

class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  State<StopwatchWidget> createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget>
    with TickerProviderStateMixin, StopwatchTimeFormatMixin {
  final AdvancedStopwatch _stopwatch = AdvancedStopwatch();
  late Ticker _ticker;

  static const actionButtonOpacityDurationMilliseconds = 250;
  static const actionButtonSizedBoxSize = 30.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _ticker.dispose();
    super.dispose();
  }

  void startStopwatch() {
    setState(() {
      _stopwatch.start();
      _ticker.start();
    });
  }

  void stopStopwatch() {
    setState(() {
      _stopwatch.stop();
      _ticker.stop();
    });
  }

  void resetStopwatch() {
    setState(() {
      stopStopwatch();
      _stopwatch.reset();
    });
  }

  void removeAllLaps() {
    setState(() {
      _stopwatch.removeAllLaps();
    });
  }

  void lap() {
    _stopwatch.lap();
  }

  @override
  Widget build(BuildContext context) {
    var isResetButtonVisible =
        _stopwatch.laps.isNotEmpty || !_stopwatch.isZero();
    var isRemoveAllLapsButtonVisible =
        !_stopwatch.isRunning && _stopwatch.laps.isNotEmpty;

    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      PulsingTextWidget(
          text: _stopwatch.formatElapsed(),
          isPulsing: !_stopwatch.isRunning && !_stopwatch.isZero()),
      const SizedBox(height: actionButtonSizedBoxSize),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
              visible: isResetButtonVisible,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                opacity: isResetButtonVisible ? 1.0 : 0.0,
                duration: const Duration(
                    milliseconds: actionButtonOpacityDurationMilliseconds),
                child: IconButton(
                  icon: const Icon(Icons.replay),
                  tooltip: 'Reset',
                  onPressed: resetStopwatch,
                ),
              )),
          const SizedBox(width: actionButtonSizedBoxSize),
          IconButton.filled(
            icon: Icon(_stopwatch.isRunning ? Icons.pause : Icons.play_arrow),
            onPressed: _stopwatch.isRunning ? stopStopwatch : startStopwatch,
            tooltip: _stopwatch.isRunning
                ? 'Stop'
                : _stopwatch.isZero()
                    ? 'Start'
                    : 'Resume',
            iconSize: 40,
          ),
          const SizedBox(width: actionButtonSizedBoxSize),
          Visibility(
              visible: _stopwatch.isRunning,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                opacity: _stopwatch.isRunning ? 1.0 : 0.0,
                duration: const Duration(
                    milliseconds: actionButtonOpacityDurationMilliseconds),
                child: IconButton(
                  icon: const Icon(Icons.flag),
                  tooltip: 'Lap',
                  onPressed: lap,
                ),
              )),
        ],
      ),
      const SizedBox(height: actionButtonSizedBoxSize),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
              visible: isRemoveAllLapsButtonVisible,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                opacity: isRemoveAllLapsButtonVisible ? 1.0 : 0.0,
                duration: const Duration(
                    milliseconds: actionButtonOpacityDurationMilliseconds),
                child: ElevatedButton(
                  onPressed: removeAllLaps,
                  child: const Text('Remove All Laps'),
                ),
              ))
        ],
      ),
      const SizedBox(height: actionButtonSizedBoxSize),
      SizedBox(
        height: 300,
        child: Visibility(
          visible: _stopwatch.laps.isNotEmpty,
          child: SingleChildScrollView(
            child: LapTableWidget(laps: _stopwatch.laps),
          ),
        ),
      ),
    ]));
  }
}
