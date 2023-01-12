import 'package:flutter/material.dart';
import 'package:truckmeet/src/screens/splash.dart';

class App extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Truck Meets",
      theme: ThemeData(
        accentColor: Colors.black38,
        primaryColor: Colors.black,
      ),
      home: MyHomePage(),
    );
  }
}