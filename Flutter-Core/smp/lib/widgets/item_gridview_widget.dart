import 'package:flutter/material.dart';
import 'package:myapp_core/models/item_view_model.dart';
import 'package:myapp_core/widgets/image_section_widget.dart';

class ItemGridViewWidget extends StatefulWidget {
  final String listingID;

  const ItemGridViewWidget({Key key, @required this.listingID})
      : super(key: key);
  @override
  _ItemGridViewWidgetState createState() => _ItemGridViewWidgetState();
}

class _ItemGridViewWidgetState extends State<ItemGridViewWidget> {
  ItemViewModel itemViewModel;

  @override
  Widget build(BuildContext context) {
    _setItemViewModel(widget.listingID ?? null);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageSectionWidget(
          imageHeight: 110,
          imageURL: itemViewModel?.imageURL,
        ),
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

  Future<void> _setItemViewModel(String listingID) async {
    ItemViewModel tempIVM = await ItemViewModel.of(widget?.listingID ?? null);
    setState(() {
      itemViewModel = tempIVM;
    });
  }
}
