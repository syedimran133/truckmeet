import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:truckmeet/src/events/DatabaseService.dart';
import 'package:truckmeet/src/events/UserData.dart';
import 'package:truckmeet/src/screens/Setting.dart';

import 'MyNavigationBar.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController? textController1;
  TextEditingController? textController2;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<UserData> _user = [];
  List<String> _keys = [];
  String _key = "";

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    _setupNeeds();
    // textController1?.text=_user[0].name;
    //textController2?.text=_user[0].phone;
  }

  _setupNeeds() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    List<UserData> empList = await DatabaseService.getUseruid(uid);
    List<String> eventKeys = await DatabaseService.getUserKey();
    setState(() {
      _user = empList;
      _keys = eventKeys;
      _key = _user[0].uid;
      textController1?.text = _user[0].name;
      textController2?.text = _user[0].phone;
    });
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: TextFormField(
                    controller: textController1,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF941414),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF941414),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: TextFormField(
                    controller: textController2,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF941414),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF941414),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            });
                        final User? user = _auth.currentUser;
                        final uid = user?.uid;
                        String pathToReference = "user/$uid";
                        DatabaseReference ref2 =
                            FirebaseDatabase.instance.ref(pathToReference);
                        ref2.update({
                          "name": textController1?.text.toString(),
                          "email": _user[0].email,
                          "loginDate": _user[0].loginDate,
                          "phone": textController2?.text.toString(),
                          "userType": _user[0].userType,
                          "uid": uid,
                          "device": _user[0].device,
                          "subscribed": "No",
                        });
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("User update successfully"),
                        ));
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingWidget(),
                          ),
                        );
                      } catch (error) {
                        if (kDebugMode) {
                          print('never reached');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
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
                    child: const Text('SEND'),
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
