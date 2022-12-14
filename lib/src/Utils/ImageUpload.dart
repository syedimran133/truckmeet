// @dart=2.9
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:path/path.dart';


class ImageUpload extends StatefulWidget {
  ImageUpload({ Key key,  this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {

  File _image,image;
  String _uploadedFileURL;
  bool isLoading = false;
  Future chooseFile() async {

    image = File(await ImagePicker().getImage(source: ImageSource.gallery).then((pickedFile) => pickedFile.path));
    setState(() {
      _image=image;
    });
  }

  Future uploadFile() async {
    setState(() {
      isLoading = true;
    });
    final fileName = basename(_image.path);
   final destination = 'images/$fileName';
    try {
      final ref = FirebaseStorage.instance
          .ref().child(destination);
      await ref.putFile(_image);
      String url = await ref.getDownloadURL();
      setState(() {
        isLoading = false;
        _uploadedFileURL=url;
        print(_uploadedFileURL);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore File Upload'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('Selected Image'),
                        _image != null
                            ? Image.file(
                          _image,
                          // height: 150,
                          height: 150,
                          width: 150,
                        )
                            : Container(
                          child: Center(
                            child: Text(
                              "No Image is Selected",
                            ),
                          ),
                          height: 150,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text('Uploaded Image'),
                        _uploadedFileURL != null
                            ? Image.network(
                          _uploadedFileURL,
                          height: 150,
                          width: 150,
                        )
                            : Container(
                          child: Center(
                            child: Text(
                              "No Image is Selected",
                            ),
                          ),
                          height: 150,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            _image != null
                ? isLoading
                ? CircularProgressIndicator()
                : TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused))
                        return Colors.red;
                      return null; // Defer to the widget's default.
                    }
                ),
              ),
              onPressed: uploadFile,
              child: Text('Upload '),
            )
                : Container()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: chooseFile,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}