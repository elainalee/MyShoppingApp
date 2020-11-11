import 'package:flutter/material.dart';
import 'package:ldp/utils/constants.dart';

class LdpFaqSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: LDP_PAGE_PADDING,
      color: Theme.of(context).backgroundColor,
      child: _LdpFaqWidget()
    );
  }
}

class _LdpFaqWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("FAQ section"),
        Text("Placeholder")
      ],
    );
  }
}