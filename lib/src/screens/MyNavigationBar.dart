// @dart=2.9
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truckmeet/src/screens/Home.dart';
import 'Addevents.dart';
import 'Dashboard.dart';
import 'Setting.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar ({Key key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar > {
  int _selectedIndex = 0;
  final widgetOptions = [
    const DashboardWidget(),
    const AddeventsWidget(),
    const SettingWidget(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      backgroundColor: Colors.black38,
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                backgroundColor: Colors.black12,
                label: ''
            ),
            BottomNavigationBarItem(
                icon: Icon(
                    Icons.add_circle,
                ),
                backgroundColor: Colors.black12,
                label: ''
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              backgroundColor: Colors.black12,
                label: ''
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
      ),
    );
  }
}