import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp_core/common/database_constants.dart';
import 'package:myapp_core/models/seller_view_model.dart';
import 'package:smp/listing_upload/listing_post_page.dart';
import 'package:smp/utils/size_config.dart';

import 'widgets/item_card_widget.dart';

class SellerListingsPage extends StatefulWidget {
  final SellerViewModel sellerViewModel;
  final bool accessFromSeller;

  SellerListingsPage(
      {Key key, @required this.sellerViewModel, this.accessFromSeller = false})
      : super(key: key);
  @override
  _SellerListingsPageState createState() => _SellerListingsPageState();
}

class _SellerListingsPageState extends State<SellerListingsPage> {
  List<String> sellerListings = [];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _setSellerListings(widget?.sellerViewModel?.sellerID ?? null);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget?.sellerViewModel?.storeName ?? "",
            style: Theme.of(context).appBarTheme.textTheme.headline1),
        leading: Icon(Icons.arrow_back_ios_outlined,
            color: Theme.of(context).appBarTheme.iconTheme.color,
            size: Theme.of(context).appBarTheme.iconTheme.size),
        centerTitle: true,
        elevation: 0,
        textTheme: Theme.of(context).appBarTheme.textTheme,
        backgroundColor: Theme.of(context).appBarTheme.color,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: ((SizeConfig.screenHeight /
                      (SizeConfig.screenHeight + 30))),
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ItemCardWidget(listingID: sellerListings[index]);
                  },
                  childCount: sellerListings.length,
                ),
              )),
        ],
      ),
      floatingActionButton: widget.accessFromSeller
          ? FloatingActionButton.extended(
              backgroundColor:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
              foregroundColor:
                  Theme.of(context).floatingActionButtonTheme.foregroundColor,
              elevation: 1,
              label: Text("Add Listing",
                  style: Theme.of(context).accentTextTheme.headline1),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListingPostPage(
                        sellerID: widget?.sellerViewModel?.sellerID ?? "")),
              ),
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
