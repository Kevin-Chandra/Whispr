import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:whispr/presentation/router/navigation_coordinator.dart';
import 'package:whispr/presentation/router/navigation_paths.dart';
import 'package:whispr/presentation/router/router_config.gr.dart';
import 'package:whispr/util/mixin/lifecycle_state_aware_mixin.dart';

mixin AppLockMixin<T extends StatefulWidget> on LifeCycleStateAwareMixin<T> {
  bool get shouldShowLockScreen;

  bool _locked = false;

  @override
  void onHide() {
    super.onHide();

    if (!shouldShowLockScreen) {
      return;
    }

    _locked = true;
  }

  @override
  void onResume() {
    super.onResume();

    _showLockedScreen();
  }

  void showLockedScreenForAppLaunch() {
    if (!shouldShowLockScreen) {
      return;
    }

    _locked = true;
    _showLockedScreen();
  }

  void didUnlock() {
    _locked = false;
    NavigationCoordinator.navigatorPop(context: context);
  }

  void _showLockedScreen() {
    if (!_locked) {
      return;
    }

    // Pop the inactive screen.
    if (context.router.currentPath == WhisprNavigationPaths.inactivePath) {
      NavigationCoordinator.navigatorPop(context: context);
    }

    // If currentPath is not locked route, push locked route.
    if (!_isTopRouteLockedRoute()) {
      context.router.push(AppLockedRoute());
    }
  }

  bool _isTopRouteLockedRoute() =>
      context.router.currentPath == WhisprNavigationPaths.lockedPath;
}
