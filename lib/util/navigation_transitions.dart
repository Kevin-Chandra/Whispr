import 'package:flutter/material.dart';

abstract class NavigationTransitions {
  static Widget slideRight(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = Curves.easeInOutCubic;

    final enter = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: curve));

    return SlideTransition(
      position: enter,
      child: child,
    );
  }

  static Widget slideRightWithExit(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = Curves.easeInOutCubic;

    final enter = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: curve));

    // Exit transition
    final exit = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve));

    return SlideTransition(
      position: enter,
      child: SlideTransition(
        position: exit,
        child: child,
      ),
    );
  }

  static Widget slideLeft(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = Curves.easeInOutCubic;

    final enter = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: curve));

    return SlideTransition(
      position: enter,
      child: child,
    );
  }

  static Widget slideLeftWithExit(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = Curves.easeInOutCubic;

    final enter = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: curve));

    // Exit transition
    final exit = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0),
    ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve));

    return SlideTransition(
      position: enter,
      child: SlideTransition(
        position: exit,
        child: child,
      ),
    );
  }

  static Widget slideDown(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = Curves.easeInOutCubic;

    final enter = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: curve));

    return SlideTransition(
      position: enter,
      child: child,
    );
  }

  static Widget slideDownWithExit(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = Curves.easeInOutCubic;

    final enter = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: curve));

    // Exit transition
    final exit = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve));

    return SlideTransition(
      position: enter,
      child: SlideTransition(
        position: exit,
        child: child,
      ),
    );
  }

  static Widget slideUp(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = Curves.easeInOutCubic;

    final enter = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: curve));

    return SlideTransition(
      position: enter,
      child: child,
    );
  }

  static Widget slideUpWithExit(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = Curves.easeInOutCubic;

    final enter = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: curve));

    // Exit transition
    final exit = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve));

    return SlideTransition(
      position: enter,
      child: SlideTransition(
        position: exit,
        child: child,
      ),
    );
  }
}
