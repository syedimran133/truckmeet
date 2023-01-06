import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:truckmeet/src/events/TruckData.dart';
import 'package:truckmeet/src/events/TruckDetailsEdit.dart';

import '../events/DatabaseService.dart';
import '../events/UserData.dart';
import 'UserDetails.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<UserData> _emp = [];
  List<String> _keys = [];
  String _key = "";
  final databaseReference = FirebaseDatabase.instance.reference();
  bool _flag = true;

  @override
  void initState() {
    super.initState();
    _setupNeeds();
  }

  _setupNeeds() async {
    List<UserData> empList = await DatabaseService.getUserList();
    //List<String> eventKeys = await DatabaseService.getUserListKey();
    setState(() {
      _emp = empList;
      //_keys = eventKeys;
      //_key = _keys[0];
    });
  }

  _delete(String id) async {
    //await DatabaseService.trucksDelete(id);
/*    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TruckList(),
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Users'),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: _emp.length,
        itemBuilder: (context, int index) {
          final UserData parents = _emp[index];
          final String name = parents.name;
          final String email = parents.email;
          final String phone = parents.phone;
          final String userType = parents.userType;
          return GestureDetector(
            onTap: () {
              //_key = _keys[index];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDetails(parents)));
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xFF242526),
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 15, 0, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectionArea(
                          child: Text(
                        "Name : "+name,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                        child: SelectionArea(
                            child: Text(
                          "Email : "+email,
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,

                          ),
                        )),
                      ),
                      SelectionArea(
                          child: Text(
                        "Phone : "+phone,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      )),
                      SelectionArea(
                          child: Text(
                        "User Type : "+userType,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      )),
                    ],
                  ),
                ),
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
