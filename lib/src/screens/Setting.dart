import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:truckmeet/src/events/TruckList.dart';
import 'package:truckmeet/src/screens/AddTruckDetails.dart';
import 'package:truckmeet/src/screens/EditProfile.dart';
import 'package:truckmeet/src/screens/Login.dart';
import 'package:truckmeet/src/screens/WebViewContainer.dart';

import '../events/DatabaseService.dart';
import '../events/EmployeeListView.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String about_us = "";
  String privacy_policy = "";
  String tnc = "";

  @override
  void initState() {
    super.initState();
    _setupNeeds();
  }
  _setupNeeds() async {
    final v=await DatabaseService.getUrls();
    setState(() {
      about_us = v.about_us;
      privacy_policy = v.privacy_policy;
      tnc = v.tnc;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 1, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 30),
                  child: Text(
                    'Setting',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeListView(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Text(
                        'Events',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileWidget(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TruckList(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Text(
                        'Trucks',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTruckDetailsWidget(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Text(
                        'Add Truck Details',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              /* const Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Text(
                      'Subscription',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),*/
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WebViewContainer(about_us, "About Us"),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Text(
                        'About Us',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WebViewContainer(privacy_policy, "Privacy policy"),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Text(
                        'Privacy policy',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WebViewContainer(tnc, "Terms and Conditions"),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Text(
                        'Terms and Conditions',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () async {
                  _signOut();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                    alignment: AlignmentDirectional(0.05, 0.9),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              /*    await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupWidget(),
                                    ),
                                  );*/
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Color(0xFFFF0000),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Image.asset(
                                  'images/google.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Container(
                              width: 35,
                              height: 35,
                              constraints: BoxConstraints(
                                maxWidth: 100,
                                maxHeight: 100,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF0A66C2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'images/linkin.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color(0xFF3b5998),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 5),
                                  child: Image.asset(
                                    'images/facebook.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.1,
                                    height: 30,
                                    fit: BoxFit.fitHeight,
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                'images/twitter.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),

                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),

      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
