import 'package:firebase_auth_tut/utils/ext/string_ext.dart';
import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  final String? hint;
  final String? initialValue;
  final Function(String? input) onTextChange;
  final TextInputType? textInputType;
  final TextInputAction textInputAction;
  final bool enable;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? error;

  const EditText({Key? key,
    required this.onTextChange,
    required this.hint,
    this.initialValue,
    this.textInputType,
    this.textInputAction = TextInputAction.next,
    this.enable = true,
    this.suffixIcon,
    this.obscureText = false,
    this.error})
      : super(key: key);

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enable,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      onChanged: widget.onTextChange,
      style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Theme.of(context).colorScheme.secondary),
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      initialValue: widget.initialValue,
      decoration: InputDecoration(
        labelText: widget.hint,
        suffixIcon: widget.suffixIcon,
        errorText: widget.error,
        errorStyle: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.error),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}


