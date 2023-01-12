// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:truckmeet/src/events/TruckData.dart';
import 'package:truckmeet/src/events/TruckList.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:path/path.dart';

class TruckDetailsEdit extends StatefulWidget {
  TruckData model;
  String e_key;

  TruckDetailsEdit(this.model, this.e_key, {Key key}) : super(key: key);

  @override
  _TruckDetailsEditState createState() => _TruckDetailsEditState();
}

class _TruckDetailsEditState extends State<TruckDetailsEdit> {
  TextEditingController textController1;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final reference = FirebaseDatabase.instance;
  String dropDownValue1;
  String dropDownValue2;
  String id = "";
  TextEditingController textController2;
  TextEditingController textController3;
  TextEditingController textController4;

  String newValue = "Currently Owned";
  String newValue1 = "Automatic";
  File _image = File('images/upload.png'), image;
  String _uploadedFileURL;
  bool isLoading = false;
  bool isUploaded = false;

  //final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();

    newValue = widget.model.ownership_status.toString();
    newValue1 = widget.model.truck_transmission.toString();
    _uploadedFileURL = widget.model.imran_url.toString();
    textController1.text = widget.model.model.toString();
    textController2.text = widget.model.hq.toString();
    textController3.text = widget.model.tq.toString();
    textController4.text = widget.model.description.toString();
    id = widget.e_key;
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
    final ref = reference.ref();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
        title: Text('Edit Truck'),
      ),
      backgroundColor: Colors.black,
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (isUploaded)
                    Column(
                      children: <Widget>[
                        _image != null
                            ? isLoading
                                ? CircularProgressIndicator()
                                : Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 0),
                                        child: InkWell(
                                          onTap: chooseFile,
                                          child: Image.file(
                                            _image,
                                            //width: MediaQuery.of(context).size.width * 0.8,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                  )
                            : Column()
                      ],
                    ),
                  if (!isUploaded)
                    Column(
                      children: <Widget>[
                        _image != null
                            ? isLoading
                                ? CircularProgressIndicator()
                                : Align(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 0),
                                        child: InkWell(
                                          onTap: chooseFile,
                                          child: Image.network(
                                            _uploadedFileURL,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.15,
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                  )
                            : Column()
                      ],
                    ),
                  Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
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
                              padding: EdgeInsets.only(left: 10, right: 30),
                              child: DropdownButton(
                                value: newValue,
                                items: const [
                                  //add items in the dropdown
                                  DropdownMenuItem(
                                    child: Text("Currently Owned"),
                                    value: "Currently Owned",
                                  ),
                                  DropdownMenuItem(
                                      child: Text("For Sale"),
                                      value: "For Sale"),
                                  DropdownMenuItem(
                                    child: Text("Previously Owned"),
                                    value: "Previously Owned",
                                  )
                                ],
                                onChanged: (String changedValue) {
                                  newValue = changedValue;
                                  setState(() {
                                    newValue;
                                    print(newValue);
                                  });
                                },
                                icon: Padding(
                                    //Icon at tail, arrow bottom is default icon
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(Icons.arrow_drop_down)),
                                iconEnabledColor: Colors.black,
                                //Icon color
                                style: TextStyle(
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
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
                            padding: EdgeInsets.only(left: 10, right: 30),
                            child: DropdownButton(
                              value: newValue1,
                              items: const [
                                //add items in the dropdown
                                DropdownMenuItem(
                                  child: Text("Manual"),
                                  value: "Manual",
                                ),
                                DropdownMenuItem(
                                    child: Text("Automatic"),
                                    value: "Automatic"),
                                DropdownMenuItem(
                                  child: Text("Other"),
                                  value: "Other",
                                )
                              ],
                              onChanged: (String changedValue) {
                                newValue1 = changedValue;
                                setState(() {
                                  newValue1;
                                  print(newValue1);
                                });
                              },
                              icon: Padding(
                                  //Icon at tail, arrow bottom is default icon
                                  padding: EdgeInsets.only(left: 20),
                                  child: Icon(Icons.arrow_drop_down)),
                              iconEnabledColor: Colors.black,
                              //Icon color
                              style: TextStyle(
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                    child: TextFormField(
                      controller: textController1,
                      autofocus: true,
                      obscureText: false,
                      validator: (value) {
                        if (textController1.text.isEmpty) {
                          return 'Model should be valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Model',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF941414),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF941414),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                    child: TextFormField(
                      controller: textController2,
                      autofocus: true,
                      obscureText: false,
                      validator: (value) {
                        if (textController2.text.isEmpty) {
                          return 'HQ should be valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'HQ',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                    child: TextFormField(
                      controller: textController3,
                      autofocus: true,
                      obscureText: false,
                      validator: (value) {
                        if (textController3.text.isEmpty) {
                          return 'TQ should be valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'TQ',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                    child: TextFormField(
                      controller: textController4,
                      autofocus: true,
                      obscureText: false,
                      validator: (value) {
                        if (textController4.text.isEmpty) {
                          return 'Description should be valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          try {
                            final User user = _auth.currentUser;
                            final uid = user.uid;
                            String pathToReference = "truck/$uid/$id";
                            DatabaseReference ref2 =
                                FirebaseDatabase.instance.ref(pathToReference);
                            ref2.update({
                              "ownership_status": newValue,
                              "truck_transmission": newValue1,
                              "model": textController1.value.text,
                              "hq": textController2.value.text,
                              "tq": textController3.value.text,
                              "description": textController4.value.text,
                              "imran_url": _uploadedFileURL
                            });

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text("Truck details updated successfully"),
                            ));
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TruckList(),
                              ),
                            );
                          } catch (error) {
                            if (kDebugMode) {
                              print('never reached');
                            }
                          }
                          /*        final ref = FirebaseDatabase.instance.ref();
                        final snapshot = await ref.child('users').get();
                        if (snapshot.exists) {
                          print(snapshot.value);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content: Text(snapshot.value),
                          ));
                        } else {
                          print('No data available.');
                        }*/
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        minimumSize: const Size.fromHeight(50),
                        textStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
