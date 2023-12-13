import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vidurakshak_sih/modules/tasks/enums/task_completion_enum.dart';
import 'package:vidurakshak_sih/modules/tasks/providers/task_list_provider.dart';
import 'package:vidurakshak_sih/modules/tasks/repository/tasks_repository.dart';
import 'package:vidurakshak_sih/modules/tasks/ui/widgets/task_list_widget.dart';
import 'package:vidurakshak_sih/utils/screen_util/gap.dart';
import 'package:vidurakshak_sih/utils/screen_util/screen_sizes.dart';
import 'package:vidurakshak_sih/utils/styles/text_styles.dart';
import 'package:vidurakshak_sih/utils/theme/app_colors.dart';

class CurrentTasksScreen extends StatefulWidget {
  const CurrentTasksScreen({super.key});

  @override
  State<CurrentTasksScreen> createState() => _CurrentTasksScreenState();
}

class _CurrentTasksScreenState extends State<CurrentTasksScreen> {
  List<String> tabs = ['Active', 'Completed'];
  int selectedIndex = 0;
  List<Widget> currentScreen = [
    TaskListScreen(
      taskCompletion: TaskCompletion.active,
    ),
    TaskListScreen(
      taskCompletion: TaskCompletion.completed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              TasksRepository().addData();
            },
            child: Text(
              'Tasks',
              style: TextStyles.largeHeaderText,
            ),
          ),
          SizedBox(
            height: Gap.sh,
          ),
          Center(
            child: FlutterToggleTab(
                width: ScreenSizes.screenWidth! * 0.2,
                labels: tabs,
                selectedTextStyle: GoogleFonts.lato(
                    fontSize: 18, color: AppColors.secondaryTextColor),
                unSelectedTextStyle: GoogleFonts.lato(
                    fontSize: 18, color: AppColors.primaryTextColor),
                selectedLabelIndex: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                selectedIndex: selectedIndex),
          ),
          currentScreen[selectedIndex]
        ],
      ),
    );
  }
}
