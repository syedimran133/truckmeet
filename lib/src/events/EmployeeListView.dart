import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:truckmeet/src/events/EventDetailPage.dart';
import 'DatabaseService.dart';
import 'EventsData.dart';

class EmployeeListView extends StatefulWidget {
  const EmployeeListView({Key? key}) : super(key: key);

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  List<EventsData> _emp = [];
  List<String> _keys = [];
  String _key = "";
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();

    _setupNeeds();
  }

  _setupNeeds() async {
    List<EventsData> empList = await DatabaseService.getEmp();
    List<String> eventKeys = await DatabaseService.getEventKey();
    setState(() {
      _emp = empList;
      _keys = eventKeys;
      _key = _keys[0];
    });
  }

  _delete(String id) async {
    await DatabaseService.eventDelete(id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeListView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
/*    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });*/
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Events'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: _emp.length,
        itemBuilder: (context, int index) {
          final EventsData parents = _emp[index];
          final String name = parents.name;
          final String place = parents.location;
          final String description = parents.description;
          final String startDate = parents.start_date;
          final String img = parents.imran_url;
          // final String parentUID = parents.uid;
          return GestureDetector(
            onTap: () {
              _key = _keys[index];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventsDetailPage(parents, _key)));
            },
            child: Card(
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
                      child: Image.network(img, fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 0),
                            child: SelectionArea(
                                child: Text(
                              name,
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                          SelectionArea(
                              child: Text(
                            description,
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          )),
                          SelectionArea(
                              child: Text(
                            startDate,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                          SelectionArea(
                              child: Text(
                            place,
                                overflow: TextOverflow.fade,
                                softWrap: true,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                _key = _keys[index];
                                print("Button pressed ...$_key");
                                showAlertDialog(context, _key);
                              },
                              child: const Text('DELETE'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.red, // This is what you need!
                              ),
                            ),
                          ),
                        ],
                      ),
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

  showAlertDialog(BuildContext context, String key) {
    Widget okButton = TextButton(
      child: const Text("Delete"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        print("Button pressed ...$_key");
        _delete(key);
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
        //launchMissile();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text("Are you sure do you want to delete?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
