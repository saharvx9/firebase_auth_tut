import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:firebase_auth_tut/widgets/button/primary_button.dart';
import 'package:firebase_auth_tut/widgets/pickimagedisplay/pick_display_image.dart';
import 'package:flutter/material.dart';

import 'dialog_state.dart';



class AppDialog extends StatefulWidget {

  final DialogState state;
  final Function()? onClick;

  const AppDialog({Key? key, required this.state, this.onClick}) : super(key: key);

  static Future<void> displayDialog(BuildContext context, DialogState state,{Function()? onClick}) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: false,
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
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(
                      child: widget.state.imageUrl != null
                          ? Hero(tag: "dialog_image_tag", child: PickDisplayImage(size: 100, pickImage: false, image: widget.state.imageUrl))
                          : Icon(widget.state.icon, size: 50, color: Colors.white,)),
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
