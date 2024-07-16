import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _phone = '';

  final Uri appUri = Uri.parse('https://play.google.com/store/apps/details?id=com.truecaller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          TextField(
            onChanged: (text) => _phone = text,
            decoration: const InputDecoration(
              hintText: 'Enter phone number',
            ), // InputDecoration
          ), // TextField
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              final uri = Uri(scheme: 'tel', path: _phone);
              if (await canLaunchUrl(uri)) {
                launchUrl(uri);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Could not launch $uri'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: const Text('Make phone call'),
          ), // ElevatedButton
          const SizedBox(height: 46),
          ElevatedButton(
            onPressed: () async {
              if (await canLaunch(appUri.toString())) {
                launch(appUri.toString());
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Could not launch app'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: const Text('Open App'),
          ), // ElevatedButton
        ],
      ),
    );
  }
}
