import 'package:flutter/material.dart';
import 'package:ldp/ui/section/tab_bar/ldp_detail_section.dart';
import 'package:ldp/ui/section/tab_bar/ldp_faq_section.dart';
import 'package:ldp/ui/section/tab_bar/ldp_review_section.dart';
import 'package:myapp_core/common/colors.dart';

class LdpTabBarSection extends StatefulWidget {
  @override
  _LdpTabBarSectionState createState() => _LdpTabBarSectionState();
}

class _LdpTabBarSectionState extends State<LdpTabBarSection>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Tab> tabList = [
    Tab(text: "Detail"),
    Tab(text: "Review"),
    Tab(text: "FAQ")
  ];
  List<Widget> tabViewList = [
    LdpDetailSection(),
    LdpReviewSection(),
    LdpFaqSection()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabList.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.all(15),
      child: _buildTabBarView(),
    );
  }

  Widget _buildTabBarView() {
    return ListView(
      children: <Widget>[
        Container(
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(
            height: 20.0,
            child: TabBarView(
              controller: _tabController,
              children: tabViewList,
            ),
          ),
        )
      ],
    );
  }
}
