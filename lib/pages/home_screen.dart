import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Home Screen"),
      floatingActionButton: Container(
        height: 70,
        width: 80,
        child: FloatingActionButton(
          isExtended: true,
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('scan_screen');
          },
          child: Icon(
            Icons.camera_alt,
            size: 30,
          ),
        ),
      ),
    );
  }
}
