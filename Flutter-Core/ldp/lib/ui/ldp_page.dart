import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ldp/model/user_view_model.dart';
import 'package:ldp/ui/section/tab_bar/ldp_detail_section.dart';
import 'package:ldp/ui/section/tab_bar/ldp_faq_section.dart';
import 'package:ldp/ui/section/tab_bar/ldp_review_section.dart';
import 'package:ldp/ui/section/top_section/top_section.dart';

import '../model/item_view_model.dart';

class LdpPage extends StatefulWidget {
  final UserViewModel userViewModel;
  final ItemViewModel itemViewModel;

  const LdpPage({Key key, @required this.userViewModel, @required this.itemViewModel}) : super(key: key);

  @override
  _LdpPageState createState() => _LdpPageState();
}

class _LdpPageState extends State<LdpPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  int selectedIndex = 0;

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
    _scrollController = ScrollController();
    _tabController = TabController(
      initialIndex: selectedIndex,
      length: tabList.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildOriginalCustomScrollView();
  }

  Widget _buildOriginalCustomScrollView() {

    return NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            TopSection(_tabController, tabList: tabList,
            userViewModel: widget?.userViewModel ?? null, 
            itemViewModel: widget?.itemViewModel ?? null)
          ];
        },
        body: TabBarView(controller: _tabController, children: tabViewList));
  }
}
