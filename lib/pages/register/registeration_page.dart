import 'dart:async';

import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:firebase_auth_tut/widgets/gender_drop_down.dart';
import 'package:firebase_auth_tut/widgets/textfield/date_picker_from_field.dart';
import 'package:firebase_auth_tut/widgets/textfield/edit_text.dart';
import 'package:firebase_auth_tut/widgets/progress_button.dart';
import 'package:firebase_auth_tut/widgets/theme_appbar.dart';
import 'package:flutter/material.dart';

import '../../widgets/flutter_flexible_logo.dart';

class RegistrationPage extends StatefulWidget {

  static const routeName = "/register";

  const RegistrationPage({Key? key,}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final _buttonStream = StreamController<ButtonState>.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(title: "Register",),
      body: Padding(
        padding: EdgeInsetsDirectional.all(SizeConfig.spacingNormalVertical,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlutterFlexibleLogo(title: "Register", size: SizeConfig.screenHeight * 0.4),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: SizeConfig.spacingMediumVertical),
                EditText(
                    hint: "email",
                    onTextChange: (input) {}),
                SizedBox(height: SizeConfig.spacingMediumVertical),
                EditText(
                    hint: "password",
                    onTextChange: (input) {}),
              ],
            ),
            SizedBox(height: SizeConfig.spacingMediumVertical),
            // OutlinedButton(onPressed: () {}, child: const Text("submit")),
            StreamBuilder<ButtonState>(
                initialData: ButtonState.enable,
                stream: _buttonStream.stream,
                builder: (context, snapshot) {
                  return ProgressButton(state: snapshot.data!, text: "submit", onClick: () async {
                    _buttonStream.add(ButtonState.loading);
                    await Future.delayed(const Duration(seconds: 2));
                    _buttonStream.add(ButtonState.enable);
                  });
                }
            )
          ],
        ),
      ),
    );
  }
}


