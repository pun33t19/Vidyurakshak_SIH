import 'package:flutter/material.dart';
import 'package:vidurakshak_sih/modules/tasks/ui/task_details_screen.dart';
import 'package:vidurakshak_sih/modules/tasks/ui/widgets/single_task_widget.dart';
import 'package:vidurakshak_sih/utils/screen_util/gap.dart';
import 'package:vidurakshak_sih/utils/screen_util/screen_sizes.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSizes.screenHeight! * 0.7,
      width: ScreenSizes.screenWidth,
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TaskDetailsScreen()));
                },
                child: const SingleTaskWidget());
          },
          separatorBuilder: (context, index) => SizedBox(
                height: Gap.sh,
              ),
          itemCount: 15),
    );
  }
}
