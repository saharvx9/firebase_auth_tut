import 'package:firebase_auth_tut/data/model/user/user.dart';
import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:firebase_auth_tut/widgets/pickimagedisplay/pick_display_image.dart';
import 'package:firebase_auth_tut/widgets/theme_appbar.dart';
import 'package:flutter/material.dart';

class HomeOtherPage extends StatelessWidget {
  final User user;
  final Function() logOutClick;
  const HomeOtherPage({Key? key, required this.user, required this.logOutClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: ThemeAppBar(title: "Welcome",),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.spacingExtraVertical),
        child: Row(
          children: [
            Expanded(child: _firstInfo(theme)),

            Expanded(child: _secondInfo(theme)),
          ],
        ),
      ),
    );
  }

  Widget _firstInfo(ThemeData theme){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]
          ),
          child: PickDisplayImage(image: user.imageUrl,pickImage: false, size: SizeConfig.screenHeight * 0.4,),
        ),
        SizedBox(height: SizeConfig.spacingExtraVertical),
        Text(user.name??"",style: theme.textTheme.headline1?.copyWith(color: theme.colorScheme.secondary)),
      ],
    );
  }

  Widget _secondInfo(ThemeData theme){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            bottom: SizeConfig.spacingNormalVertical,
            start:SizeConfig.spacingMediumVertical,
            end: SizeConfig.spacingMediumVertical),
        child: Column(
          children: [
            _subtitle(user.email, Icons.email,theme),
            _subtitle(user.dateStr, Icons.date_range ,theme),
            _subtitle(user.gender?.name, user.gender?.icon ?? Icons.person ,theme),
            const Spacer(),
            TextButton(child: Text("Log out",style: theme.textTheme.headline1?.copyWith(color: theme.colorScheme.primary,decoration: TextDecoration.underline),),
              onPressed: () => logOutClick(),)
          ],
        ),
      ),
    );
  }

  Widget _subtitle(String? text,IconData icon,ThemeData theme){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.spacingNormalVertical),
      child: ListTile(
        leading: Icon(icon,size: SizeConfig.screenWidth * 0.05,),
        title: Text(text ?? "",style: theme.textTheme.headline2?.copyWith(color: theme.colorScheme.secondary),),
      ),
    );
  }
}


