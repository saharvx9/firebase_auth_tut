import 'package:firebase_auth_tut/pages/login/bloc/login_cubit.dart';
import 'package:firebase_auth_tut/widgets/dialog/app_dialog.dart';
import 'package:firebase_auth_tut/widgets/socialauth/social_auth.dart';
import 'package:firebase_auth_tut/widgets/textfield/edit_text.dart';
import 'package:firebase_auth_tut/widgets/textfield/password_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../utils/size_config.dart';
import '../../widgets/button/progress_button.dart';
import '../../widgets/dialog/dialog_state.dart';
import '../home/home_page.dart';

class LoginBody extends StatelessWidget {

  final LoginCubit cubit;

  const LoginBody({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: cubit,
      listener: (context, state) {
        switch(state.runtimeType){
          case DialogLoginState:
            final dialogRegisterState = state as DialogLoginState;
            final dialogState = dialogRegisterState.state;
            AppDialog.displayDialog(context, dialogState, onClick: () {
              if (dialogState.type != DialogType.success || dialogRegisterState.id == null) return;
              context.goNamed(HomePage.routeName, params: {"id": "${dialogRegisterState.id}"});
            });
            break;
          default:
            break;
        }
      },
      child: Column(
        children: [
          SocialAuth(onUserFinish: cubit.displayWelcomeUserDialog),
          SizedBox(height: SizeConfig.spacingExtraVertical),
          BlocBuilder<LoginCubit, LoginState>(
            bloc: cubit,
            buildWhen: (prev,next) => next is EmailLoginInput,
            builder: (context, baseState) {
              final state = (baseState is EmailLoginInput) ? baseState : null;
              return EditText(
                  hint: "Email",
                  initialValue: state?.input,
                  error: state?.error,
                  textInputType: TextInputType.emailAddress,
                  onTextChange: (input) => cubit.validField(type: LoginFieldType.email, input: input));
            },
          ),
          SizedBox(height: SizeConfig.spacingExtraVertical),
          BlocBuilder<LoginCubit, LoginState>(
            bloc: cubit,
            buildWhen: (prev,next) => next is PasswordLoginInput,
            builder: (context, baseState) {
              final state = (baseState is PasswordLoginInput) ? baseState : null;
              return PasswordEditText(
                  hint: "Password",
                  initialValue: state?.input,
                  error: state?.error,
                  onTextChange: (input) => cubit.validField(type: LoginFieldType.password, input: input));
            },
          ),
          SizedBox(height: SizeConfig.spacingExtraVertical),
          BlocBuilder<LoginCubit, LoginState>(
            bloc: cubit,
            buildWhen: (prev, next) => next is SubmitState,
            builder: (context, baseState) {
              final state = (baseState is SubmitState) ? baseState.buttonState : ButtonState.disable;
              return ProgressButton(state: state, text: "Log in", onClick: () => cubit.logIn());
            },
          ),
        ],
      ),
    );
  }
}
