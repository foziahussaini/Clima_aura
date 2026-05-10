import 'package:flutter/material.dart';

class ManageCity extends StatefulWidget {
  const ManageCity({super.key});

  @override
  State<ManageCity> createState() => _ManageCityState();
}

class _ManageCityState extends State<ManageCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: [
          Text("Manage Cities"),
          Expanded(child:
          TextField(
            decoration: InputDecoration(
              fillColor: Colors.white38,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide.none
              )
            ),
          ))
        ],
      ),
    );
  }
}
