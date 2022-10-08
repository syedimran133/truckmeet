// @dart=2.9
import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truckmeet/src/Utils/AuthenticationHelper.dart';
import 'package:truckmeet/src/screens/Login.dart';

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({Key key}) : super(key: key);

  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  TextEditingController textController;
  String _email;

  //final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  Future reset({String email}) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      await _auth.sendPasswordResetEmail(
        email: email,
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(13, 0, 13, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Text(
                            'Forgot Password',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            'Please Enter your email address. you wil\nreceive a link to create a new password\nvia email.',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        'images/logo.jpeg',
                        height: MediaQuery.of(context).size.height * 0.2,
                        fit: BoxFit.fill,
                      ),
                      TextFormField(
                        controller: textController,
                        autofocus: true,
                        obscureText: false,
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        validator: (value) {
                          if (!EmailValidator.validate(value, true) || value.isEmpty) {
                            return 'Email should be valid';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFFF0000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFFF0000),
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
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              FocusManager.instance.primaryFocus.unfocus();
                              reset(email: _email)
                                  .then((result) {
                                if (result == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Reset Password email send"),
                                  ));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(result),
                                  ));
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
