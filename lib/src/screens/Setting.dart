import 'package:flutter/material.dart';
import 'package:truckmeet/src/screens/AddTruckDetails.dart';
import 'package:truckmeet/src/screens/EditProfile.dart';
import 'package:truckmeet/src/screens/Login.dart';
import 'package:truckmeet/src/screens/WebViewContainer.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileWidget(),
                          ),
                        );
                      },
                      child: const Text(
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
                const Divider(
                  color: Colors.grey,
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTruckDetailsWidget(),
                          ),
                        );
                      },
                      child: const Text(
                        'Add Trucek Details',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                const Align(
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
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WebViewContainer("https://fltruckmeet.com/","About Us"),
                          ),
                        );
                      },
                      child: const Text(
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
                const Divider(
                  color: Colors.grey,
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewContainer(
                                "https://policies.google.com/privacy?hl=en-US","Privacy policy"),
                          ),
                        );
                      },
                      child: const Text(
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
                const Divider(
                  color: Colors.grey,
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewContainer(
                                "https://trucksuvidha.com/TermsAndConditions.aspx","Terms and Conditions"),
                          ),
                        );
                      },
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
                Divider(
                  color: Colors.grey,
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        ),
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
