import 'dart:async';
import 'package:flutter/material.dart';
import 'package:truckmeet/src/screens/Login.dart';

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => Login()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child:Image.asset("images/logo.jpeg"),
    );
  }
}