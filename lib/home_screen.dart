import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:vidurakshak_sih/modules/leaderboard/ui/leaderboard_screen.dart';
import 'package:vidurakshak_sih/modules/map/ui/map_view_screen.dart';
import 'package:vidurakshak_sih/modules/tasks/ui/current_tasks_screen.dart';
import 'package:vidurakshak_sih/utils/screen_util/screen_sizes.dart';
import 'package:vidurakshak_sih/utils/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomSelectedIndex = 0;
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);

  List<Widget> bottomBarPages = [
    CurrentTasksScreen(),
    MapViewScreen(),
    LeaderboardScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: ScreenSizes.screenHeight! * 0.05),
          child: bottomBarPages[bottomSelectedIndex]),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          durationInMilliSeconds: 300,
          bottomBarItems: const [
            BottomBarItem(
              activeItem: Icon(
                Icons.home,
                color: AppColors.primaryColor,
              ),
              inActiveItem: Icon(
                Icons.home,
                color: Colors.grey,
              ),
            ),
            BottomBarItem(
              activeItem: Icon(
                Icons.map,
                color: AppColors.primaryColor,
              ),
              inActiveItem: Icon(
                Icons.map,
                color: Colors.grey,
              ),
            ),
            BottomBarItem(
              activeItem: Icon(
                Icons.leaderboard,
                color: AppColors.primaryColor,
              ),
              inActiveItem: Icon(
                Icons.leaderboard,
                color: Colors.grey,
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              bottomSelectedIndex = index;
            });
          }),
    );
  }
}
