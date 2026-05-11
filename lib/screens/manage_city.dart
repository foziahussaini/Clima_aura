import 'package:flutter/material.dart';

import '../components/current_weatherCard.dart';
import '../utilities/constants.dart';

class ManageCity extends StatefulWidget {
  const ManageCity({super.key});

  @override
  State<ManageCity> createState() => _ManageCityState();
}

class _ManageCityState extends State<ManageCity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KLightColor,
      appBar: AppBar(toolbarHeight: 80,
        backgroundColor: KLightColor,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 9.0, top: 16),
          child: Text("Manage Cities", style: KTitleTextStyle,),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
          padding: const EdgeInsets.all(14),
      child: Expanded(
        child: TextField(
          decoration: KTextFeildDecoration,
          onSubmitted: (String typeName) {
            print(typeName);
          },
        ),
      ),
    ),
    SizedBox(height: 8,),
    Padding(
    padding: const EdgeInsets.only(left: 18.0),
    child: Text("Added Location", style: KTextFeildTextStyle),
    ),
            SizedBox(height: 8,),
            // current location weather card detail
            CurrentWeatherCard(cityName: "Herat",
                 temp:26,
               description:"cloudy",
               maxTemp: 29,
               minTemp:18),
    SizedBox(height: 8,),
    // invisible the rest cards till the user set any location on the home page
            CurrentWeatherCard(cityName: "Herat",
                temp:26,
                description:"cloudy",
                maxTemp: 29,
                minTemp:18),
    SizedBox(height: 8,),
            CurrentWeatherCard(cityName: "Herat",
                temp:26,
                description:"cloudy",
                maxTemp: 29,
                minTemp:18),
    ],
    ),
    );
  }
}
