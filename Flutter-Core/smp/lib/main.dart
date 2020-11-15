import 'package:smp/seller_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyAppSeller());
}

class MyAppSeller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seller Page Demo',
      home: SellerScreen()
    );
  }
}