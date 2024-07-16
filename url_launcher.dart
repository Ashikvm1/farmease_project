import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: ElevatedButton(
            child: Text('Visit Website'),
            onPressed: () async {
              await launchUrl(Uri.parse('https://flutter.dev/'));
            },
          ),
        ),
      ),
    );
  }
}
