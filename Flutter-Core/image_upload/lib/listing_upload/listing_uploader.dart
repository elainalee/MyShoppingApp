import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class ListingUploader extends StatefulWidget {
  final File imageFile;
  final TextEditingController titleController;
  final TextEditingController priceController;
  final TextEditingController categoryController;
  final TextEditingController originController;
  final TextEditingController descriptionController;

  const ListingUploader({
    Key key,
    this.imageFile,
    this.titleController,
    this.priceController,
    this.categoryController,
    this.originController,
    this.descriptionController}) : super(key: key);
  @override
  _ListingUploaderState createState() => _ListingUploaderState();
}

class _ListingUploaderState extends State<ListingUploader> {
  StorageUploadTask _uploadTask;
  bool _uploadedListing = false;
  bool _priceInWrongFormat = false;

  @override
  Widget build(BuildContext context) {
    if (_uploadTask == null || !_uploadedListing) {
      return FlatButton.icon(
          label: Text('Upload to Firebase'),
          icon: Icon(Icons.cloud_upload),
          onPressed: () {
            if (widget?.imageFile == null) {
              // TODO: pop up notifying image is needed
              // use AddDBToCart for reference - fix this block of thing
              print(" not doing anything");
            } else {
              _uploadToFirebase();
              if (_priceInWrongFormat) {
                // TODO: pop up notifying price has to be in right format
              }
            }
            print(widget?.titleController?.text ?? "");
          },
        );
    } else {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;
            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;
            return Column(
                children: [
                  if (_uploadTask.isComplete)
                    Text('🎉🎉🎉'),
                  if (_uploadTask.isPaused)
                    FlatButton(
                      child: Icon(Icons.play_arrow),
                      onPressed: _uploadTask.resume,
                    ),
                  if (_uploadTask.isInProgress)
                    FlatButton(
                      child: Icon(Icons.pause),
                      onPressed: _uploadTask.pause,
                    ),
                  // Progress bar
                  LinearProgressIndicator(value: progressPercent),
                  Text(
                    '${(progressPercent * 100).toStringAsFixed(2)} % '
                  ),
                ],
              );
          });
    }
  }

  Future _uploadToFirebase() async {
    String fileName = basename(widget?.imageFile?.path ?? null);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('item_images/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(widget?.imageFile ?? null);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((value) {
      print("Done: $value");
      _uploadListingDataToFirebase(value);
      });
    setState(() {
      _uploadTask = uploadTask;
    });    
  }

  void _uploadListingDataToFirebase(String imageURL) {
    final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("example");
    double price = 0.0;
    try {
      price = double.parse(widget?.priceController?.text);
    } catch (err) {
      _priceInWrongFormat = true;
    }
    databaseReference.push().set({
      "title": widget?.titleController?.text ?? "", 
      "price": price,
      "category": widget?.categoryController?.text ?? "",
      "origin": widget?.originController?.text ?? "",
      "description": widget?.descriptionController?.text ?? "",
      "image": imageURL ?? ""
    });
    setState(() => _uploadedListing = true);
  }
}