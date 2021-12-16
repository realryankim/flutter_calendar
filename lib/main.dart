import 'package:flutter/material.dart';
import 'package:flutter_calendar/src/app.dart';
import 'package:flutter_calendar/src/binding/binding.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calendar',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          surface: Colors.grey[800],
          // AppBar title color, surface text color
          onSurface: Colors.white,
          // Selected line and current day dot color
          secondary: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.red,
        ),
      ),
      initialBinding: Binding(),
      home: App(),
    );
  }
}
