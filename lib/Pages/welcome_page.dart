
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({ Key key }) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bem Vindo'),
          centerTitle: true,
        ),
    );
  }
}
