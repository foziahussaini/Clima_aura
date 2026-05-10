import 'package:clima_aura/screens/home.dart';
import 'package:clima_aura/screens/manage_city.dart';
import 'package:clima_aura/screens/setting.dart';
import 'package:flutter/material.dart';

import 'components/loading_widget.dart';
import 'components/setting_icon.dart';

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
      theme: ThemeData(scaffoldBackgroundColor: Colors.blue[300]),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/ManageCity': (context) => ManageCity(),
        '/Setting': (context) => Setting()},
    );
  }
}
