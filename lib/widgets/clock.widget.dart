import 'dart:math';

import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget(
      {super.key, required this.dateTime, this.isSizeSmall = false});

  final DateTime dateTime;
  final bool isSizeSmall;

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  @override
  Widget build(BuildContext context) {
    final double hourAngle =
        (widget.dateTime.hour % 12 + widget.dateTime.minute / 60) * 30 - 180;
    final double minuteAngle =
        (widget.dateTime.minute + widget.dateTime.second / 60) * 6 - 180;
    final double secondAngle = widget.dateTime.second * 6 - 180;

    final isThemeLight = Theme.of(context).brightness == Brightness.light;

    final double handSize = widget.isSizeSmall ? 50 : 100;
    final double circleSize = widget.isSizeSmall ? 100 : 200;

    return SizedBox(
      width: circleSize,
      height: circleSize,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: isThemeLight ? Colors.black : Colors.white, width: 2),
            ),
          ),
          Positioned(
            top: handSize,
            left: handSize,
            child: Container(
              width: widget.isSizeSmall ? 2 : 4,
              height: widget.isSizeSmall ? 20 : 40,
              color: isThemeLight ? Colors.black : Colors.white60,
              alignment: Alignment.bottomCenter,
              transform: Matrix4.rotationZ(hourAngle * pi / 180),
            ),
          ),
          Positioned(
            top: handSize,
            left: handSize,
            child: Container(
              width: widget.isSizeSmall ? 2 : 4,
              height: widget.isSizeSmall ? 30 : 60,
              color: isThemeLight ? Colors.black26 : Colors.white70,
              alignment: Alignment.bottomCenter,
              transform: Matrix4.rotationZ(minuteAngle * pi / 180),
            ),
          ),
          Positioned(
            top: handSize,
            left: handSize,
            child: Container(
              width: 2,
              height: widget.isSizeSmall ? 40 : 80,
              color: Colors.red,
              alignment: Alignment.bottomCenter,
              transform: Matrix4.rotationZ(secondAngle * pi / 180),
            ),
          ),
        ],
      ),
    );
  }
}
