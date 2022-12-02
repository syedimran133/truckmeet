import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';

import 'EditProfile.dart';
import 'EventDeatilsWidget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String googleApikey = "AIzaSyAwnbQWbsFwMekiP38kM_cujWaae2bQ1UU";
  GoogleMapController? mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
  static const LatLng showLocation =
  const LatLng(27.7089427, 85.3086209);
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Search Location";
  LatLng sLocation = LatLng(27.6602292, 85.308027);
  LatLng endLocation = LatLng(27.6599592, 85.3102498);
  LatLng carLocation = LatLng(27.659470, 85.3077363);
  addMarkers() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "images//event.jpg",
    );

    markers.add(
        Marker( //add start location marker
          markerId: MarkerId(sLocation.toString()),
          position: sLocation, //position of marker
          infoWindow: InfoWindow( //popup info
            title: 'Starting Point ',
            snippet: 'Start Marker',
          ),
          icon: markerbitmap, //Icon for Marker
        )
    );

    markers.add(
        Marker( //add start location marker
          markerId: MarkerId(endLocation.toString()),
          position: endLocation, //position of marker
          rotation:-45,
          infoWindow: InfoWindow( //popup info
            title: 'End Point ',
            snippet: 'End Marker',
          ),
          icon: markerbitmap, //Icon for Marker
        )
    );

    String imgurl = "https://www.fluttercampus.com/img/car.png";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl))
        .load(imgurl))
        .buffer
        .asUint8List();

    markers.add(
        Marker( //add start location marker
          markerId: MarkerId(carLocation.toString()),
          position: carLocation, //position of marker
          infoWindow: InfoWindow( //popup info
            title: 'Truck Point ',
            snippet: '11 Oct 2022 (6:43 AM - 6:43 PM)',
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDeatilsWidget(),
                ),
              );
            },
          ),
          icon: BitmapDescriptor.fromBytes(bytes), //Icon for Marker
        )
    );

    setState(() {
      //refresh UI
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addMarkers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          GoogleMap(
            //Map widget from google_maps_flutter package
            zoomGesturesEnabled: true, //enable Zoom in, out on map
            initialCameraPosition: CameraPosition(
              //innital position in map
              target: startLocation, //initial position
              zoom: 14.0, //initial zoom level
            ),
            markers: markers,
            mapType: MapType.normal, //map type
            onMapCreated: (controller) {
              //method called when map is created
              setState(() {
                mapController = controller;
              });
            },
          ),

          //search autoconplete input
          Positioned(
              //search input bar
              top: 10,
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
                      final detail = await plist.getDetailsByPlaceId(placeid);
                      final geometry = detail.result.geometry!;
                      final lat = geometry.location.lat;
                      final lang = geometry.location.lng;
                      var newlatlang = LatLng(lat, lang);

                      //move map camera to selected place with animation
                      mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(
                              CameraPosition(target: newlatlang, zoom: 17)));
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
        ]));
  }

  Set<Marker> getmarkers() {

    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(showLocation.toString()),
        position: showLocation, //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Delhi Truck Meet',
          snippet: 'XYZ Truck Meet',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add second marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(27.7099116, 85.3132343), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Truck Meet',
          snippet: 'Truck Meet',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add third marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(27.7137735, 85.315626), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'ABC Truck Meet',
          snippet: 'Truck Meet',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }
}
