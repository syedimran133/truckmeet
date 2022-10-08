import 'package:flutter/material.dart';

import 'MyNavigationBar.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  TextEditingController? textController1;
  TextEditingController? textController2;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
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
                    onPressed: () {
                      /*  if (_formkey.currentState.validate()) {

                      }*/
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
