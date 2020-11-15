import 'package:flutter/material.dart';
import 'package:ldp/model/item_view_model.dart';
import 'package:ldp/model/user_view_model.dart';
import 'package:myapp_core/ldp/buttons/myapp_round_button.dart';
import 'package:myapp_core/pop_ups/myapp_popup.dart';
import 'package:myapp_core/database_handler/upload_handler.dart';

class BottomBarWidget extends StatelessWidget {
  final ItemViewModel itemViewModel;
  final UserViewModel userViewModel;

  final BuildContext context;

  const BottomBarWidget({
    Key key,
    @required this.itemViewModel,
    @required this.userViewModel,
    this.context
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List<Widget>();
    items.add(_buildAddToCardButton(context));
    items.add(_buildBuyNowButton());
    return items.isNotEmpty
        ? BottomAppBar(
            child: Container(
              color: Colors.transparent,
                width: double.infinity,
                height: 55,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: items)))
        : null;
  }

  Widget _buildAddToCardButton(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyAppRoundButton(
        buttonText: "Cart",
        onPress: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            String popupText = uploadToCart(
              itemID: itemViewModel?.listingID ?? null,
              userID: userViewModel?.username ?? null);
            return MyAppPopUp(
              popupText: popupText,
            );
          }
      ))
    ));
  }

  Widget _buildBuyNowButton() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyAppRoundButton(
        buttonText: "Buy now",
        onPress: () => showDialog(
          context: context,
          builder: (BuildContext context) {
          // moves to new screen
          // new screen should receive: itemid, userid (B.username), sellerid?
            return MyAppPopUp(
              popupText: "Not Ready Yet",
            );
          }
        )
      ),
    ));
  }
}
