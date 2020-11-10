import 'package:flutter/material.dart';
import 'package:ldp/utils/constants.dart';

import '../../../model/item_view_model.dart';

class LdpDetailSection extends StatelessWidget {
  final ItemViewModel itemViewModel;

  const LdpDetailSection({Key key, @required this.itemViewModel}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: LDP_PAGE_PADDING,
        color: Theme.of(context).backgroundColor,
        child: _LdpDetailWidget(itemViewModel: itemViewModel ?? null));
  }
}

class _LdpDetailWidget extends StatelessWidget {
  final ItemViewModel itemViewModel;

  const _LdpDetailWidget({Key key, @required this.itemViewModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text("Price",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 15)),
            ),
            Expanded(
              flex: 2,
              child: Text(itemViewModel?.price.toString() ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 15)),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text("Made in",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 15)),
            ),
            Expanded(
              flex: 2,
              child: Text("China",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 15)),
            ),
          ],
        ),
        Text(itemViewModel?.description ?? ""),
        Text(
            "Detail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\n"),
        Text(
            "Detail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\nDetail Section\nPlaceholder\n"),
      ],
    );
  }
}
