import 'package:clima_aura/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../components/loading_widget.dart';
import '../components/setting_icon.dart';
import '../services/location.dart';
import '../utilities/constants.dart';
import 'manage_city.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool? isDataLoaded = false;
  double? latitude, longitude;
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
    longitude = location.longitude;
    latitude = location.latitude;
    NetworkHelper networkHelper = NetworkHelper(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey");
    var weatherData = await networkHelper.getData();
    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isDataLoaded!) {
      return loadingWidget();
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title: Row(crossAxisAlignment: CrossAxisAlignment.end,
              children: [
              Setting_icon(icon: Icons.add,
              onPressed: () {
                  Navigator.pushNamed(context, "/ManageCity");
              }),
          Setting_icon(icon: Icons.settings_sharp,
              onPressed: () {
                Navigator.pushNamed(context, "/Setting");
              }),]
        ),
      ),
    body: SafeArea(
    child: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
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
    ),),);
  }
  }
}


// var decodeData = jsonDecode(data,); // add the jsonDecode to the variable easy for changing the dataType
// var longitude = jsonDecode(data)['coord']['lon'];
// var description = jsonDecode(data)["weather"][0]["description"];