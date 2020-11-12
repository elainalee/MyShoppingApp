import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class ImageUploader extends StatefulWidget {
  final File imageFile;

  const ImageUploader({Key key, this.imageFile}) : super(key: key);
  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  StorageUploadTask _uploadTask;

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(widget?.imageFile?.path ?? null);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('item_images/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(widget?.imageFile ?? null);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
    setState(() {
      _uploadTask = uploadTask;
    });    
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
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

          
    } else {
      // Allows user to decide when to start the upload
      return FlatButton.icon(
          label: Text('Upload to Firebase'),
          icon: Icon(Icons.cloud_upload),
          onPressed: () {
            uploadImageToFirebase(context);
          },
        );

    }
  }
}