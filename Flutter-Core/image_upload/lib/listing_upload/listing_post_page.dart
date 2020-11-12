import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'listing_uploader.dart';

class ListingPostPage extends StatefulWidget {
  @override
  _ListingPostPageState createState() => _ListingPostPageState();
}

class _ListingPostPageState extends State<ListingPostPage> {
  final imagepicker = ImagePicker();
  File _imageFile;

  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _originController = TextEditingController();
  final _descriptionController = TextEditingController();

  
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
          ] else Container(
              height: 200,
              width: double.infinity,
              color: Colors.purple,
              child: Text("placeholder image")
          ),
          ListingTextField(
            hintText: 'Please type the item \'s title',
            labelText: 'Item Title',
            controller: _titleController
          ),
          ListingTextField(
            hintText: 'Please type the item \'s price',
            labelText: 'Price',
            textType: TextInputType.number
          ),
          ListingTextField(
            hintText: 'Please type the item \'s category',
            labelText: 'Category',
          ),
          ListingTextField(
            hintText: 'Please type the item \'s origin',
            labelText: 'Origin',
          ),
          ListingTextField(
            hintText: 'Please type the item \'s description',
            labelText: 'Description',
            height: 100
          ),
          ListingUploader(
            imageFile: _imageFile ?? null,
            titleController: _titleController ?? null,
            priceController: _priceController ?? null,
            categoryController: _categoryController ?? null,
            originController: _originController ?? null,
            descriptionController: _descriptionController ?? null
          )
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

class ListingTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final int minLines;
  // TODO: maxLines do not restrict the number of character - fix
  final int maxLines;
  final double height;
  final TextInputType textType;
  final controller;

  const ListingTextField({
    Key key,
    this.hintText = "",
    this.labelText = "",
    this.minLines = 1,
    this.maxLines = 1,
    this.height = 0,
    this.textType = TextInputType.text,
    this.controller}) : super(key: key);

  @override
  _ListingTextFieldState createState() => _ListingTextFieldState();
}

class _ListingTextFieldState extends State<ListingTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
          decoration: InputDecoration(
            hintText: 'Please type the item \'s ${widget.hintText}',
            labelText: widget.labelText,
            contentPadding: EdgeInsets.only(bottom: widget.height),
          ),
          autofocus: false,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          keyboardType: widget.textType,
          controller: widget.controller
        ),
    );
  }
}