import 'package:flutter/material.dart';
import 'package:myapp_core/pop_ups/myapp_popup.dart';
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
  bool isFromSeller = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Theme.of(context).primaryColor, elevation: 0),
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
                  isFromSeller: isFromSeller,
                ),
              ),
            ),
          ),
          SellerMenusWidget(
              menuIcon: Icons.local_shipping_rounded,
              menuTitle: "Orders To Ship",
              onPress: () {}),
          SellerMenusWidget(
              menuIcon: Icons.pageview_outlined,
              menuTitle: "View Previous Transactions",
              onPress: () {}),
          SellerMenusWidget(
              menuIcon: Icons.edit_attributes,
              menuTitle: "Edit Seller Information",
              onPress: () {}),
        ],
      ),
    );
  }
}
