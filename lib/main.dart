import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidurakshak_sih/home_screen.dart';
import 'package:vidurakshak_sih/modules/tasks/providers/document_provider.dart';
import 'package:vidurakshak_sih/modules/tasks/ui/current_tasks_screen.dart';
import 'package:vidurakshak_sih/utils/screen_util/screen_sizes.dart';
import 'package:vidurakshak_sih/utils/theme/app_theme.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DocumentProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenSizes().initScreenConstants(context);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        home: const HomeScreen());
  }
}
