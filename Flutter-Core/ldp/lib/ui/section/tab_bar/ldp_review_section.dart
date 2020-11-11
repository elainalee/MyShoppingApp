import 'package:flutter/material.dart';
import 'package:ldp/utils/constants.dart';

class LdpReviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: LDP_PAGE_PADDING,
      color: Theme.of(context).backgroundColor,
      child: _LdpReviewWidget()
    );
  }
}

class _LdpReviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Review Section"),
        Text("Placeholder")
      ],
    );
  }
}