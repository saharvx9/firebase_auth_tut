import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _pattern = "dd/mm/yyyy";
String? _toText(DateTime? dateTime) {
  if (dateTime == null) return null;
  return DateFormat(_pattern).format(dateTime);
}

class DatePickerFromField extends StatefulWidget {
  final Function(DateTime value) onDatePick;
  final String hint;
  final DateTime? initialValue;

  const DatePickerFromField({Key? key,
    required this.onDatePick,
    required this.hint,
    this.initialValue})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    if(kIsWeb) return _DatePickerOtherPlatformsFromFieldState();
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.iOS:
        return _DatePickerOtherIOSFromFieldState();
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return _DatePickerOtherPlatformsFromFieldState();
    }
  }
}

class _DatePickerOtherPlatformsFromFieldState extends State<DatePickerFromField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = _toText(widget.initialValue) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickDate,
      child: TextFormField(
        controller: _controller,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Theme.of(context).colorScheme.secondary),
        enabled: false,
        decoration: InputDecoration(
          labelText: widget.hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  _pickDate() async {
    final now = DateTime.now();
    final result = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now.subtract(const Duration(days: 365 * 80)),
        lastDate: now.add(const Duration(days: 7)));
    if (result == null) return;
    _controller.text = _toText(result) ?? "";
    widget.onDatePick(result);
  }
}

class _DatePickerOtherIOSFromFieldState extends State<DatePickerFromField> {
  final _controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    _controller.text = _toText(widget.initialValue) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickDate,
      child: TextFormField(
        controller: _controller,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Theme.of(context).colorScheme.secondary),
        enabled: false,
        decoration: InputDecoration(
          labelText: widget.hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  _pickDate() {
    final now = DateTime.now();
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        builder: (ctx) => CupertinoDatePicker(
            initialDateTime: now,
            minimumYear: 1900,
            maximumDate: now.add(const Duration(days: 7)),
            onDateTimeChanged: (result) {
              _controller.text = _toText(result) ?? "";
              widget.onDatePick(result);
              Navigator.pop(ctx);
            }));
  }
}

