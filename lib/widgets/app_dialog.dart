import 'dart:ui';

import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:firebase_auth_tut/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';

enum DialogType {
  error(Icons.error_outline),
  success(Icons.verified_outlined);

  final IconData icon;
  const DialogType(this.icon);

}
class DialogState {
  final String title;
  final String subtitle;
  final DialogType type;
  IconData get icon => type.icon;

  DialogState(this.title, this.subtitle, this.type);
}

class AppDialog extends StatefulWidget {

  final DialogState state;
  final Function()? onClick;

  const AppDialog({Key? key, required this.state, this.onClick}) : super(key: key);

  static Future<void> displayDialog(BuildContext context, DialogState state,{Function()? onClick}) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 300),
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder: (_, anim1, anim2) => AppDialog(state: state,onClick: onClick));
  }

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {

  late final _theme = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.3),
        child: Container(
          height: SizeConfig.screenHeight * 0.4,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(child: Icon(widget.state.icon,size: 50,color: Colors.white,)),
                ),
              ),

              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.state.title,style: _theme.textTheme.headline2?.copyWith(color: _theme.colorScheme.secondary)),
                    Text(widget.state.subtitle,style: _theme.textTheme.subtitle2?.copyWith(color: _theme.colorScheme.secondary)),
                    PrimaryButton(text: "ok", onClick: () {
                      widget.onClick?.call();
                      Navigator.pop(context);
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
