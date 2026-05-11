import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KLightColor,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 14),
          child: Text("Settings", style: KTitleTextStyle),
        ),
      ),
      body: Column(
        children: [
          Text("Units"),
          SizedBox(height: 8),
          Card(child: Column(children: [Card(), Card(), Card()])),
          Text("Units"),
          SizedBox(height: 8),
          Card(child: Column(children: [Card(), Card()])),
        ],
      ),
    );
  }
}
