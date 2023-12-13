import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidurakshak_sih/home_screen.dart';
import 'package:vidurakshak_sih/modules/tasks/providers/document_provider.dart';
import 'package:vidurakshak_sih/modules/tasks/providers/task_list_provider.dart';
import 'package:vidurakshak_sih/modules/tasks/ui/current_tasks_screen.dart';
import 'package:vidurakshak_sih/utils/screen_util/screen_sizes.dart';
import 'package:vidurakshak_sih/utils/theme/app_theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DocumentProvider()),
    ChangeNotifierProvider(create: (context) => TaskListProvider()),
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
