import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create PDF',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Create PDF'),
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
  @override
  Widget build(BuildContext context) {
    final textData = TextEditingController();
    void generate(String input) async {
      final pdf = pw.Document();
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(input),
            ); // Center
          })); // Page
      final output = File('/storage/emulated/0/Download');
      //final output = await getTemporaryDirectory();
      final file = File("${output.path}/pdfsave.pdf");
      //final file = File("example.pdf");
      await file.writeAsBytes(await pdf.save());
      showAlertDialog(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
         
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Padding(padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: textData,
              decoration:
                  InputDecoration(label: Text('Enter the data to generate')),
            ),),
            SizedBox(
              height: 50, // <-- SEE HERE
            ),
            ElevatedButton(
                onPressed: () {
                  generate(textData.text);
                },
                child: Text("Generate"))
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("PDF generated"),
    content: Text("Check your download folder for the pdf file"),
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
