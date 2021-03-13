import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  Loading();
  @override
  _Loading createState() => _Loading();
}

class _Loading extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('loading')),
    );
  }
}
