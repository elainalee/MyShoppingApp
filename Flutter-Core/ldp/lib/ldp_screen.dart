import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ldp/model/user_view_model.dart';
import 'package:ldp/ui/ldp_page.dart';
import 'package:ldp/ui/widget/bottom_bar_widget.dart';

import 'package:myapp_core/models/item_view_model.dart';

class LdpScreen extends StatefulWidget {
  final UserViewModel userViewModel;
  final String listingID;

  const LdpScreen(
      {Key key, @required this.userViewModel, @required this.listingID})
      : super(key: key);

  @override
  _LdpScreenState createState() => _LdpScreenState();
}

class _LdpScreenState extends State<LdpScreen> {
  // final _controller = ScrollController();
  ItemViewModel itemViewModel;

  @override
  Widget build(BuildContext context) {
    _setItemViewModel(widget.listingID ?? null);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0.0, 0.0),
        child: Container(),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: LdpPage(
          userViewModel: widget?.userViewModel ?? null,
          itemViewModel: itemViewModel ?? null),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomBarWidget(
          context: context,
          userViewModel: widget?.userViewModel ?? null,
          itemViewModel: itemViewModel ?? null),
    );
  }

  Future<void> _setItemViewModel(String listingID) async {
    ItemViewModel tempIVM = await ItemViewModel.of(widget?.listingID ?? null);
    setState(() {
      itemViewModel = tempIVM;
    });
  }
}
