import 'package:flutter/material.dart';
import 'package:ldp/model/user_view_model.dart';
import 'package:ldp/ui/section/ldp_image_section.dart';
import 'package:myapp_core/models/seller_view_model.dart';
import 'package:smp/seller_listings_page.dart';
import 'package:myapp_core/ldp/buttons/myapp_square_button.dart';
import 'package:ldp/utils/constants.dart';
import 'package:myapp_core/common/colors.dart';

import 'package:myapp_core/models/item_view_model.dart';

const double descriptionHeight = 160;

class TopSection extends StatefulWidget {
  final UserViewModel userViewModel;
  final ItemViewModel itemViewModel;
  final Map<String, Widget> tabBarView;
  final bool enableForceElevated;

  const TopSection(
      {Key key,
      @required this.tabBarView,
      @required this.userViewModel,
      @required this.itemViewModel,
      @required this.enableForceElevated})
      : super(key: key);
  @override
  _TopSectionState createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  SellerViewModel sellerViewModel;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        forceElevated: widget.enableForceElevated,
        elevation: 0.25,
        backgroundColor: Theme.of(context).backgroundColor,
        pinned: true,
        expandedHeight: PHOTO_HEIGHT + descriptionHeight,
        flexibleSpace:
            LdpImageSection(imageURL: widget?.itemViewModel?.imageURL ?? ""),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(descriptionHeight),
            child: _buildDescriptionSection(context)));
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: <Widget>[
        Container(
            color: Theme.of(context).backgroundColor,
            height: descriptionHeight),
        Padding(
          padding: LDP_PAGE_PADDING,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget?.itemViewModel?.title ?? "",
                  style: Theme.of(context).textTheme.headline2),
              Text(widget?.itemViewModel?.category ?? "",
                  style: Theme.of(context).textTheme.subtitle1),
              Text(widget?.itemViewModel?.price ?? "",
                  style: Theme.of(context).textTheme.subtitle1),
              _goToSellerPage(widget?.itemViewModel?.sellerID ?? "", context),
              SizedBox(height: 10),
              _buildTabBar(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _goToSellerPage(String sellerID, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: MyAppSquareButton(
        buttonText: "See More of ${sellerID ?? ""}'s Items >",
        fontSize: 12,
        height: 20,
        onPress: () async {
          await _setSellerViewModel(sellerID ?? null);
          return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SellerListingsPage(
                    sellerViewModel: sellerViewModel ?? null)),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: ma_lightGrey2),
      height: 30,
      child: Padding(
        padding: EdgeInsets.all(2),
        child: TabBar(
          labelColor: Colors.black,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: Colors.white),
          tabs: widget.tabBarView.keys
              .map((String name) => Tab(text: name))
              .toList(),
        ),
      ),
    );
  }

  Future<void> _setSellerViewModel(String sellerID) async {
    SellerViewModel tempSVM = await SellerViewModel.of(sellerID ?? null);
    setState(() {
      sellerViewModel = tempSVM;
    });
  }
}
