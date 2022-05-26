import 'package:firebase_auth_tut/widgets/textfield/edit_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_tut/utils/ext/string_ext.dart';

class PasswordEditText extends StatefulWidget {
  final String hint;
  final String? error;
  final String? initialValue;
  final Function(String? input) onTextChange;

  const PasswordEditText(
      {Key? key,
      required this.hint,
      required this.onTextChange,
      this.error,
      this.initialValue})
      : super(key: key);

  @override
  State<PasswordEditText> createState() => _PasswordEditTextState();
}

class _PasswordEditTextState extends State<PasswordEditText> {
  var _visible = false;

  @override
  Widget build(BuildContext context) {
    return EditText(
        onTextChange: widget.onTextChange,
        obscureText: !_visible,
        error: widget.error,
        initialValue: widget.initialValue,
        suffixIcon: IconButton(
          icon: Icon(_visible ? Icons.visibility : Icons.visibility_off,
              color: widget.error.isNotNullOrEmpty
                  ? Theme.of(context).colorScheme.error
                  : null),
          onPressed: () => setState(() => _visible = !_visible),
        ),
        hint: widget.hint);
  }
}
