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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  Position location = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime(0),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);

  List<Placemark> place = List.empty();
  Future getPlacemark() async {
    print("Hello checkinh");
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    setState(() {
      place = placemarks;
    });
    print(place[0].toString());
  }

  Future getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    Position x = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    setState(() {
      location = x;
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
          children: <Widget>[
            Text("Longitude : " + location.longitude.toString()),
            Text("latitude : " + location.latitude.toString()),
            Text("Altitude : " + location.altitude.toString()),
            (place.length > 0)
                ? Text(place[0].toString())
                : Text("Press Get placemark to view your location"),
            TextButton(
                onPressed: () {
                  getLocation();
                },
                child: Text("Get Location")),
            TextButton(
                onPressed: () {
                  getPlacemark();
                },
                child: Text("Get Placemark"))
          ],
        ),
      ),
    );
  }
}
