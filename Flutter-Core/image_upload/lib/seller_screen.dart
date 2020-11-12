import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload/image_uploader.dart';

class SellerScreen extends StatefulWidget {
  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  final imagepicker = ImagePicker();
  File _imageFile;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0.0, 0.0),
        child: Container(),
      ),
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile ),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clearImage,
                ),
              ],
            ),
            ImageUploader(imageFile: _imageFile ?? null)
          ]
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => _pickImage(context, ImageSource.camera),
              ),
              IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () => _pickImage(context, ImageSource.gallery),
              ),
            ],
          ),
        ),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
    );
  }

  Future _pickImage(BuildContext context, ImageSource source) async {
    final pickedFile = await imagepicker.getImage(source: source);
    setState(() => _imageFile = File(pickedFile.path));
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path);
    setState(() => _imageFile = cropped ?? _imageFile);
  }

  void _clearImage() {
    setState(() => _imageFile = null);
  }
}