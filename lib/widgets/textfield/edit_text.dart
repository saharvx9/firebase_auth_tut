import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  final String? hint;
  final String? initialValue;
  final Function(String? input) onTextChange;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final bool enable;

  const EditText(
      {Key? key,
      required this.onTextChange,
      required this.hint,
      this.initialValue,
      this.keyboardType,
      this.textInputAction = TextInputAction.next,
      this.enable = true})
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
      keyboardType: widget.keyboardType,
      initialValue: widget.initialValue,
      decoration: InputDecoration(
        labelText: widget.hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}


