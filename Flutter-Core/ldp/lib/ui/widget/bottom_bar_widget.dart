import 'package:flutter/material.dart';
import 'package:myapp_core/ldp/buttons/myapp_round_button.dart';

class BottomBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> items = List<Widget>();
    items.add(_buildAddToCardButton());
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

  Widget _buildAddToCardButton() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyAppRoundButton(
        buttonText: "Cart",
        onPress: () {},
      ),
    ));
  }

  Widget _buildBuyNowButton() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyAppRoundButton(
        buttonText: "Buy now",
        onPress: () {},
      ),
    ));
  }
}
