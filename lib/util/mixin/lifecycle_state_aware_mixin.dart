import 'package:flutter/material.dart';

mixin LifeCycleStateAwareMixin<T extends StatefulWidget> on State<T> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onResume: onResume,
      onPause: onPause,
      onDetach: onDetached,
      onInactive: onInactive,
      onHide: onHide,
    );
  }

  @protected
  @mustCallSuper
  void onResume() {}

  @protected
  @mustCallSuper
  void onInactive() {}

  @protected
  @mustCallSuper
  void onHide() {}

  @protected
  @mustCallSuper
  void onPause() {}

  @protected
  @mustCallSuper
  void onDetached() {}

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }
}
