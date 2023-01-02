import 'package:flutter/material.dart';
import 'package:quizz_app/view/home_page.dart';
import 'package:provider/provider.dart';

import 'theme/theme_manager.dart';

void main() {
  // runApp(
  //   ChangeNotifierProvider(
  //       create: ((context) => ThemeManager()), child: const MyApp()),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final theme = Provider.of<ThemeManager>(context).getTheme();
    return ChangeNotifierProvider(
      create: ((context) => ThemeManager()),
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'Quizz App',
            theme: themeManager.getTheme(),
            home: HomePage(),
          );
        },
      ),
    );
  }
}
