import 'package:expense_tracker_ui/router/app_router.dart';
import 'package:flutter/material.dart';
import 'constants/string_const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .light,
        fontFamily: StringConst.appFontFamily
      ),
      routerConfig: router,
      builder: (ctx, child) => child!,
    );
  }
}