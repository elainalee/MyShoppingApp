import 'package:flutter/material.dart';
import 'package:ldp/model/user_view_model.dart';
import 'package:ldp/ui/section/ldp_image_section.dart';
import 'package:myapp_core/ldp/buttons/myapp_square_button.dart';
import 'package:ldp/utils/constants.dart';
import 'package:myapp_core/common/colors.dart';

import '../../../model/item_view_model.dart';

const double descriptionHeight = 160;

class TopSection extends StatelessWidget {
  final UserViewModel userViewModel;
  final ItemViewModel itemViewModel;
  final TabController _tabController;
  final List<Tab> tabList;

  const TopSection(this._tabController, 
  {Key key, 
  @required this.tabList, 
  @required this.userViewModel,
  @required this.itemViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      forceElevated: true,
      elevation: 0.25,
      backgroundColor: Theme.of(context).backgroundColor,
      pinned: true,
      expandedHeight: PHOTO_HEIGHT + descriptionHeight,
      flexibleSpace: LdpImageSection(),
      bottom: PreferredSize(
          child: _buildDescriptionSection(context),
          preferredSize: Size.fromHeight(descriptionHeight)),
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Stack(
      alignment : AlignmentDirectional.centerStart,
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
              Text(userViewModel?.username ?? "Loading"),
              Text(userViewModel?.password ?? "Loading"),

              Text(itemViewModel?.title ?? "NOT WORKING", style: Theme.of(context).textTheme.headline2),
              Text(itemViewModel?.category ?? "NOT WORKING",
                  style: Theme.of(context).textTheme.subtitle1),
              Text(itemViewModel?.price.toString() ?? "NOT WORKING",
                  style: Theme.of(context).textTheme.subtitle1),
              _goToSellerPage(itemViewModel?.sellerID ?? ""),
              SizedBox(height: 10),
              _buildTabBar(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _goToSellerPage(String sellerID) {
    // TODO: do something with this given seller ID
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: MyAppSquareButton(
        buttonText: sellerID ?? "",
        // buttonText: "See more Admin's items >",
        fontSize: 12,
        height: 20,
        onPress: () {},
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
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white),
                  controller: _tabController,
                  tabs: tabList),
            ),
          );
  }
}
