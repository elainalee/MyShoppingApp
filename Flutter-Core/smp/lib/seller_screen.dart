import 'package:flutter/material.dart';
import 'package:smp/seller_listings_page.dart';
import 'package:myapp_core/models/seller_view_model.dart';

import 'widgets/seller_menus_widget.dart';
import 'widgets/seller_profile_widget.dart';

class SellerScreen extends StatefulWidget {
  final SellerViewModel sellerViewModel;

  const SellerScreen({Key key, this.sellerViewModel}) : super(key: key);
  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text("Profile",
            style: Theme.of(context).appBarTheme.textTheme.headline1),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Text("Edit",
                style: Theme.of(context).appBarTheme.textTheme.headline2),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          SellerProfileWidget(
            sellerViewModel: widget?.sellerViewModel ?? null,
          ),
          SizedBox(height: 30),
          SellerMenusWidget(
            menuIcon: Icons.view_agenda_outlined,
            menuTitle: "My Listings",
            onPress: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SellerListingsPage(
                  sellerViewModel: widget?.sellerViewModel ?? null,
                  accessFromSeller: true,
                ),
              ),
            ),
          ),
          SellerMenusWidget(
            menuIcon: Icons.local_shipping_rounded,
            menuTitle: "Orders To Ship",
            onPress: () {},
          ),
          SellerMenusWidget(
            menuIcon: Icons.pageview_outlined,
            menuTitle: "View Previous Transactions",
            onPress: () {},
          ),
        ],
      ),
    );
  }
}
