import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  //function goes here
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future signup() async {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) => {
                showAlertDialog(
                    context, "Welcome On Board", 'Registration Success')
              })
          .onError((error, stackTrace) =>
              showAlertDialog(context, 'Ooops Error', error.toString()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Register Practise"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: email,
              decoration:
                  InputDecoration(label: Text('Enter Email or Username')),
            ),
            SizedBox(
              width: 25,
              height: 25,
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                  label: Text('Enter Password'), border: OutlineInputBorder()),
            ),
            TextButton(
                onPressed: () {
                  signup();
                },
                child: Text('Register')),
            Text("Already Have a Account"),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Login"))
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
