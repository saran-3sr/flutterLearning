import 'package:flutter/material.dart';
import './register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyD11_MbHeCgE5gKD8xAD8dSn0tnEtkkHLY',
          appId: 'com.example.practiselogin',
          messagingSenderId: '',
          projectId: 'practiseflutterlogin'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoginApp',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Login Practice'),
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
  //function goes here
  final email = TextEditingController();
  final password = TextEditingController();
  Future SignIn() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim())
        .then((value) => {
              showAlertDialog(
                  context, 'Hurray Login Success', value.user!.email.toString())
            })
        .onError((error, stackTrace) =>
            {showAlertDialog(context, "Oops Error!", error.toString())});
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
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter your Mail or Username"),
              ),
            ),
            SizedBox(
              width: 25,
              height: 25,
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      label: Text('Enter Password'),
                      border: OutlineInputBorder()),
                )),
            TextButton(
                onPressed: () {
                  SignIn();
                },
                child: Text('Login')),
            Text("New to WT-LAB?"),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Text("Register"))
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String title, String sentence) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(sentence),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
