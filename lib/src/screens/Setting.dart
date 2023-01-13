import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:truckmeet/src/events/TruckList.dart';
import 'package:truckmeet/src/screens/AddTruckDetails.dart';
import 'package:truckmeet/src/screens/EditProfile.dart';
import 'package:truckmeet/src/screens/Login.dart';
import 'package:truckmeet/src/screens/WebViewContainer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
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

  String facebook_native = "";
  String facebook_web = "";
  String google_native = "";
  String google_web = "";
  String insta_native = "";
  String insta_web = "";
  String twitter_native = "";
  String twitter_web = "";

  @override
  void initState() {
    super.initState();
    _setupNeeds();
  }

  _launchApp(String webUrl, String nativeUrl) async {
    try {
      await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      print(e);
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    }
  }

  _setupNeeds() async {
    final v1 = await DatabaseService.getUrls();
    final v2 = await DatabaseService.getR_Urls();
    setState(() {
      about_us = v1.about_us;
      privacy_policy = v1.privacy_policy;
      tnc = v1.tnc;

      facebook_native = v2.facebook_native;
      facebook_web = v2.facebook_web;
      google_native = v2.google_native;
      google_web = v2.google_web;
      insta_native = v2.insta_native;
      insta_web = v2.insta_web;
      twitter_native = v2.twitter_native;
      twitter_web = v2.twitter_web;
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
                  height: 45,
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
                  height: 45,
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
                  height: 45,
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
                  height: 45,
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
                  height: 45,
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
                  height: 45,
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
                  height: 45,
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
                  height: 45,
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
                            onTap: () {
                              _launchApp(insta_web, insta_native);
                            },
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
                            child: InkWell(
                              onTap: () {
                                _launchApp(google_web, google_native);
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
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: InkWell(
                              onTap: () {
                                _launchApp(facebook_web, facebook_native);
                              },
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
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: InkWell(
                              onTap: () {
                                _launchApp(twitter_web, twitter_native);
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1DA1F2),
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
