import 'package:flutter/material.dart';
import 'package:ldp/model/item_view_model.dart';
import 'package:ldp/ui/section/ldp_image_section.dart';

class ItemGridView extends StatefulWidget {
  final String listingID;

  const ItemGridView({Key key, @required this.listingID}) : super(key: key);
  @override
  _ItemGridViewState createState() => _ItemGridViewState();
}

class _ItemGridViewState extends State<ItemGridView> {
  ItemViewModel itemViewModel;

  @override
  Widget build(BuildContext context) {
    _setItemViewModel(widget.listingID ?? null);

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LdpImageSection(imageHeight: 110),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(itemViewModel?.sellerID ?? "",
                        style: Theme.of(context).textTheme.subtitle2),
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(itemViewModel?.title ?? "",
                        style: Theme.of(context).textTheme.bodyText2),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(itemViewModel?.price ?? "",
                        style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
    );
  }

  Future<void>_setItemViewModel(String listingID) async {
    ItemViewModel tempIVM = await ItemViewModel.of(widget?.listingID ?? null);
    setState(() {
        itemViewModel = tempIVM;
      });
  }
}