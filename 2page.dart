import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter username';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                if (_formKey.currentState != null) {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ABOUT'),
      ),
      body: Center(
        child: Text('This is the ABOUT page'),
      ),
    );
  }
}
