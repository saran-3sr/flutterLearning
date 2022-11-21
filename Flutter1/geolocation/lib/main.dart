import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green
      ),
      home: const MyHomePage(title: 'Location'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Position location=Position(
    longitude:0,
    latitude:0,
    timestamp:DateTime(0),
    accuracy:0,
    altitude:0,
    heading:0,
    speed:0,
    speedAccuracy:0);
  
  void getLocation() async{
    
      LocationPermission permission = await Geolocator.requestPermission();
      Position position=await Geolocator.getCurrentPosition(
      desiredAccuracy:LocationAccuracy.low);
      setState((){
        location=position;
      });
      print(location.latitude);
    
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget>[
            Container(
              child:OutlinedButton(
                child:Text("Get Location",style:TextStyle(fontWeight:FontWeight.bold,color:Colors.red)),
                onPressed:getLocation
            )
            ),
            SizedBox(
              height:30
            ),
            Container(
              child:Text('Longitude :'+location.longitude.toString(),style:TextStyle(fontWeight:FontWeight.bold)),
            ),
            Text('Latitude :'+location.latitude.toString(),style:TextStyle(fontWeight:FontWeight.bold)),
            Text('Altitude :'+location.altitude.toString(),style:TextStyle(fontWeight:FontWeight.bold)),

            
          ]     
          
        ),
      ),
      );
  }
}
