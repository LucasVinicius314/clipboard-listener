import 'package:clipboard_listener/pages/home_page.dart';
import 'package:clipboard_listener/utils/constants.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0),
        cardTheme: const CardTheme(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      routes: {
        HomePage.route: (context) => const HomePage(),
      },
      title: Constants.appName,
    );
  }
}
