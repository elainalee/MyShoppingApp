import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ldp/model/user_view_model.dart';
import 'package:ldp/ui/ldp_page.dart';
import 'package:ldp/ui/widget/bottom_bar_widget.dart';

import 'package:myapp_core/models/item_view_model.dart';

class LdpScreen extends StatefulWidget {
  final UserViewModel userViewModel;
  final String listingID;
  final bool isFromUser;

  const LdpScreen(
      {Key key,
      @required this.listingID,
      @required this.isFromUser,
      this.userViewModel})
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
          itemViewModel: itemViewModel ?? null,
          isFromUser: widget.isFromUser,
          userViewModel: widget?.userViewModel ?? null,
          context: context),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: (widget.isFromUser)
          ? BottomBarWidget(
              context: context,
              userViewModel: widget?.userViewModel ?? null,
              itemViewModel: itemViewModel ?? null)
          : Container(height: 0, width: 0),
    );
  }

  Future<void> _setItemViewModel(String listingID) async {
    ItemViewModel tempIVM = await ItemViewModel.of(widget?.listingID ?? null);
    setState(() {
      itemViewModel = tempIVM;
    });
  }
}
