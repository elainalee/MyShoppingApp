import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UploadingImageToFirebaseStorage extends StatefulWidget {
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  File imageFile;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      imageFile = File(pickedFile.path);
    });
    uploadImageToFirebase(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: Scaffold(

        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => pickImage(context),
              ),
              IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () => pickImage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }


Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('item_images/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }
}