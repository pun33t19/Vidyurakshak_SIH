import 'package:flutter/material.dart';
import 'package:vidurakshak_sih/modules/tasks/enums/tasks_priority_enum.dart';

class GlowingAlertIcon extends StatefulWidget {
  final TasksPriority tasksPriority;

  const GlowingAlertIcon({super.key, required this.tasksPriority});

  @override
  _GlowingAlertIconState createState() => _GlowingAlertIconState();
}

class _GlowingAlertIconState extends State<GlowingAlertIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getColorCode(TasksPriority tasksPriority) {
    switch (tasksPriority) {
      case TasksPriority.high:
        return const Color.fromARGB(255, 250, 19, 2);

      case TasksPriority.medium:
        return const Color.fromARGB(255, 234, 213, 21);

      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getColorCode(widget.tasksPriority).withOpacity(
              _controller.value <= 0 ? 0.5 : 1 - _controller.value,
            ),
          ),
        );
      },
    );
  }
}
