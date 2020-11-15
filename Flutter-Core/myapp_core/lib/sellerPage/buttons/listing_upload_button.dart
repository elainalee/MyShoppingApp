import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../../database_handler/upload_handler.dart';
import '../../exceptions/wrong_price_format.dart';
import '../../exceptions/empty_field_exception.dart';
import '../../pop_ups/myapp_popup.dart';


class ListingUploadButton extends StatefulWidget {
  final File imageFile;
  final TextEditingController titleController;
  final TextEditingController priceController;
  final TextEditingController categoryController;
  final TextEditingController originController;
  final TextEditingController descriptionController;
  final String sellerID;
  final Widget uploadButtonWidget;
  final Widget uploadCompleteWidget;
  final Widget uploadPausedWidget;
  final Widget uploadInprogressWidget;

  const ListingUploadButton({
    Key key,
    this.imageFile,
    this.titleController,
    this.priceController,
    this.categoryController,
    this.originController,
    this.descriptionController,
    this.sellerID,
    @required this.uploadButtonWidget,
    @required this.uploadCompleteWidget,
    this.uploadPausedWidget,
    this.uploadInprogressWidget
    }) : super(key: key);
  @override
  _ListingUploadButtonState createState() => _ListingUploadButtonState();
}

class _ListingUploadButtonState extends State<ListingUploadButton> {
  StorageUploadTask _uploadTask;
  bool _uploadedListing = false;

  @override
  Widget build(BuildContext context) {
    if (_uploadTask == null || !_uploadedListing) {
      return  FlatButton(
        child: widget?.uploadButtonWidget ?? Container(),
        onPressed: () async =>_showCorrectPopup(context)
        );
    } else {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          // stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;
            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;
            return Column(
                children: [
                  if (_uploadTask.isComplete)
                    widget?.uploadCompleteWidget,
                  if (_uploadTask.isPaused)
                    FlatButton(
                      child: widget?.uploadPausedWidget,
                      onPressed: _uploadTask.resume,
                    ),
                  if (_uploadTask.isInProgress)
                    FlatButton(
                      child: widget?.uploadInprogressWidget,
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

  Future<void> _uploadImageListing({
      BuildContext context,
      String title,
      double price,
      String category,
      String origin,
      String description}) async {
      
    String temp;
    StorageUploadTask uploadTask = await uploadImageFile(widget?.imageFile);
    setState(() => _uploadTask = uploadTask);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((imageURL) {
      temp = imageURL;
      uploadListingData(
        imageURL: temp,
        title: title,
        price: price,
        category: category,
        origin: origin,
        description: description,
        sellerID: widget?.sellerID ?? "");
      setState(() {
        _uploadedListing = true;
        _uploadTask = uploadTask;
        });
      });
  }

  Future _showCorrectPopup(BuildContext context) async {
    String textToShow;
    if (widget?.imageFile == null) {
      textToShow = "Please upload the image";
    }
    else {
      try {
        String titleText = widget?.titleController?.text?.trim() ?? "";
        String priceText = widget?.priceController?.text?.trim() ?? "";
        String categoryText = widget?.categoryController?.text?.trim() ?? "";
        String originText =  widget?.originController?.text?.trim() ?? "";
        String descriptionText = widget?.descriptionController?.text?.trim() ?? "";

        if (titleText == "" || priceText == "" || categoryText == "" ||
            originText == "" || descriptionText == "") {
          throw EmptyFieldException();
        }

        double priceDouble = priceTextToDouble(priceText ?? "");

        await _uploadImageListing(
          context: context,
          title: titleText,
          price: priceDouble,
          category: categoryText,
          origin: originText,
          description: descriptionText,
        );

        textToShow = "Upload Success";
      } on WrongPriceFormatException catch (err) {
        textToShow = "Please double check the Price section";
      } on EmptyFieldException catch (err) {
        textToShow = "Fields cannot be empty. please check again.";
      } catch (err) {
        textToShow = "Failed to upload listing. Please try again";
      }
    }
    return showDialog(
      context: context,
      builder: (BuildContext context) => 
        MyAppPopUp(
          popupText: textToShow
        )
      );
  }
}