// @dart=2.9
//import 'dart:html';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:path/path.dart';

import 'EmployeeListView.dart';
import 'EventsData.dart';

class EventsDetailPage extends StatefulWidget {

  EventsData model;
  String e_key;
  EventsDetailPage(this.model,this.e_key, {Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<EventsDetailPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Geoflutterfire geo = Geoflutterfire();
  GeoFirePoint myLocation;
  final reference = FirebaseDatabase.instance;
  bool servicestatus = false;
  bool haspermission = false;
  LocationPermission permission;
  Position position;
  String long = "", lat = "";
  StreamSubscription<Position> positionStream;
  FirebaseStorage storage = FirebaseStorage.instance;
  String dropDownValue1;
  String dropDownValue2;
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  bool switchListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String name = "";
  String decs = "";
  String newValue = "Meet";
  String id = "";

  String value2 = "I am the Host";
  String start_date = "Start Date";
  String start_time = "Start Time";
  String end_date = "End Date";
  String end_time = "End Time";
  TimeOfDay selectedTime = TimeOfDay.now();
  String googleApikey = "AIzaSyAwnbQWbsFwMekiP38kM_cujWaae2bQ1UU";
  GoogleMapController mapController; //contrller for Google map
  CameraPosition cameraPosition;
  LatLng newlatlang = LatLng(27.6602292, 85.308027);
  String location = "Location";
  File _image = File('images/upload.png'), image;
  String _uploadedFileURL;
  bool isLoading = false;
  bool isUploaded = false;
  get e_key => this.e_key;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    newValue = widget.model.meet_type.toString();
    value2 = widget.model.event_type.toString();
    start_date =widget.model.start_date.toString();
    start_time = widget.model.start_time.toString();
    end_date = widget.model.end_date.toString();
    end_time = widget.model.end_time.toString();
    location = widget.model.location.toString();
    name = widget.model.name.toString();
    decs = widget.model.description.toString();
    textController1.text=name;
    textController2.text=decs;
    newlatlang = LatLng(widget.model.Latitude, widget.model.Longitude);
    switchListTileValue=widget.model.allday;
    _uploadedFileURL = widget.model.imran_url.toString();
    id=widget.e_key;
  }
  Future chooseFile() async {
    image = File(await ImagePicker()
        .getImage(source: ImageSource.gallery)
        .then((pickedFile) => pickedFile.path));
    setState(() {
      _image = image;
      uploadFile();
    });
  }

  Future uploadFile() async {
    setState(() {
      isLoading = true;
    });
    final fileName = basename(_image.path);
    final destination = 'images/$fileName';
    try {
      final ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(_image);
      String url = await ref.getDownloadURL();
      setState(() {
        isLoading = false;
        _uploadedFileURL = url;
        print(_uploadedFileURL);
        isUploaded = true;
      });
    } catch (e) {
      print('error occured');
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Edit Event'),
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: _formkey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (isUploaded)
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: InkWell(
                          onTap: chooseFile,
                          child: Image.file(
                            _image,
                            //width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.15,
                            fit: BoxFit.fill,
                          ),
                        )),
                  ),
                if (!isUploaded)
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: InkWell(
                          onTap:chooseFile,
                          child: Image.network(
                            _uploadedFileURL,
                            height: MediaQuery.of(context).size.height * 0.15,
                            fit: BoxFit.fill,
                          ),
                        )),
                  ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //background color of dropdown button dropdown button
                            borderRadius: BorderRadius.circular(8),
                            //border raiuds of dropdown button
                            boxShadow: const <BoxShadow>[
                              //apply shadow on Dropdown button
                              BoxShadow(
                                  color: Colors.white, //shadow for button
                                  blurRadius: 5)
                              //blur radius of shadow
                            ]),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 30),
                            child: DropdownButton(
                              value: newValue,
                              items: const [
                                //add items in the dropdown
                                DropdownMenuItem(
                                  value: "Meet",
                                  child: Text("Meet"),
                                ),
                                DropdownMenuItem(
                                    value: "Drive", child: Text("Drive")),
                                DropdownMenuItem(
                                  value: "Show",
                                  child: Text("Show"),
                                ),
                                DropdownMenuItem(
                                  value: "Rally",
                                  child: Text("Rally"),
                                ),
                                DropdownMenuItem(
                                  value: "Trackday",
                                  child: Text("Trackday"),
                                )
                              ],
                              onChanged: (String changedValue) {
                                newValue = changedValue;
                                setState(() {
                                  newValue;
                                  if (kDebugMode) {
                                    print(newValue);
                                  }
                                });
                              },
                              icon: const Padding(
                                //Icon at tail, arrow bottom is default icon
                                  padding: EdgeInsets.only(left: 20),
                                  child: Icon(Icons.arrow_drop_down)),
                              iconEnabledColor: Colors.black,
                              //Icon color
                              style: const TextStyle(
                                //te
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16.0,
                              ),

                              dropdownColor: Colors.white,
                              //dropdown background color
                              underline: Container(),
                              //remove underline
                              isExpanded: true, //make true to make width 100%
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //background color of dropdown button dropdown button
                            borderRadius: BorderRadius.circular(8),
                            //border raiuds of dropdown button
                            boxShadow: const <BoxShadow>[
                              //apply shadow on Dropdown button
                              BoxShadow(
                                  color: Colors.white, //shadow for button
                                  blurRadius: 5)
                              //blur radius of shadow
                            ]),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 30),
                            child: DropdownButton(
                              value: value2,
                              items: const [
                                //add items in the dropdown
                                DropdownMenuItem(
                                  value: "I am the Host",
                                  child: Text("I am the Host"),
                                ),
                                DropdownMenuItem(
                                    value: "Reposted Events",
                                    child: Text("Reposted Events"))
                              ],
                              onChanged: (String changedValue) {
                                value2 = changedValue;
                                setState(() {
                                  value2;
                                  if (kDebugMode) {
                                    print(value2);
                                  }
                                });
                              },
                              icon: const Padding(
                                //Icon at tail, arrow bottom is default icon
                                  padding: EdgeInsets.only(left: 20),
                                  child: Icon(Icons.arrow_drop_down)),
                              iconEnabledColor: Colors.black,
                              //Icon color
                              style: const TextStyle(
                                //te
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16.0,
                              ),

                              dropdownColor: Colors.white,
                              //dropdown background color
                              underline: Container(),
                              //remove underline
                              isExpanded: true, //make true to make width 100%
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
                  child: TextFormField(

                    controller: textController1,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF941414),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF941414),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
                  child: TextFormField(
                    controller: textController2,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF941414),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF941414),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                Positioned(
                    child: InkWell(
                        onTap: () async {
                          var place = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: googleApikey,
                              mode: Mode.overlay,
                              types: [],
                              strictbounds: false,
                              //components: [Component(Component.country, 'np')],
                              //google_map_webservice package
                              onError: (err) {
                                print(err);
                              });

                          if (place != null) {
                            setState(() {
                              location = place.description.toString();
                            });

                            //form google_maps_webservice package
                            final plist = GoogleMapsPlaces(
                              apiKey: googleApikey,
                              apiHeaders: await GoogleApiHeaders().getHeaders(),
                              //from google_api_headers package
                            );
                            String placeid = place.placeId ?? "0";
                            final detail =
                            await plist.getDetailsByPlaceId(placeid);
                            final geometry = detail.result.geometry;
                            final lat = geometry.location.lat;
                            final lang = geometry.location.lng;
                            newlatlang = LatLng(lat, lang);
                            myLocation =
                                geo.point(latitude: lat, longitude: lang);
                            //move map camera to selected place with animation
                            mapController?.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: newlatlang, zoom: 17)));
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 23, 0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                                width: double.infinity,
                                child: ListTile(
                                  title: Text(
                                    location,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15.0),
                                  ),
                                  dense: true,
                                )),
                          ),
                        ))),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SwitchListTile(
                      value: switchListTileValue ??= true,
                      onChanged: (newValue) =>
                          setState(() => switchListTileValue = newValue),
                      title: const Text(
                        'All day',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      tileColor: Colors.black,
                      activeColor: Colors.white,
                      dense: false,
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 25, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: SizedBox(
                          height: 50,
                          width: 160,
                          child: ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              textController1.clear();
                              textController2.clear();
                              textController3.clear();
                              DateTime pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                if (kDebugMode) {
                                  print(pickedDate);
                                } //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                                if (kDebugMode) {
                                  print(formattedDate);
                                } //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  start_date = formattedDate;
                                });
                              } else {}
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
                            child: Text(start_date),
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
                            onPressed: () {
                              _selectTime(context);
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
                            child: Text(start_time),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: SizedBox(
                          height: 50,
                          width: 160,
                          child: ElevatedButton(
                            onPressed: () async {
                              DateTime pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                if (kDebugMode) {
                                  print(pickedDate);
                                } //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                                if (kDebugMode) {
                                  print(formattedDate);
                                } //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  end_date = formattedDate;
                                });
                              } else {}
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
                            child: Text(end_date),
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
                            onPressed: () {
                              _selectTime2(context);
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
                            child: Text(end_time),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(25, 30, 25, 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      /*  if (_formkey.currentState.validate()) {

                      }*/
                      try {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(child: CircularProgressIndicator());
                            });
                        final User user = _auth.currentUser;
                        final uid = user.uid;
                        String pathToReference = "events/$uid/$id";
                        GeoFirePoint point = geo.point(latitude: newlatlang.latitude, longitude: newlatlang.longitude);
                        DatabaseReference ref2 = FirebaseDatabase.instance.ref(pathToReference);
                        ref2.update({
                          "meet_type": newValue,
                          "event_type": value2,
                          "Longitude": newlatlang.longitude,
                          "Latitude": newlatlang.latitude,
                          "name": textController1.value.text,
                          "description": textController2.value.text,
                          "location": location,
                          "allday": switchListTileValue,
                          "start_date": start_date,
                          "start_time": start_time,
                          "end_date": end_date,
                          "end_time": end_time,
                          "imran_url": _uploadedFileURL,
                        });
                        FirebaseFirestore ref3 = FirebaseFirestore.instance;
                        ref3.collection("events_locations").doc(id).update({
                          "uid":uid,
                          "event_id":id,
                          "meet_type": newValue,
                          "event_type": value2,
                          "Longitude": newlatlang.longitude,
                          "Latitude": newlatlang.latitude,
                          "name": textController1.value.text,
                          "description": textController2.value.text,
                          "location": location,
                          "allday": switchListTileValue,
                          "start_date": start_date,
                          "start_time": start_time,
                          "end_date": end_date,
                          "end_time": end_time,
                          "position":point.data,
                          "imran_url": _uploadedFileURL,
                        }

                        );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              "User register successfully"),
                        ));
                        await Navigator.push(
                          context,
                          MaterialPageRoute(

                            builder: (context) => EmployeeListView(),
                          ),
                        );
                      } catch (error) {
                        if (kDebugMode) {
                          print('never reached');
                        }
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
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    child: const Text('UPDATE'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        start_time = formatTimeOfDay(selectedTime);
      });
    }
  }

  _selectTime2(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        end_time = formatTimeOfDay(selectedTime);
      });
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

/*  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'A bad guy',
              'description': 'Some description...'
            }));

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }*/

  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata['uploaded_by'] ?? 'Nobody',
        "description":
        fileMeta.customMetadata['description'] ?? 'No description'
      });
    });
    return files;
  }
}