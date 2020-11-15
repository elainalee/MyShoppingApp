import 'package:flutter/material.dart';
import 'package:smp/listing_upload/listing_post_page.dart';

class SellerScreen extends StatefulWidget {
  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0.0, 0.0),
        child: Container(),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Material(
            color: Colors.purple[100],
            child: InkWell(
              onTap: () => print("Container pressed"),
              child: Container(height: 100, width: double.infinity,
                child: Text("My listings - not working"))
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Material(
            color: Colors.purple[200],
            child: InkWell(
              onTap: () => print("Container pressed"),
              child: Container(height: 100, width: double.infinity,
              child: Text("View Transactions - not working"))
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Material(
            color: Colors.purple[300],
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListingPostPage()),
              ),
              child: Container(height: 100, width: double.infinity,
                child: Text("Upload New Listing"))
              ),
            ),
          )
        ],
      ),
    );
  }
}