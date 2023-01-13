// @dart=2.9
//import 'dart:html';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../events/DatabaseService.dart';
import '../events/EventsData.dart';
import '../events/UserData.dart';
import 'AttendeeList.dart';

class EventDeatilsWidget extends StatefulWidget {
  EventsData data;

  EventDeatilsWidget(this.data,  {Key key}) : super(key: key);

  @override
  _EventDeatilsWidgetState createState() => _EventDeatilsWidgetState();
}

class _EventDeatilsWidgetState extends State<EventDeatilsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  final reference = FirebaseDatabase.instance;
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
    id = widget.data.event_id;

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
        data3 = await DatabaseService.getHostUid(event_uid);
      } catch (e) {
        print(e);
      }
      setState(() {
        try {
          user_data = data2;
          attendee_data = data1;
          host_data = data3;
          user_name = data3[0].name;
        } catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final ref = reference.reference();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        actions: [],
        title: Text(name),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
                  child: Image.network(
                    imran_url,
                    height: MediaQuery.of(context).size.height * 0.2,
                    fit: BoxFit.cover,
                  ),
                ),
                /*         Text(
                  name.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),*/
                Text(
                  start_date +
                      " " +
                      end_date +
                      "(" +
                      start_time +
                      " - " +
                      end_time +
                      ")",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Text(
                    'Hosted By',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ),
                Text(
                  user_name + "\n" + location,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Padding(
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (attendee_data.length == 0)
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: SizedBox(
                            height: 50,
                            width: 160,
                            child: ElevatedButton(
                              onPressed: () {
                                final User user =
                                    FirebaseAuth.instance.currentUser;
                                final uid = user?.uid;
                                try {
                                  ref
                                      .child("events")
                                      .child(event_uid)
                                      .child(event_id)
                                      .child("attendee")
                                      .child(uid)
                                      .set({
                                    "name": user_data[0].name,
                                    "email": user_data[0].email,
                                    "loginDate": user_data[0].loginDate,
                                    "phone": user_data[0].phone,
                                    "userType": user_data[0].userType,
                                    "device": user_data[0].device,
                                    "uid": user_data[0].uid,
                                    "subscribed": user_data[0].subscribed,
                                  }).asStream();
                                  Navigator.pop(context);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                minimumSize: const Size.fromHeight(50),
                                textStyle: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                              child: Text('Attend'),
                            ),
                          ),
                        ),
                      if (attendee_data.length != 0)
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: SizedBox(
                            height: 50,
                            width: 160,
                            child: ElevatedButton(
                              onPressed: () {
                                final User user =
                                    FirebaseAuth.instance.currentUser;
                                final uid = user?.uid;
                                ref
                                    .child("events")
                                    .child(event_uid)
                                    .child(event_id)
                                    .child("attendee")
                                    .child(uid)
                                    .remove();
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(50),
                                textStyle: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                              child: Text('Not Attend'),
                            ),
                          ),
                        ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                        child: SizedBox(
                          height: 50,
                          width: 160,
                          child: ElevatedButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AttendeeList(event_uid, event_id),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              minimumSize: const Size.fromHeight(50),
                              textStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            child: Text('Attendee List'),
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
      ),
    );
  }
}
