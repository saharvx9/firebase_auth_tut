import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:flutter/material.dart';

enum ButtonState { loading, disable, enable }

class ProgressButton extends StatefulWidget {
  final ButtonState state;
  final Function() onClick;
  final String text;

  const ProgressButton({Key? key,
    required this.state,
    required this.onClick,
    required this.text})
      : super(key: key);

  @override
  State<ProgressButton> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {

  final _buttonHeight = 45.0;
  late final _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500));

  late final _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200));

  late final _widthAnimation = Tween<double>(
      begin: SizeConfig.screenWidth, end: _buttonHeight)
      .animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.decelerate));

  late final _borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(10),
      end: BorderRadius.circular(50)
  ).animate(CurvedAnimation(parent: _buttonController, curve: Curves.linear));

  late final _opacityAnimation = Tween(begin: 1.0, end: 0.0)
      .animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.decelerate));


  @override
  void initState() {
    super.initState();
    _buttonController.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
        case AnimationStatus.completed:
          _fadeController.reverse();
          break;
        default:
          break;
      }
    });
  }

  @override
  void didUpdateWidget(covariant ProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != ButtonState.loading &&
        widget.state == ButtonState.loading) {
      _fadeController.forward();
      _buttonController.stop();
      _buttonController.forward();
    }

    if (oldWidget.state == ButtonState.loading &&
        widget.state != ButtonState.loading) {
      _fadeController.forward();
      _buttonController.stop();
      _buttonController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _buttonController, builder: (context, child) {
      BoxDecoration decoration;
      switch (widget.state) {
        case ButtonState.disable:
          decoration = BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: _borderRadiusAnimation.value);
          break;
        case ButtonState.enable:
        case ButtonState.loading:
          decoration = BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: _borderRadiusAnimation.value);
          break;
      }

      Widget buttonContent;
      switch (widget.state) {
        case ButtonState.loading:
          buttonContent = SizedBox(
            height: _buttonHeight,
            width: _widthAnimation.value,
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: CircularProgressIndicator(strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
            ),
          );
          break;
        case ButtonState.disable:
        case ButtonState.enable:
          buttonContent = SizedBox(
            height: _buttonHeight,
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(widget.text, textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle1,)),
            ),
          );
          break;
      }

      return Material(
        color: Colors.transparent,
        elevation: 0,
        child: InkWell(
          onTap: widget.state == ButtonState.enable ? () {
            widget.onClick();
          } : null,
          borderRadius: _borderRadiusAnimation.value,
          child: Center(
            child: Ink(
              width: _widthAnimation.value,
              decoration: decoration,
              child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: buttonContent),
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _buttonController.dispose();
    _fadeController.dispose();
  }
}


