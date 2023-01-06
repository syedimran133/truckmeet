// @dart=2.9
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truckmeet/src/screens/Home.dart';
import 'package:truckmeet/src/screens/SettingAdmin.dart';
import 'Addevents.dart';
import 'Dashboard.dart';
import 'EventListAdmin.dart';
import 'Setting.dart';
import 'UserList.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key key}) : super(key: key);
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  int _selectedIndex = 0;
  final widgetOptions = [
    UserList(),
    EventListAdmin(),
    SettingAdmin(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup, //call function on back button press
        child: Scaffold(
          body: Center(
            child: widgetOptions.elementAt(_selectedIndex),
          ),
          backgroundColor: Colors.black38,
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.supervised_user_circle, color: Colors.white), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.event, color: Colors.white), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings, color: Colors.white), label: ''),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.grey,
            backgroundColor: Colors.black,
            iconSize: 40,
            onTap: _onItemTapped,
          ),
        ));
  }
}
