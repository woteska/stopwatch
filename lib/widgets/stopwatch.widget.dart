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
  final ScrollController _scrollController = ScrollController();
  static const startStopActionButtonIconSize = 40.0;
  static const actionButtonIconSize = 30.0;

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
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            flex: 4,
            child: Center(
                child: PulsingTextWidget(
                    text: _stopwatch.formatElapsed(),
                    isPulsing: !_stopwatch.isRunning && !_stopwatch.isZero())),
          ),
          Expanded(
            flex: 6,
            child: _stopwatch.laps.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Scrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: LapTableWidget(laps: _stopwatch.laps),
                        )))
                : const SizedBox(),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: _stopwatch.isRunning ? stopStopwatch : startStopwatch,
        tooltip: _stopwatch.isRunning
            ? 'Stop'
            : _stopwatch.isZero()
                ? 'Start'
                : 'Resume',
        child: Icon(_stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
            size: startStopActionButtonIconSize),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            const Spacer(),
            if (_stopwatch.laps.isNotEmpty || !_stopwatch.isZero())
              IconButton(
                iconSize: actionButtonIconSize,
                icon: const Icon(Icons.replay),
                tooltip: 'Reset',
                onPressed: resetStopwatch,
              ),
            const Spacer(),
            const SizedBox(width: 10),
            const Spacer(),
            if (_stopwatch.isRunning)
              IconButton(
                iconSize: actionButtonIconSize,
                icon: const Icon(Icons.flag),
                tooltip: 'Lap',
                onPressed: lap,
              ),
            if (_stopwatch.laps.isNotEmpty && !_stopwatch.isRunning)
              IconButton(
                iconSize: actionButtonIconSize,
                icon: const Icon(Icons.delete_forever),
                tooltip: 'Delete All Laps',
                onPressed: removeAllLaps,
              ),
            // Using a dummy icon button for avoiding the other buttons jumping effect
            if (!_stopwatch.isRunning && !_stopwatch.laps.isNotEmpty)
              Visibility(
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  visible: false,
                  child: IconButton(
                    iconSize: actionButtonIconSize,
                    icon: const Icon(Icons.abc),
                    onPressed: () {},
                  )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
