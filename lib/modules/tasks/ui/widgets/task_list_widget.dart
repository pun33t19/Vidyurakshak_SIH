import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidurakshak_sih/modules/tasks/enums/task_completion_enum.dart';
import 'package:vidurakshak_sih/modules/tasks/providers/task_list_provider.dart';
import 'package:vidurakshak_sih/modules/tasks/ui/task_details_screen.dart';
import 'package:vidurakshak_sih/modules/tasks/ui/widgets/single_task_widget.dart';
import 'package:vidurakshak_sih/utils/screen_util/gap.dart';
import 'package:vidurakshak_sih/utils/screen_util/screen_sizes.dart';

class TaskListScreen extends StatefulWidget {
  final TaskCompletion taskCompletion;
  const TaskListScreen({super.key, required this.taskCompletion});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskListProvider>(context, listen: false).addTasksItem();
    });
    return SizedBox(
      height: ScreenSizes.screenHeight! * 0.7,
      width: ScreenSizes.screenWidth,
      child: Consumer<TaskListProvider>(
        builder: (context, value, child) {
          final tasksList = widget.taskCompletion == TaskCompletion.active
              ? value.activeTasksList
              : value.completedTasksList;
          if (tasksList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Provider.of<TaskListProvider>(context, listen: false)
                          .updateTasksModel(tasksList[index]);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          settings: RouteSettings(name: 'task_details_screen'),
                          builder: (context) =>
                              TaskDetailsScreen(taskModel: tasksList[index]),
                        ),
                      );
                    },
                    child: SingleTaskWidget(
                      taskModel: tasksList[index],
                    ));
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: Gap.sh,
                  ),
              itemCount: tasksList.length);
        },
      ),
    );
  }
}
