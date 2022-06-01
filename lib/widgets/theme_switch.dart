import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum _SwitchProps { paddingLeft, color, icon, rotation }

class ThemeSwitch extends StatefulWidget {
  final Brightness initialValue;
  final Function(Brightness value) onCheck;

  const ThemeSwitch(
      {Key? key, this.initialValue = Brightness.light, required this.onCheck})
      : super(key: key);

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  late var _checked = widget.initialValue;
  late var _controller = _checked == Brightness.light ? CustomAnimationControl.playFromStart : CustomAnimationControl.playReverse;

  late final _tween = MultiTween<_SwitchProps>()
    ..add(_SwitchProps.paddingLeft, Tween(begin: 0.0, end: 20.0), const Duration(milliseconds: 500))
    ..add(_SwitchProps.color, ColorTween(begin: Theme.of(context).backgroundColor, end: Colors.yellow.shade700), const Duration(milliseconds: 500))
    ..add(_SwitchProps.icon, ConstantTween(Icons.dark_mode), const Duration(milliseconds: 250))
    ..add(_SwitchProps.icon, ConstantTween(Icons.light_mode), const Duration(milliseconds: 250))
    ..add(_SwitchProps.rotation, Tween(begin: -2 * pi, end: 0.0), const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return CustomAnimation<MultiTweenValues<_SwitchProps>>(
      tween: _tween,
      control: _controller,
      duration: _tween.duration * 1.2,
      curve: Curves.easeInOut,
      builder: _buildCheckbox,
    );
  }

  Widget _buildCheckbox(context, child, MultiTweenValues<_SwitchProps> animation) {
    return GestureDetector(
      onTap: () {
        _checked = _checked == Brightness.light ? Brightness.dark : Brightness.light;
        setState(() {
          _controller = _checked == Brightness.light
              ? CustomAnimationControl.playFromStart
              : CustomAnimationControl.playReverse;
        });
        widget.onCheck(_checked);
      },
      child: Container(
        decoration: _outerBoxDecoration(animation.get(_SwitchProps.color)),
        width: 50,
        height: 30,
        padding: const EdgeInsets.all(3.0),
        child: Stack(
          children: [
            Positioned(
                child: Padding(
              padding: EdgeInsets.only(
                  left: animation.get(_SwitchProps.paddingLeft)),
              child: Transform.rotate(
                angle: animation.get(_SwitchProps.rotation),
                child: Container(
                  decoration: _innerBoxDecoration(animation.get(_SwitchProps.color)),
                  width: 20,
                  child: Center(
                      child: Icon(
                    animation.get(_SwitchProps.icon),
                    size: 13,
                  )),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  BoxDecoration _innerBoxDecoration(color) => BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(25)), color: color);

  BoxDecoration _outerBoxDecoration(color) => BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        border: Border.all(
          width: 2,
          color: color,
        ),
      );
}
