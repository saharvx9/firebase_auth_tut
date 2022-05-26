import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:flutter/material.dart';

class FlutterFlexibleLogo extends StatelessWidget {

  final double size;

  const FlutterFlexibleLogo({Key? key, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(child: FlutterLogo(
      style: FlutterLogoStyle.markOnly, size: size,));

  }
}
