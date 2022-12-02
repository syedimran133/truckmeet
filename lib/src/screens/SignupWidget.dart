// @dart=2.9
import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:truckmeet/src/Utils/AuthenticationHelper.dart';
import 'package:truckmeet/src/screens/Login.dart';
import 'package:firebase_database/firebase_database.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({Key key}) : super(key: key);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  String _email, _password;
  final reference = FirebaseDatabase.instance;
  TextEditingController tc_name;
  TextEditingController tc_email;
  TextEditingController tc_phone;
  TextEditingController tc_password;
  TextEditingController tc_confirm_pass;

  //final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    tc_name = TextEditingController();
    tc_email = TextEditingController();
    tc_phone = TextEditingController();
    tc_password = TextEditingController();
    tc_confirm_pass = TextEditingController();
  }

  Future signUp({String email,String password}) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pop();
      return null;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ref = reference.reference();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Form(
        key: _formkey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(13, 0, 13, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: InkWell(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
                              },
                              child: Image.asset(
                                'images/back.png',
                                height: MediaQuery.of(context).size.height * 0.04,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Text(
                              'Welcome',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Text(
                            'Sign up now!',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Image.asset(
                          'images/logo.jpeg',
                          width: MediaQuery.of(context).size.width * 0.8,
                          //height: MediaQuery.of(context).size.height * 0.2,
                          fit: BoxFit.fill,
                        ),
                        TextFormField(
                          controller: tc_name,
                          autofocus: true,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Name should be valid';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Full Name',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextFormField(
                          controller: tc_email,
                          autofocus: true,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (!EmailValidator.validate(value, true) ||
                                value.isEmpty) {
                              return 'Email should be valid';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextFormField(
                          controller: tc_phone,
                          autofocus: true,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Phone should be valid';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextFormField(
                          controller: tc_password,
                          autofocus: true,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password should be valid';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextFormField(
                          controller: tc_confirm_pass,
                          autofocus: true,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password should be valid';
                            }
                            if (value != _password) {
                              return 'Password should not be match';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState.validate()) {
                                FocusManager.instance.primaryFocus.unfocus();
                                var now = new DateTime.now();
                                var formatter =
                                    new DateFormat('yyyy-MM-dd – kk:mm');
                                final User user = _auth.currentUser;
                                final uid = user.uid;
                                String formattedDate = formatter.format(now);
                                signUp(
                                        email: _email.trim(),
                                        password: _password)
                                    .then((value) => {
                                          if (value == null)
                                            {
                                              ref.child("user").child(uid).push().set({
                                                "name": tc_name?.value.text,
                                                "email": _email,
                                                "loginDate": formattedDate,
                                                "phone": tc_phone?.value.text,
                                                "userType": "user",
                                                "device": "Android",
                                                "uid": uid,
                                                "subscribed": "No",
                                              }).asStream(),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "User register successfully"),
                                              )),
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login())),
                                            }
                                          else
                                            {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(value),
                                              )),
                                            }
                                        });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              minimumSize: const Size.fromHeight(50),
                              textStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            child: const Text('SEND'),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'By clicking you agree with our Terms of\n Usage and Privacy Policy',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
