import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return const Material(
        child: Center(
      child: Text(
        "404 error",
        style: TextStyle(color: Colors.red, fontSize: 50),
      ),
    ));
  }
}
