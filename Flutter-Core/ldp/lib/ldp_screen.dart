import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ldp/model/user_view_model.dart';
import 'package:ldp/ui/ldp_page.dart';
import 'package:ldp/ui/widget/bottom_bar_widget.dart';

class LdpScreen extends StatefulWidget {
  final UserViewModel userViewModel;

  const LdpScreen({Key key, this.userViewModel}) : super(key: key);

  @override
  _LdpScreenState createState() => _LdpScreenState();
}

class _LdpScreenState extends State<LdpScreen> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 1000),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0.0, 0.0),
        child: Container(),
      ),
      // body: Column(
      //   children: <Widget>[
      //     Text(
      //       widget?.userViewModel?.username ?? "Loading"
      //     ),
      //     Text(
      //       widget?.userViewModel?.password ?? "Loading"
      //     )
      //   ],
      // ),
      body: LdpPage(userViewModel: widget?.userViewModel ?? null),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomBarWidget(),
    );
  }
}