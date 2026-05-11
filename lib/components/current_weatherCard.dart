import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class CurrentWeatherCard extends StatefulWidget {
  final String cityName;
  final int temp;
  final String description;
  final int maxTemp;
  final int minTemp;

  CurrentWeatherCard({super.key, required this.cityName, required this.temp, required this.description,
  required this.maxTemp, required this.minTemp});

  @override
  State<CurrentWeatherCard> createState() => _CurrentWeatherCardState();
}

class _CurrentWeatherCardState extends State<CurrentWeatherCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: AnimatedScale(
        scale: _isHovered ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Card( color: kMainBackgroundColor,
          elevation: _isHovered ? 6 : 4,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
            onHover: (hovering) {
              setState(() => _isHovered = hovering);
            },
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.cityName, style: KCardTextStyle),
                      Text("${widget.temp.toString()}°", style: KCardTextStyle),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.description),
                      Text("${widget.maxTemp.toString()}°/${widget.minTemp
                          .toString()}°"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
