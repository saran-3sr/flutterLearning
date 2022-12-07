import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyBuk0F_kgp0QFa6RgzK8frbAiZf6AxnDSk',
          appId: 'com.example.login',
          messagingSenderId: 'xxx',
          projectId: 'loginabi-d9df2'));
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
  final email = TextEditingController();
  final password = TextEditingController();
  Future signUp() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.text, password: password.text)
        .then((value) => showAlertDialog(context, "Success", "user registered"))
        .onError((error, stackTrace) =>
            showAlertDialog(context, "Error", error.toString()));
  }

  Future signIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) => showAlertDialog(context, "Success", "user signed"))
        .onError((error, stackTrace) =>
            showAlertDialog(context, "Error", error.toString()));
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
            TextField(
              controller: email,
              decoration: InputDecoration(label: Text("Email")),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(label: Text("Password")),
            ),
            TextButton(
                onPressed: () {
                  signIn();
                },
                child: Text('Sign In')),
            TextButton(
                onPressed: () {
                  signUp();
                },
                child: Text('Register'))
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String Title, String Body) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Title),
      content: Text(Body),
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
