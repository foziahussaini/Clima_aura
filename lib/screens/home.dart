import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  LocationPermission? permission;

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  double humidity = 80; //default value
  double windSpeed = 100;
  double temp = 0;
  void getData() async {
    http.Response response = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=a11aa2a251d8621b8faa7f477d0c6405",
      ),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(
        data,
      ); // add the jsonDecode to the variable easy for changing the dataType
      var longitude = jsonDecode(data)['coord']['lon'];
      var description = jsonDecode(data)["weather"][0]["description"];
      print(longitude);

      //   using setstate to display humidity, wind speed at the screen
      setState(() {
        humidity = decodeData['main']['humidity'].toDouble();
        windSpeed = decodeData["wind"]["speed"];
        temp = decodeData["main"]["temp"];
      });
    } else {
      print(
        response.statusCode,
      ); // need to check before respone.body in order not to crash the app
    }
  }

  void getPermission() async {
    permission = await geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      print('permission denied');
      permission = await geolocatorPlatform.requestPermission();
      if (permission != LocationPermission.denied) {
        if (permission == LocationPermission.deniedForever) {
          print(
            'Permission permanently denied, please provide permission to the app from device setting',
          );
        } else {
          print('Permission granted');
          getLocation();
        }
      } else {
        print('user denied the request');
      }
    } else {
      getLocation();
    }
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.longitude);
    print(location.latitude);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    getPermission();
                  },
                  child: const Text(
                    'Location',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // weather degree
              Expanded(
                child: Text(
                  "${temp.toStringAsFixed(0)} F",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 48),
                ),
              ),
              // humidity
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.water_drop,
                      color: Colors.lightBlue[50],
                      size: 85,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "${humidity.toStringAsFixed(0)}%",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 28),
                    ),
                  ],
                ),
              ),
              // wind speed
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wind_power_outlined,
                      color: Colors.lightBlue[50],
                      size: 85,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "${windSpeed.toStringAsFixed(0)}km/h",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 28),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
