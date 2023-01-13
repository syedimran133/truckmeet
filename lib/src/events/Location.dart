import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:rxdart/rxdart.dart';
import 'package:truckmeet/src/events/EventsData.dart';

import '../screens/EventDeatilsWidget.dart';
import '../screens/streambuilder_test.dart';

class LocationMarkerScreen extends StatefulWidget {
  @override
  _LocationMarkerScreenState createState() => _LocationMarkerScreenState();
}

class _LocationMarkerScreenState extends State<LocationMarkerScreen> {
  GoogleMapController? _mapController;
  TextEditingController? _latitudeController, _longitudeController;
  String googleApikey = "AIzaSyAwnbQWbsFwMekiP38kM_cujWaae2bQ1UU";
  String location = "Search Location";
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;

  // firestore init
  final radius = BehaviorSubject<double>.seeded(00.0);
  final _firestore = FirebaseFirestore.instance;
  final markers = <MarkerId, Marker>{};
  var latlong = LatLng(28.5491731, 77.2965547);
  late Stream<List<DocumentSnapshot>> stream;
  late Geoflutterfire geo;

  @override
  void initState() {
    super.initState();
    checkGps();
    _initloc();
  }

  @override
  void dispose() {
    _latitudeController?.dispose();
    _longitudeController?.dispose();
    radius.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: latlong,
                  zoom: 10.0,
                ),
                markers: Set<Marker>.of(markers.values),
              ),
              Positioned(
                //search input bar
                bottom: 10,
                child: Slider(
                  min: 1,
                  max: 200,
                  divisions: 4,
                  value: _value,
                  label: _label,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.blue.withOpacity(0.2),
                  onChanged: (double value) => changed(value),
                ),
              ),
              Positioned(
                  //search input bar
                  top: 13,
                  child: InkWell(
                      onTap: () async {
                        var place = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: googleApikey,
                            mode: Mode.overlay,
                            types: [],
                            strictbounds: false,
                            //google_map_webservice package
                            onError: (err) {
                              print(err);
                            });

                        if (place != null) {
                          //form google_maps_webservice package
                          final plist = GoogleMapsPlaces(
                            apiKey: googleApikey,
                            apiHeaders: await GoogleApiHeaders().getHeaders(),
                            //from google_api_headers package
                          );
                          String placeid = place.placeId ?? "0";
                          final detail =
                              await plist.getDetailsByPlaceId(placeid);
                          final geometry = detail.result.geometry!;
                          final lat = geometry.location.lat;
                          final lang = geometry.location.lng;
                          var newlatlang = LatLng(lat, lang);

                          setState(() {
                            location = place.description.toString();
                            latlong = newlatlang;
                            _initloc();
                          });
                          //move map camera to selected place with animation
                          _mapController?.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: newlatlang, zoom: 10)));
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width - 40,
                              child: ListTile(
                                title: Text(
                                  location,
                                  style: TextStyle(fontSize: 18),
                                ),
                                trailing: Icon(Icons.search),
                                dense: true,
                              )),
                        ),
                      )))
            ],
          ),
        ));
  }

  void _onLocChange(GoogleMapController controller) {
    setState(() {
      try {
        _mapController = controller;
//      _showHome();
        //start listening after map is created
        stream.listen((List<DocumentSnapshot> documentList) {
          _updateMarkers(documentList);
          var gata = documentList.first.data();
        });
      } catch (e) {
        print(e);
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      try {
        _mapController = controller;
//      _showHome();
        //start listening after map is created
        stream.listen((List<DocumentSnapshot> documentList) {
          _updateMarkers(documentList);
        });
      } catch (e) {
        print(e);
      }
    });
  }

  void _addMarker(double lat, double lng, EventsData data) {
    try {
      final id = MarkerId(lat.toString() + lng.toString());
      final _marker = Marker(
        markerId: id,
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        infoWindow: InfoWindow(
          title: data.name.toUpperCase(),
          snippet: data.start_date +
              " " +
              data.start_time +
              " - " +
              data.end_date +
              " " +
              data.end_time,
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDeatilsWidget(data),
              ),
            );
          },
        ),
      );
      setState(() {
        markers[id] = _marker;
      });
    } catch (e) {
      print(e);
    }
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    List<EventsData> list = [];
    try {
      documentList.forEach((DocumentSnapshot document) {
        final data = document.data() as Map<String, dynamic>;
        final GeoPoint point = data['position']['geopoint'];
        final user = EventsData.fromMap(data);
        _addMarker(point.latitude, point.longitude, user);
        list.add(user);
      });
      print(list);
    } catch (e) {
      print(e);
    }
  }

  double _value = 20.0;
  String _label = '';

  changed(value) {
    setState(() {
      _value = value;
      _label = '${_value.toInt().toString()} kms';
      markers.clear();
    });
    radius.add(value);
  }

  _initloc() {
    try {
      geo = Geoflutterfire();
      GeoFirePoint center =
          geo.point(latitude: latlong.latitude, longitude: latlong.longitude);
      stream = radius.switchMap((rad) {
        final collectionReference = _firestore.collection('events_locations');
        if (rad != 0) {
          return geo.collection(collectionRef: collectionReference).within(
              center: center, radius: rad, field: 'position', strictMode: true);
        } else {
          return geo.collection(collectionRef: collectionReference).within(
              center: center,
              radius: 20.0,
              field: 'position',
              strictMode: true);
        }
      });
      _onLocChange(_mapController!);
    } catch (e) {
      print(e);
    }
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
      if (haspermission) {
        setState(() {
          //refresh the UI
        });
        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    latlong = LatLng(position.latitude, position.longitude);
    setState(() {
      //refresh UI
      _initloc();
    });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      latlong = LatLng(position.latitude, position.longitude);

      setState(() {
        //refresh UI on update
        _initloc();
      });
    });
  }
}
