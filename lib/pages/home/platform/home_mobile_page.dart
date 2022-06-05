import 'dart:async';

import 'package:firebase_auth_tut/data/model/user/user.dart';
import 'package:firebase_auth_tut/pages/home/widgets/custom_flexible_space_bar.dart';
import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:firebase_auth_tut/widgets/switch/themeswitch/theme_switch.dart';
import 'package:flutter/material.dart';

class HomeMobilePage extends StatelessWidget {
  final User user;
  final Function() logOutClick;
  final StreamController<double> _sizeFontStreamController = StreamController<double>.broadcast();
  HomeMobilePage({Key? key, required this.user, required this.logOutClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.secondaryContainer,
      body: NestedScrollView(
        headerSliverBuilder: (context,innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle:
            NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: CustomFlexibleSpaceBar(
                imageUrl: user.imageUrl,
                backgroundColor: Colors.transparent,
                action: ThemeSwitch(),
                expandedHeight: 250,
                maxSizeImage: 110,
                minSizeImage: 35,
            onRatioChange: (ratio)=> _sizeFontStreamController.add(ratio)),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight*1.5),
          child: Container(
            padding: EdgeInsets.all(SizeConfig.spacingMediumVertical),
            decoration: BoxDecoration(
              color: theme.colorScheme.onBackground,
              borderRadius: const BorderRadiusDirectional.only(topStart: Radius.circular(20),topEnd: Radius.circular(20))
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _cardItem(user.email, Icons.email,theme),
                      _cardItem(user.dateStr, Icons.date_range ,theme),
                      _cardItem(user.gender?.name, user.gender?.icon ?? Icons.person ,theme),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: TextButton(child: Text("Log out",style: theme.textTheme.headline1?.copyWith(color: theme.colorScheme.primary,decoration: TextDecoration.underline),),
                    onPressed: () => logOutClick(),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardItem(String? text,IconData icon,ThemeData theme){
    return StreamBuilder<double>(
      initialData: SizeConfig.fontMedium,
      stream: _sizeFontStreamController.stream.map((ratio) => (ratio * SizeConfig.fontMini) + SizeConfig.fontSmallPlus),
      builder: (context, snapshot) {
        final fontSize = snapshot.data;
        return Card(
          margin: EdgeInsets.symmetric(vertical: SizeConfig.spacingSmallVertical),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            dense: true,
            leading: Icon(icon,size: fontSize,),
            title: Text(text ?? "",style: theme.textTheme.headline2?.copyWith(color: theme.colorScheme.secondary,fontSize: fontSize),),
          ),
        );
      }
    );
  }
}
