import 'package:flutter/material.dart';

class Setting_icon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const Setting_icon({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(icon, size: 34, color: Colors.white,),
    );
  }
}