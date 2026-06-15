import 'package:flutter/cupertino.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';

class RefreshWidget extends StatelessWidget {
  const RefreshWidget({
    super.key,
    this.child,
    required this.onRefresh,
    this.onLoading,
    required this.refreshController,
    this.scrollController,
    this.refresherKey,
    this.footerHeight,
    this.physics = const BouncingScrollPhysics(),
  });

  final Widget? child;
  final double? footerHeight;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoading;
  final RefreshController refreshController;
  final ScrollController? scrollController;
  final Key? refresherKey;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return KRefreshWidgetConfig(
      footerHeight: footerHeight,
      child: SmartRefresher(
        physics: physics,
        key: refresherKey,
        scrollController: scrollController,
        controller: refreshController,
        enablePullDown: onRefresh != null,
        enablePullUp: onLoading != null,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: child,
      ),
    );
  }
}

class KRefreshWidgetConfig extends StatelessWidget {
  final Widget child;
  final double? footerHeight;

  const KRefreshWidgetConfig({
    super.key,
    required this.child,
    this.footerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => CustomHeader(
        builder: (context, mode) {
          Widget body = const SizedBox();
          if (mode == RefreshStatus.idle) {
            body = RefreshHelperWidget(
              icon: AppIcons.refresh,
              text: "Pull down to refresh",
            );
          } else if (mode == RefreshStatus.refreshing) {
            body = CupertinoActivityIndicator(
              radius: 10,
              color: AppColors.black.withValues(alpha: 0.6),
            );
          } else if (mode == RefreshStatus.failed) {
            body = RefreshHelperWidget(
              icon: AppIcons.closeCircle,
              text: "Failed to load data",
            );
          } else if (mode == RefreshStatus.canRefresh) {
            body = RefreshHelperWidget(
              icon: AppIcons.circleArrowUp,
              text: "Release to load",
            );
          } else if (mode == RefreshStatus.completed) {
            body = RefreshHelperWidget(
              icon: AppIcons.tickCircle,
              text: "Load Completed",
            );
          }
          return SizedBox(height: 45.0, child: Center(child: body));
        },
      ),
      footerBuilder: () => CustomFooter(
        height: footerHeight ?? 60,
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: (context, mode) {
          Widget body = const SizedBox();
          if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator(
              radius: 10,
              color: AppColors.white.withValues(alpha: 0.6),
            );
          } else if (mode == LoadStatus.failed) {
            body = RefreshHelperWidget(
              icon: AppIcons.closeCircle,
              text: "Failed to load data",
            );
          } else if (mode == LoadStatus.canLoading) {
            body = RefreshHelperWidget(
              icon: AppIcons.capsLock,
              text: "Release to load",
            );
          } else if (mode == LoadStatus.noMore) {
            body = RefreshHelperWidget(
              icon: AppIcons.tickCircle,
              text: "No more data to load",
            );
          }
          return SizedBox(
            height: footerHeight ?? 60,
            child: Center(child: body),
          );
        },
      ),
      enableScrollWhenRefreshCompleted: true,
      enableLoadingWhenFailed: false,
      child: child,
    );
  }
}

class RefreshHelperWidget extends StatelessWidget {
  final String icon;
  final String text;

  const RefreshHelperWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Iconify(icon, size: 24, color: CupertinoColors.systemGrey2)],
    );
  }
}
