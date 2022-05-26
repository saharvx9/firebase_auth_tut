import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:flutter/material.dart';

class FlutterFlexibleLogo extends StatelessWidget {

  final String title;
  final double size;

  const FlutterFlexibleLogo({Key? key, required this.title, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: FlutterLogo(style: FlutterLogoStyle.markOnly,size: size,)),
          Text(title,style: Theme.of(context).textTheme.headline6,)
        ],
      ),
    );
  }
}
