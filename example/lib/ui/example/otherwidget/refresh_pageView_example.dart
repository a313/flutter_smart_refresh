import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_refresh/flutter_smart_refresh.dart';

/*
  this example will show you how to use vertical PageView as child in SmartRefresher(vertical refresh)
 */
class PageViewExample extends StatefulWidget {
  PageViewExample({Key key}) : super(key: key);

  @override
  PageViewExampleState createState() => PageViewExampleState();
}

class PageViewExampleState extends State<PageViewExample>
    with TickerProviderStateMixin {
  RefreshController _refreshController;
  int _lastReportedPage = 0;
  List<Widget> data = [];

  final PageController _pageController = PageController();

  void enterRefresh() {
    _refreshController.requestLoading();
  }

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: true);
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0 &&
            notification is ScrollUpdateNotification) {
          final PageMetrics metrics = notification.metrics as PageMetrics;
          final int currentPage = metrics.page.round();
          if (currentPage != _lastReportedPage) {
            _lastReportedPage = currentPage;
            // this will callback onPageChange()
            print("onPageChange + $currentPage");
          }
        }
        return false;
      },
      child: SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
        ),
        controller: _refreshController,
        header: MaterialClassicHeader(),
        onRefresh: () async {
          print("onRefresh");
          await Future.delayed(const Duration(milliseconds: 4000));

          if (mounted) setState(() {});
          _refreshController.refreshFailed();
        },
        child: CustomScrollView(
          physics: PageScrollPhysics(),
          controller: _pageController,
          slivers: <Widget>[
            SliverFillViewport(
                delegate: SliverChildListDelegate([
              Center(child: Text("第一页")),
              Center(child: Text("第二页")),
              Center(child: Text("第三页")),
              Center(child: Text("第四页"))
            ]))
          ],
        ),
        onLoading: () {
          print("onload");
          Future.delayed(const Duration(milliseconds: 2000)).then((val) {
            _refreshController.loadComplete();
          });
        },
      ),
    );
  }
}
