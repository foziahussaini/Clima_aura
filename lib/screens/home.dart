import 'package:clima_aura/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../components/loading_widget.dart';
import '../components/menu_Icons.dart';
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
          title: Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MenuIcons(icon: Icons.add,
                    onPressed: () {
                      Navigator.pushNamed(context, "/ManageCity");
                    }),
                SizedBox(width: 8),
                MenuIcons(icon: Icons.settings_sharp,
                    onPressed: () {
                      Navigator.pushNamed(context, "/Setting");
                    }),
              ]
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Herat"),
                        Text("25"),
                        Row(children: [
                          Text("Clear"),
                          Text("29/14")
                        ],)
                  ]
                      ),
                Expanded(child: ReuseableCard()),
                Expanded(child: ReuseableCard()),
                Expanded(child: Row(
                  children: [
                    ReuseableCard(),
                    ReuseableCard()
                  ],
                )),
                Expanded(child: Row(
                  children: [
                    ReuseableCard(),
                    ReuseableCard()
                  ],),),
              ],
            ),


          ),),);
    }
  }
}

class ReuseableCard extends StatelessWidget {
  const ReuseableCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0XFFBAD1F1).withOpacity(0.5)
      ),
    );
  }
}


// var decodeData = jsonDecode(data,); // add the jsonDecode to the variable easy for changing the dataType
// var longitude = jsonDecode(data)['coord']['lon'];
// var description = jsonDecode(data)["weather"][0]["description"];