import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp_core/models/seller_view_model.dart';
import 'package:smp/seller_screen.dart';
import 'constants.dart';

class LeadToSmp extends StatefulWidget {
  @override
  _LeadToSmpState createState() => _LeadToSmpState();
}

class _LeadToSmpState extends State<LeadToSmp> {
  SellerViewModel sellerViewModel;

  @override
  Widget build(BuildContext context) {
    _getSellerInfo();
    return WillPopScope(
      child: SellerScreen(sellerViewModel: sellerViewModel ?? null),
      onWillPop: () {
        return SystemNavigator.pop();
      },
    );
  }

  Future<void> _getSellerInfo() async {
    String requestedSellerID;

    try {
      requestedSellerID = await CHANNEL.invokeMethod("getSellerID");
    } on PlatformException catch (e) {
      requestedSellerID = "Failed to get SellerID: '${e.message}";
    }

    setState(() {
      sellerViewModel = SellerViewModel(
          sellerID: requestedSellerID,
          storeName: "storeName",
          sellerImageURL: "",
          sellerName: "sellerName");
    });
  }
}
