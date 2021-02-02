import 'package:flutter/material.dart';
import 'package:ldp/model/user_view_model.dart';
import 'package:ldp/ui/section/tab_bar/ldp_detail_section.dart';
import 'package:ldp/ui/section/tab_bar/ldp_faq_section.dart';
import 'package:ldp/ui/section/tab_bar/ldp_review_section.dart';
import 'package:ldp/ui/section/top_section/top_section.dart';
import 'package:myapp_core/models/item_view_model.dart';

// import '../utils/constants.dart';
// import 'section/ldp_image_section.dart';

class LdpPage extends StatefulWidget {
  final UserViewModel userViewModel;
  final ItemViewModel itemViewModel;

  final BuildContext context;

  const LdpPage(
      {Key key,
      @required this.userViewModel,
      @required this.itemViewModel,
      this.context})
      : super(key: key);

  @override
  _LdpPageState createState() => _LdpPageState();
}

class _LdpPageState extends State<LdpPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  int selectedIndex = 0;

  int tabLength = 3;
  Map<String, Widget> tabBarView;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(
      initialIndex: selectedIndex,
      length: tabLength,
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
    tabBarView = {
      "Detail": LdpDetailSection(itemViewModel: widget?.itemViewModel ?? null),
      "Review": LdpReviewSection(),
      "FAQ": LdpFaqSection()
    };

    return DefaultTabController(
      length: tabBarView.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: TopSection(
                    tabBarView: tabBarView,
                    enableForceElevated: innerBoxIsScrolled,
                    userViewModel: widget?.userViewModel ?? null,
                    itemViewModel: widget?.itemViewModel ?? null)),
          ];
        },
        body: TabBarView(
          children: tabBarView.keys.map((String name) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    key: PageStorageKey<String>(name),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: SliverList(
                              delegate: SliverChildListDelegate([
                            tabBarView[name],
                          ]))),
                    ],
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
