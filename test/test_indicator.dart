import 'package:flutter_smart_refresh/flutter_smart_refresh.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicatorState, RefreshIndicator;

class TestHeader extends RefreshIndicator {
  const TestHeader();
  @override
  State<StatefulWidget> createState() {
    return _TestHeaderState();
  }
}

class _TestHeaderState extends RefreshIndicatorState<TestHeader> {
  @override
  Widget buildContent(BuildContext context, RefreshStatus? mode) {
    return Text(mode == RefreshStatus.idle
        ? "idle"
        : mode == RefreshStatus.refreshing
            ? "refreshing"
            : mode == RefreshStatus.canRefresh
                ? "canRefresh"
                : mode == RefreshStatus.canTwoLevel
                    ? "canTwoLevel"
                    : mode == RefreshStatus.completed
                        ? "completed"
                        : mode == RefreshStatus.failed
                            ? "failed"
                            : mode == RefreshStatus.twoLevelClosing
                                ? "twoLevelClosing"
                                : mode == RefreshStatus.twoLevelOpening
                                    ? "twoLevelOpening"
                                    : "twoLeveling");
  }
}

class TestFooter extends LoadIndicator {
  const TestFooter();
  @override
  State<StatefulWidget> createState() {
    return _TestFooterState();
  }
}

class _TestFooterState extends LoadIndicatorState<TestFooter> {
  @override
  Widget buildContent(BuildContext context, LoadStatus? mode) {
    return Text(mode == LoadStatus.failed
        ? "failed"
        : mode == LoadStatus.loading
            ? "loading"
            : mode == LoadStatus.idle
                ? "idle"
                : "noData");
  }
}
