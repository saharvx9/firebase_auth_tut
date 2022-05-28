import 'package:firebase_auth_tut/pages/login/bloc/login_cubit.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";
  final LoginCubit cubit;

  const LoginPage({Key? key, required this.cubit}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
