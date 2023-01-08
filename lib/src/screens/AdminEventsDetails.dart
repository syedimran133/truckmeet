// @dart=2.9
//import 'dart:html';
import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../events/DatabaseService.dart';
import '../events/EventsData.dart';
import '../events/UserData.dart';

class AdminEventsDetails extends StatefulWidget {
  EventsData data;

  AdminEventsDetails(this.data, {Key key}) : super(key: key);

  @override
  _AdminEventsDetailsState createState() => _AdminEventsDetailsState();
}

class _AdminEventsDetailsState extends State<AdminEventsDetails> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  double Latitude = 0.0;
  double Longitude = 0.0;
  bool allday = false;
  String description = "";
  String end_date = "";
  String end_time = "";
  String event_type = "";
  String imran_url = "";
  String location = "";
  String meet_type = "";
  String name = "";
  String start_date = "";
  String start_time = "", id = "";
  String event_uid = "";
  String event_id = "";
  List<UserData> user_data = [];
  List<UserData> host_data = [];
  List<UserData> attendee_data = [];
  String user_name = "";

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    Latitude = widget.data.Latitude;
    Longitude = widget.data.Longitude;
    allday = widget.data.allday;
    description = widget.data.description;
    end_date = widget.data.end_date;
    end_time = widget.data.end_time;
    event_type = widget.data.event_type;
    imran_url = widget.data.imran_url;
    location = widget.data.location;
    meet_type = widget.data.meet_type;
    name = widget.data.name;
    start_time = widget.data.start_time;
    event_uid = widget.data.uid;
    event_id = widget.data.event_id;

    _markers.add(Marker(
      // given marker id
      markerId: MarkerId("0"),
      // given marker icon
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      // given position
      position: LatLng(Latitude, Longitude),
      infoWindow: InfoWindow(
        // given title for marker
        title: name,
        snippet: description,
        onTap: () async {},
      ),
    ));
    _setupNeeds();
  }

  _setupNeeds() async {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    List<UserData> data2 = [], data1 = [], data3 = [];
    try {
      data1 = await DatabaseService.getAttendee(event_uid, event_id, uid);
    } catch (e) {
      print(e);
    }
    try {
      data2 = await DatabaseService.getUseruid(uid);
    } catch (e) {
      print(e);
    }
    try {
      data3 = await DatabaseService.getUseruid(event_uid);
    } catch (e) {
      print(e);
    }
    setState(() {
      user_data = data2;
      user_name = data3[0].name;
      host_data = data3;
      attendee_data = data1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: const Text("Event Details"),
        actions: [],
        elevation: 4,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 13, 0, 13),
                  child: Image.network(
                    imran_url,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 20, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                         
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Title',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                         
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Meet Type',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  meet_type,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                         
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                              const Expanded(
                                child: Text(
                                  'Event Type',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  event_type,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                         
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {},
                                  child: const Text(
                                    'Description',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  description,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                         
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {},
                                  child: const Text(
                                    'Hosted By',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  user_name,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                         
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {},
                                  child: const Text(
                                    'Location',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  location,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                         
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Date',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  start_date+" "+end_date+"("+start_time+" - "+end_time+")",
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        width: mediaQuery.size.width - 30,
                        height: mediaQuery.size.height * (1 / 4.5),
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(Latitude, Longitude),
                            zoom: 17.0,
                          ),
                          markers: Set<Marker>.of(_markers),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
