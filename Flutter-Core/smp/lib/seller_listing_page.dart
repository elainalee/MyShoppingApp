import 'package:flutter/material.dart';
import 'package:smp/listing_upload/listing_post_page.dart';
import 'package:myapp_core/view_models/seller_view_model.dart';

class SellerListingPage extends StatefulWidget {
  final SellerViewModel sellerViewModel;

  const SellerListingPage({Key key, this.sellerViewModel}) : super(key: key);
  @override
  _SellerListingPageState createState() => _SellerListingPageState();
}

class _SellerListingPageState extends State<SellerListingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        mini: true,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListingPostPage(
                  sellerViewModel: widget?.sellerViewModel ?? null)),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
