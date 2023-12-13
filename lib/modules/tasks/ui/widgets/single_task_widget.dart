import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vidurakshak_sih/modules/tasks/enums/tasks_priority_enum.dart';
import 'package:vidurakshak_sih/modules/tasks/models/task_model.dart';
import 'package:vidurakshak_sih/utils/screen_util/gap.dart';
import 'package:vidurakshak_sih/utils/screen_util/screen_sizes.dart';
import 'package:vidurakshak_sih/utils/styles/text_styles.dart';
import 'package:vidurakshak_sih/utils/theme/app_colors.dart';

class SingleTaskWidget extends StatelessWidget {
  final TaskModel taskModel;
  const SingleTaskWidget({super.key, required this.taskModel});

  Color getPriorityColor(TasksPriority tasksPriority) {
    switch (tasksPriority) {
      case TasksPriority.high:
        return Colors.red;
      case TasksPriority.medium:
        return Colors.yellow;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: ScreenSizes.screenWidth,
          height: ScreenSizes.screenHeight! * 0.08,
          padding: EdgeInsets.only(top: 2, left: 8, bottom: 2),
          decoration: BoxDecoration(color: AppColors.secondaryTextColor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.remove_red_eye_sharp,
                size: 30,
                color: getPriorityColor(taskModel.priority),
              ),
              SizedBox(
                width: Gap.sw,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      taskModel.title,
                      style: TextStyles.ts400s,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.route),
                  Text(
                    '200m',
                    style: TextStyles.ts400s,
                  )
                ],
              ),
              SizedBox(
                width: Gap.sw,
              ),
              Container(
                width: 10,
                height: ScreenSizes.screenHeight! * 0.9,
                color: getPriorityColor(TasksPriority.medium),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: ScreenSizes.screenWidth,
        height: ScreenSizes.screenHeight! * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: taskModel.active
              ? Colors.transparent
              : Colors.black.withOpacity(0.2),
        ),
      ),
    ]);
  }
}
