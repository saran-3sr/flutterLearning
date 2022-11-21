import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overlay_support/overlay_support.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAWPRLQKYWL0s8lkcmNm0ZYSVEI2y_-LzA",
      appId: "com.example.firebaseapp",
      messagingSenderId: "XXX",
      projectId: "fir-login-5db76",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}

class _MyHomePageState extends State<MyHomePage> {
  late final FirebaseMessaging _messaging;
  final emailcontroler = TextEditingController();
  final passwordcontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future signin() async {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailcontroler.text.trim(),
                password: passwordcontroler.text.trim())
            .then((value) => {
                  print(value.user!.email),
                  showAlertDialog(
                      context, 'Login Success', value.user!.email.toString())
                });
      } catch (e) {
        print(e);
        showAlertDialog(context, "Login Invalid", e.toString());
      }
    }

    Future signup() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailcontroler.text.trim(),
                password: passwordcontroler.text.trim())
            .then((value) => {
                  print("SignUp successfull"),
                  print(value.user!.email),
                  showAlertDialog(
                      context, 'SignUp Success', value.user!.email.toString())
                });
      } catch (e) {
        showAlertDialog(context, "SignUp invalid", e.toString());
      }
    }

    void registerNotification() async {
      _messaging = FirebaseMessaging.instance;
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );
        print(message.notification?.title);

        if (notification != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(notification!.title!),
            subtitle: Text(notification!.body!),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 2),
          );
        }
      });
    }

    registerNotification();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 40),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            TextField(
              controller: emailcontroler,
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextField(
              controller: passwordcontroler,
              decoration: InputDecoration(
                hintText: "Password",
              ),
              obscureText: true,
            ),
            Container(
                margin: EdgeInsets.only(top: 40),
                child: ElevatedButton(onPressed: signin, child: Text("Login"))),
            Container(
                margin: EdgeInsets.only(top: 40),
                child: ElevatedButton(onPressed: signup, child: Text("SignUp")))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

showAlertDialog(BuildContext context, String Content, String email) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(Content),
    content: Text(email),
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
