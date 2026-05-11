import 'package:clima_aura/screens/home.dart';
import 'package:clima_aura/screens/manage_city.dart';
import 'package:clima_aura/screens/setting.dart';
import 'package:clima_aura/utilities/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: kMainBackgroundColor),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/ManageCity': (context) => ManageCity(),
        '/Setting': (context) => Setting()},
    );
  }
}
