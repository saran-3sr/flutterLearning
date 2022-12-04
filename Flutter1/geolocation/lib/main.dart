import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocation_3sr',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MyHomePage(title: 'Location'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Position location = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime(0),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);
  Placemark place = Placemark();

  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    setState(() {
      location = position;
      getAddress();
    });
    print(location.latitude);
    
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  getAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        76.1223, 117.8928,
        localeIdentifier: "en_US");
    print(placemarks[0]);
    setState(() {
      place = placemarks[0];
      location=location[0];
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: OutlinedButton(
                      child: Text("Get Location",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red)),
                      onPressed: getLocation)),
              SizedBox(height: 30),
              Container(
                child: Text('Longitude :' + location.longitude.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Text('Latitude :' + location.latitude.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Altitude :' + location.altitude.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('location :' + place.locality.toString())
            ]),
      ),
    );
  }
}
