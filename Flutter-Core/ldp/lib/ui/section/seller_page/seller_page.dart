import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ldp/database/database_constants.dart';
import 'package:ldp/model/item_view_model.dart';

import 'item_gridview.dart';

class SellerPage extends StatefulWidget {
  final String sellerID;

  const SellerPage({Key key, @required this.sellerID}) : super(key: key);
  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
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
                      return ItemGridView(listingID: sellerListings[index]);
                      // return Container(
                      //   alignment: Alignment.center,
                      //   color: Colors.teal[100 * (index % 9)],
                      //   child: Text(sellerListings[index]),
                      //     // 'grid item $index'),
                      // );
                    },
                    childCount: sellerListings.length,
                  ),
                )
              ),
            ],
          ),
    );
  }
  
  Future<void>_setSellerListings(String sellerID) async {
    List<String> tempSListings = await sellerListingsAre(sellerID);
    setState(() {
        sellerListings = tempSListings;
      });
  }
    
  Future<List<String>> sellerListingsAre(String sellerID) async {
      List<String> sellerListings = [];
      DatabaseReference dbRef = FirebaseDatabase.instance.reference().child(ITEMS_SELL_TABLE);
      await dbRef.once().then((DataSnapshot snapshot){
        Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key,value) {
            if (value[I_SID] == sellerID) {
              sellerListings.add(key);
            }
          });
      });
      return sellerListings;
      }
}