import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
@override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
    title: Text('Sobre la aplicacion:'),
    ),
    body: Center(
      child: Text(
      'Homero Dou',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );
  }
}