import 'package:firebase_auth_tut/data/model/user/user.dart';
import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:firebase_auth_tut/widgets/button/progress_button.dart';
import 'package:firebase_auth_tut/widgets/socialauth/social_auth_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialAuth extends StatefulWidget {
  final SocialAuthCubit cubit;
  final Function(User user) onUserFinish;

  SocialAuth({Key? key, required this.onUserFinish})
      : cubit = SocialAuthCubit(),
        super(key: key);



  /// Why ignore?!
  /// From the docs: https://dart-lang.github.io/linter/lints/no_logic_in_create_state.html
  /// this scenario looks bad but this is correct behavior only "passing data to State objects using
  /// custom constructor parameters should also be avoided!!! and so further, the State constructor is required to be passed no arguments."
  /// we are not sending any data to constructor look for an example in flutter [CupertinoDatePicker]
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    if (kIsWeb) return _SupportSocialAuthState();
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return _SupportSocialAuthState();
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.windows:
        return _NotSupportAuthSocial();
    }
  }
}

class _SupportSocialAuthState extends State<SocialAuth> {
  @override
  Widget build(BuildContext context) {
    final size = SizeConfig.screenHeight * 0.04;
    return BlocListener<SocialAuthCubit, SocialAuthState>(
      bloc: widget.cubit,
      listenWhen: (prev,current)=> current is UserState,
      listener: (_, state) {
        if(state is UserState == false) return;
        final user = (state as UserState).user;
        widget.onUserFinish(user);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.spacingMediumHorizontal),
        child: Row(
          children: [
            BlocSelector<SocialAuthCubit, SocialAuthState, GoogleAuthState?>(
              bloc: widget.cubit,
              selector: (state) {
                return (state is GoogleAuthState) ? state : null;
              },
              builder: (context, googleState) {
                final buttonState = googleState?.state ?? ButtonState.enable;
                return _button(
                    state: buttonState,
                    type: SocialType.google,
                    context: context,
                    child: Container(
                        height: size,
                        width: size,
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        child: Center(
                            child: Icon(SocialType.google.icon, size: SizeConfig.screenHeight * 0.03, color: Colors.white)
                        )
                    ));
              },
            ),
            BlocSelector<SocialAuthCubit, SocialAuthState, FacebookAuthState?>(
              bloc: widget.cubit,
              selector: (state) => (state is FacebookAuthState) ? state : null,
              builder: (context, facebookState) {
                final buttonState = facebookState?.state ?? ButtonState.enable;
                return _button(
                    state: buttonState,
                    type: SocialType.facebook,
                    context: context,
                    child: Icon(SocialType.facebook.icon, color: Colors.blue, size: size,));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _button(
      {required ButtonState state,
      required Widget child,
      required SocialType type,
      required BuildContext context}) {
    final theme = Theme.of(context);
    final style = theme.textTheme.subtitle2?.copyWith(fontStyle: FontStyle.italic, color: theme.colorScheme.secondary);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ProgressButton(
          background: theme.colorScheme.primaryContainer,
          state: state,
          onClick: () => widget.cubit.login(type),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: child),
                SizedBox(width: SizeConfig.spacingSmallHorizontal),
                Flexible(child: Text(type.text, overflow: TextOverflow.ellipsis, style: style))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NotSupportAuthSocial extends State<SocialAuth> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
