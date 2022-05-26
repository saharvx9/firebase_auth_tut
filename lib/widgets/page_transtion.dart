import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PageTransitionType {
  fade,
  scale,
  rightToLeft,
  leftToRight,
  topToBottom,
  bottomToTop,
  none,
  rotate;
}

class PageTransition<T> extends CustomTransitionPage<T> {
  /// Alignment for transitions
  final Alignment? alignment;

  /// Curves for transitions
  final Curve curve;

  PageTransition({
    PageTransitionType type = PageTransitionType.none,
    required super.child,
    super.maintainState,
    super.fullscreenDialog,
    super.opaque,
    super.barrierDismissible,
    super.barrierColor,
    super.barrierLabel,
    super.transitionDuration = const Duration(milliseconds: 300),
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    this.alignment,
    this.curve = Curves.decelerate,
  }) : super(transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          switch (type) {
            case PageTransitionType.fade:
              return FadeTransition(
                  opacity: CurvedAnimation(parent: animation, curve: curve),
                  child: child);
            case PageTransitionType.scale:
              return ScaleTransition(
                alignment: alignment!,
                scale: CurvedAnimation(
                  parent: animation,
                  curve: Interval(
                    0.00,
                    0.50,
                    curve: curve,
                  ),
                ),
                child: child,
              );
            case PageTransitionType.rightToLeft:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: animation, curve: curve)),
                child: child,
              );
            case PageTransitionType.leftToRight:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: animation, curve: curve)),
                child: child,
              );
            case PageTransitionType.rotate:
              return RotationTransition(
                alignment: alignment!,
                turns: animation,
                child: ScaleTransition(
                  alignment: alignment,
                  scale: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
              );
            case PageTransitionType.topToBottom:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: animation, curve: curve)),
                child: child,
              );
            case PageTransitionType.bottomToTop:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: animation, curve: curve)),
                child: child,
              );
            default:
              return child;
          }
        });
}

