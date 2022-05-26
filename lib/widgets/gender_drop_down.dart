import 'package:firebase_auth_tut/data/model/gender.dart';
import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:flutter/material.dart';

class GenderDropDown extends StatefulWidget {
  final Function(Gender value) onSelect;
  final Gender? initialValue;

  const GenderDropDown({Key? key, required this.onSelect, this.initialValue})
      : super(key: key);

  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  final _list = Gender.values;
  late final _style = Theme.of(context).textTheme.subtitle1;
  Gender? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Gender?>(
        hint: Text("select gender",style: _style?.copyWith(color: Theme.of(context).colorScheme.onSurface)),
        value: _selected,
        style: _style?.copyWith(color: Theme.of(context).colorScheme.secondary),
        items: _list.map((item) => _genderItem(item)).toList(),
        onChanged: (value) {
          setState(() => _selected = value);
          if (value == null) return;
          widget.onSelect(value);
        });
  }

  DropdownMenuItem<Gender?> _genderItem(Gender item) {
    return DropdownMenuItem(
        value: item,
        child: Row(
          children: [
            Icon(item.icon, size: SizeConfig.screenHeight * 0.02,),
            SizedBox(width: SizeConfig.spacingSmallHorizontal,),
            Text(item.name),
          ],
        ));
  }
}
