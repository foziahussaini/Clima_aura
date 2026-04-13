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

  void getData()async{
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=a11aa2a251d8621b8faa7f477d0c6405"));
    // print(response.body);
    if(response.statusCode == 200){
      String data = response.body;
      print(data);
    }else{
      print(response.statusCode); // need to check before respone.body in order not to crash the app
    }
  }
  
  void getPermission()async{
    permission =await geolocatorPlatform.checkPermission();
    if(permission == LocationPermission.denied){
      print('permission denied');
      permission =await geolocatorPlatform.requestPermission();
      if(permission!= LocationPermission.denied){
        if(permission == LocationPermission.deniedForever){
          print('Permission permanently denied, please provide permission to the app from device setting');
        }else{
          print('Permission granted');
          getLocation();
        }
      }else{
        print('user denied the request');
      }
    }else{
      getLocation();
    }
  }

  void getLocation()async{
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
            child: const Text('Get Location', style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
