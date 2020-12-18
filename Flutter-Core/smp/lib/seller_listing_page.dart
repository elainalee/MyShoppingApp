import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp_core/common/database_constants.dart';
import 'package:smp/listing_upload/listing_post_page.dart';

import 'widgets/item_gridview_widget.dart';

class SellerListingPage extends StatefulWidget {
  // final SellerViewModel sellerViewModel;
  final String sellerID;
  final bool accessFromSeller;

  SellerListingPage(
      {Key key, @required this.sellerID, this.accessFromSeller = false})
      : super(key: key);
  @override
  _SellerListingPageState createState() => _SellerListingPageState();
}

class _SellerListingPageState extends State<SellerListingPage> {
  List<String> sellerListings = [];
  @override
  Widget build(BuildContext context) {
    _setSellerListings(widget?.sellerID ?? null);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget?.sellerID ?? "",
            style: Theme.of(context).appBarTheme.textTheme.headline1),
        centerTitle: true,
        elevation: 0,
        textTheme: Theme.of(context).appBarTheme.textTheme,
        backgroundColor: Theme.of(context).appBarTheme.color,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  // childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ItemGridViewWidget(listingID: sellerListings[index]);
                  },
                  childCount: sellerListings.length,
                ),
              )),
        ],
      ),
      floatingActionButton: widget.accessFromSeller
          ? FloatingActionButton(
              backgroundColor: const Color(0xff03dac6),
              foregroundColor: Colors.black,
              mini: true,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ListingPostPage(sellerID: widget?.sellerID ?? "")),
              ),
              child: Icon(Icons.add),
            )
          : Container(),
    );
  }

  Future<void> _setSellerListings(String sellerID) async {
    List<String> tempSListings = await sellerListingsAre(sellerID);
    setState(() {
      sellerListings = tempSListings;
    });
  }

  Future<List<String>> sellerListingsAre(String sellerID) async {
    List<String> sellerListings = [];
    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child(ITEMS_SELL_TABLE);
    await dbRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        if (value[I_SID] == sellerID) {
          sellerListings.add(key);
        }
      });
    });
    return sellerListings;
  }
}
