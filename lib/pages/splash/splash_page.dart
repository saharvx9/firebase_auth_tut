import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_tut/pages/home/home_page.dart';
import 'package:firebase_auth_tut/pages/register/registeration_page.dart';
import 'package:firebase_auth_tut/pages/splash/splash_cubit.dart';
import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {

  static const routeName = "/";
  final SplashCubit cubit;
  const SplashPage({Key? key, required this.cubit}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  late final _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
  late final _slideAnimation = Tween(begin: -2.0, end: 0.0).animate(CurvedAnimation(parent: _animController, curve: Curves.linearToEaseOut));
  late final _sizeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animController, curve: Curves.easeInCubic));

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _animController.forward();
    });

    _animController.addStatusListener((status) {
      if(status == AnimationStatus.completed) widget.cubit.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<SplashCubit, SplashState>(
      bloc: widget.cubit,
      listener: (_, state) =>_navigate(state),
      child: Material(
        child: Center(
          child: AnimatedBuilder(
            animation: _animController,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                  transform: Matrix4.translationValues(
                      _slideAnimation.value * SizeConfig.screenHeight * 0.3,
                      _slideAnimation.value * -SizeConfig.screenHeight * 0.3, 0),
                  child: Hero(
                    tag: "tag_fire_logo",
                    child: SvgPicture.asset("assets/images/fire_logo.svg",
                        height: _sizeAnimation.value * SizeConfig.screenHeight * 0.3,
                        width: _sizeAnimation.value * SizeConfig.screenHeight * 0.3),
                  ));
            },
          ),
        ),
      ),
    );
  }

  _navigate(SplashState state) async {
    await Future.delayed(const Duration(milliseconds: 500)); /*delay for animation*/
    if (!mounted) return;
    switch(state){
      case SplashState.loggedIn:
        final params = {"id": "${FirebaseAuth.instance.currentUser?.uid}"};
        context.goNamed(HomePage.routeName, params: params);
        break;
      case SplashState.noUserExist:
        context.go(RegistrationPage.routeName);
        break;
      case SplashState.idle:
        //ignore still waiting for answer
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
    widget.cubit.close();
  }
}
