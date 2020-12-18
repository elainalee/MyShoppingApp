import 'package:flutter/material.dart';
import 'package:ldp/utils/constants.dart';
import 'package:myapp_core/models/item_view_model.dart';

class LdpDetailSection extends StatelessWidget {
  final ItemViewModel itemViewModel;

  const LdpDetailSection({Key key, @required this.itemViewModel})
      : super(key: key);

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

  const _LdpDetailWidget({Key key, @required this.itemViewModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child:
                  Text("Price", style: Theme.of(context).textTheme.bodyText2),
            ),
            Expanded(
              flex: 2,
              child: Text(itemViewModel?.price ?? "",
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child:
                  Text("Made in", style: Theme.of(context).textTheme.bodyText2),
            ),
            Expanded(
              flex: 2,
              child:
                  Text("China", style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(itemViewModel?.description ?? "",
            style: Theme.of(context).textTheme.bodyText2),
      ],
    );
  }
}
