import 'package:flutter/material.dart';

class PulsingTextWidget extends StatefulWidget {
  const PulsingTextWidget({
    super.key,
    required this.text,
    required this.isPulsing,
  });

  final String text;
  final bool isPulsing;

  @override
  State<PulsingTextWidget> createState() => _PulsingTextWidgetState();
}

class _PulsingTextWidgetState extends State<PulsingTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation =
        Tween<double>(begin: 0.1, end: 1).animate(_animationController);

    if (widget.isPulsing) {
      _animationController.repeat(reverse: true);
    } else {
      _animationController.value = 0.0;
    }
  }

  @override
  void didUpdateWidget(PulsingTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isPulsing) {
      _animationController.repeat(reverse: true);
    } else {
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style =
        theme.textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w800);

    if (!widget.isPulsing) {
      return Text(widget.text, style: style);
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Text(widget.text, style: style),
        );
      },
    );
  }
}
