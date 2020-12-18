import 'package:smp/seller_screen.dart';
import 'package:myapp_core/models/seller_view_model.dart';
import 'package:flutter/material.dart';

import 'utils/smp_theme.dart';

void main() {
  runApp(MyAppSeller());
}

class MyAppSeller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: buildSmpTheme(context),
        home: SellerScreen(
            sellerViewModel: SellerViewModel(
                sellerID: "admin",
                sellerName: "admin",
                storeName: "Admin's Store",
                sellerImage: null)));
  }
}
