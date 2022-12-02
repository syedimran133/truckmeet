import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:truckmeet/src/events/TruckData.dart';
import 'package:truckmeet/src/events/TruckDetailsEdit.dart';
import 'DatabaseService.dart';

class TruckList extends StatefulWidget {
  const TruckList({Key? key}) : super(key: key);

  @override
  State<TruckList> createState() => _TruckListState();
}

class _TruckListState extends State<TruckList> {
  List<TruckData> _emp = [];
  List<String> _keys = [];
  String _key="";
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _setupNeeds();
  }

  _setupNeeds() async {
    List<TruckData> empList = await DatabaseService.getTrucks();
    List<String> eventKeys = await DatabaseService.getTrucksKey();
    setState(() {
      _emp = empList;
      _keys=eventKeys;
      _key=_keys[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Trucks'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: _emp.length,

        itemBuilder: (context, int index) {

          final TruckData parents = _emp[index];
          final String name = parents.model;
          final String place = parents.hq;
          final String truck_transmission = parents.truck_transmission;
          final String description = parents.description;
          final String startDate = parents.tq;

          // final String parentUID = parents.uid;
          return GestureDetector(
            onTap: () {
              _key=_keys[index];
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TruckDetailsEdit(parents,_key)));
            },
            child:  Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xFF242526),
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      width: 120,
                      height: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'images/logo.jpeg',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectionArea(
                            child: Text(
                              name+"("+truck_transmission+")",
                              style:TextStyle(
                                fontFamily: 'Poppins',
                                color:Colors.white,
                              ),
                            )),
                        SelectionArea(
                            child: Text(
                              description,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        SelectionArea(
                            child: Text(
                              startDate,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            )),
                        SelectionArea(
                            child: Text(
                              place,
                              overflow: TextOverflow.fade,
                              maxLines: 4,
                              softWrap: true,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            )),
      /*                  Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: ElevatedButton(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            style: ElevatedButton.styleFrom(
                              //minimumSize: const Size.fromHeight(40),
                              backgroundColor: Color(0xFF941414),
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            child: const Text('DELETE'),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );

        },
      ),
    );
  }
}
