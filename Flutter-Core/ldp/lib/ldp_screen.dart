import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ldp/model/user_view_model.dart';
import 'package:ldp/ui/ldp_page.dart';
import 'package:ldp/ui/widget/bottom_bar_widget.dart';

import 'model/item_view_model.dart';


class LdpScreen extends StatefulWidget {
  final UserViewModel userViewModel;
  final String listingID;

  const LdpScreen({Key key, @required this.userViewModel, @required this.listingID}) : super(key: key);

  @override
  _LdpScreenState createState() => _LdpScreenState();
}

class _LdpScreenState extends State<LdpScreen> {
  final _controller = ScrollController();
  ItemViewModel itemViewModel;

  @override
  Widget build(BuildContext context) {
    _setItemViewModel(widget.listingID ?? null);
    Timer(Duration(milliseconds: 1000),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0.0, 0.0),
        child: Container(),
      ),
      body: LdpPage(userViewModel: widget?.userViewModel ?? null,
                    itemViewModel: itemViewModel ?? null),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomBarWidget(),
    );
  }

  Future<void> _setItemViewModel(String listingID) async {
    ItemViewModel temp = await ItemViewModel.of(widget?.listingID ?? null);
      setState(() {
        itemViewModel = temp;
      });
  }
}