// @dart=2.9
import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truckmeet/src/Utils/AuthenticationHelper.dart';
import 'package:truckmeet/src/screens/Login.dart';
import 'package:firebase_database/firebase_database.dart';

import '../events/UserData.dart';

class UserDetails extends StatefulWidget {
  UserData model;
  UserDetails(this.model,{Key key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String device;
  String email;
  String loginDate;
  String name;
  String phone;
  String subscribed;
  String uid;
  String userType;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    device= widget.model.device.toString();
    email= widget.model.email.toString();
    loginDate= widget.model.loginDate.toString();
    name= widget.model.name.toString();
    phone= widget.model.phone.toString();
    subscribed= widget.model.subscribed.toString();
    uid= widget.model.uid.toString();
    userType= widget.model.userType.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Users Details'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Form(
        key: _formkey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                 height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(13, 0, 13, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/logo.jpeg',
                          width: MediaQuery.of(context).size.width * 0.8,
                          //height: MediaQuery.of(context).size.height * 0.2,
                          fit: BoxFit.fill,
                        ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(13, 10, 0, 0),
                      child: Text(
                          "Name : "+name,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                      child: Text(
                          "Phone : "+phone,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                      child: Text(
                          "Email : "+email,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                      child: Text(
                          "UID : "+uid,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                      child: Text(
                          "User Type : "+userType,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                      child: Text(
                          "Device : "+device,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                      child: Text(
                          "Subscribed : "+subscribed,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                      child: Text(
                          "Login Date : "+loginDate,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
