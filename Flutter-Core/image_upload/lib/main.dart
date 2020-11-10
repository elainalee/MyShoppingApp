import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Upload demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageCapture(),
    );
  }
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  // Active image file
  File _imageFile;

  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () => _pickImage(ImageSource.camera),
          ),
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: () => _pickImage(ImageSource.gallery),
          )
        ],)
      ),
      body: ListView(
        children: <Widget>[
          // if (_imageFile != null) ...[
          //   Image.file(_imageFile),
          //   Row(
          //     children: <Widget> [
          //       FlatButton(
          //         child: Icon(Icons.crop),
          //         onPressed: _cropImage,
          //       ),
          //       FlatButton(
          //         child: Icon(Icons.refresh),
          //         onPressed: _clear
          //       )
          //     ]
          //   ),
          //   Uploader(file: _imageFile)
          // ]
        ],
      )
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    try {
      setState(() {
        _imageFile = selected;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      );
    setState((){
      _imageFile = cropped ?? _imageFile;
    });
  }
}

class Uploader extends StatefulWidget {

  final File file;

  const Uploader({Key key, this.file}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}