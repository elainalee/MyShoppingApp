import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(ImageCapture());
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() =>
      _ImageCaptureState();
}

class _ImageCaptureState
    extends State<ImageCapture> {

  final imagepicker = ImagePicker();
  File _imageFile;

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
      );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }
  

  Future _pickImage(BuildContext context, ImageSource source) async {
    final pickedFile = await imagepicker.getImage(source: source);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  void _clearImage() {
    setState(() => _imageFile = null);
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
                onPressed: () => _pickImage(context, ImageSource.camera),
              ),
              IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () => _pickImage(context, ImageSource.gallery),
              ),
            ],
          ),
        ),
        body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile),
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
            Uploader(imageFile: _imageFile ?? null)
          ]
        ],
      ),
      ),
    );
  }
}

class Uploader extends StatefulWidget {
  final File imageFile;

  const Uploader({Key key, this.imageFile}) : super(key: key);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
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