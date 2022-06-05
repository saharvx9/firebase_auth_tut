import 'package:firebase_auth_tut/pages/home/home_page.dart';
import 'package:firebase_auth_tut/pages/login/login_page.dart';
import 'package:firebase_auth_tut/pages/register/bloc/registration_cubit.dart';
import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:firebase_auth_tut/widgets/dialog/app_dialog.dart';
import 'package:firebase_auth_tut/widgets/pickimagedisplay/pick_display_image.dart';
import 'package:firebase_auth_tut/widgets/socialauth/social_auth.dart';
import 'package:firebase_auth_tut/widgets/textfield/edit_text.dart';
import 'package:firebase_auth_tut/widgets/textfield/password_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/button/progress_button.dart';
import '../../widgets/dialog/dialog_state.dart';
import '../../widgets/gender_drop_down.dart';
import '../../widgets/textfield/date_picker_from_field.dart';


class RegistrationBody extends StatelessWidget {
  final RegistrationCubit cubit;
  const RegistrationBody({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationCubit, RegistrationState>(
      bloc: cubit,
      listenWhen: (prev, current) => current is DialogRegisterState,
      listener: (ctx, state) {
        switch (state.runtimeType) {
          case DialogRegisterState:
            final dialogRegisterState = state as DialogRegisterState;
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialAuth(onUserFinish: (user)=> cubit.displayWelcomeUserDialog(user)),
        StreamBuilder<ImageState>(
          stream: cubit.stream.where((event) => event is ImageState).map((event) => event as ImageState),
          builder: (context, snapshot) {
            final bytes = snapshot.data?.image;
            return PickDisplayImage(
              image: bytes,
              size: 150,
              onPickImage: (image) => cubit.pickImage(image),
            );
          }
        ),

        SizedBox(height: SizeConfig.spacingMediumVertical),

        BlocBuilder<RegistrationCubit, RegistrationState>(
                    bloc: cubit,
                    buildWhen: (prev, next) => next is EmailInputState,
                    builder: (context, baseState) {
                      final state = (baseState is EmailInputState) ? baseState : null;
                      return EditText(
                          hint: "Email",
                          initialValue: state?.input,
                          error: state?.error,
                          textInputType: TextInputType.emailAddress,
                          onTextChange: (input) => cubit.validField(type: RegistrationFieldType.email, input: input));
                    },
                  ),
        SizedBox(height: SizeConfig.spacingMediumVertical),
        //User name
        BlocBuilder<RegistrationCubit, RegistrationState>(
          bloc: cubit,
          buildWhen: (prev, next) => next is UserNameInputState,
          builder: (context, baseState) {
            final state = (baseState is UserNameInputState) ? baseState : null;
            return EditText(
                hint: "User name",
                initialValue: state?.input,
                error: state?.error,
                textInputType: TextInputType.name,
                onTextChange: (input) => cubit.validField(type: RegistrationFieldType.userName, input: input));
          },
        ),
        SizedBox(height: SizeConfig.spacingMediumVertical),
        //Password edit text
        BlocBuilder<RegistrationCubit, RegistrationState>(
          bloc: cubit,
          buildWhen: (prev, next) => next is PasswordInputState,
          builder: (context, baseState) {
            final state = (baseState is PasswordInputState) ? baseState : null;
            return PasswordEditText(
                hint: "password",
                initialValue: state?.input,
                error: state?.error,
                onTextChange: (input) => cubit.validField(type: RegistrationFieldType.password, input: input));
          },
        ),

        SizedBox(height: SizeConfig.spacingMediumVertical),
        BlocBuilder<RegistrationCubit, RegistrationState>(
          bloc: cubit,
          buildWhen: (prev, next) => next is ConfirmPasswordInputState,
          builder: (context, baseState) {
            final state = (baseState is ConfirmPasswordInputState) ? baseState : null;
            return PasswordEditText(
                hint: "confirm password",
                error: state?.error,
                initialValue: state?.input,
                onTextChange: (input) => cubit.validField(type: RegistrationFieldType.confirmPassword, input: input));
          },
        ),

        SizedBox(height: SizeConfig.spacingMediumVertical),

        BlocBuilder<RegistrationCubit, RegistrationState>(
          bloc: cubit,
          buildWhen: (prev, next) => next is GenderState,
          builder: (context, baseState) {
            final state = (baseState is GenderState) ? baseState : null;
            return GenderDropDown(
                initialValue: state?.input,
                onSelect: (value) => cubit.validField(type: RegistrationFieldType.gender, input: value));
          },
        ),

        SizedBox(height: SizeConfig.spacingNormalVertical),

        BlocBuilder<RegistrationCubit, RegistrationState>(
          bloc: cubit,
          buildWhen: (prev, next) => next is DateInputState,
          builder: (context, baseState) {
            final state = (baseState is DateInputState) ? baseState : null;
            return DatePickerFromField(
                hint: "Birthday",
                initialValue: state?.input,
                onDatePick: (date) => cubit.validField(type: RegistrationFieldType.date, input: date));
          },
        ),

        SizedBox(height: SizeConfig.spacingExtraVertical),

        BlocBuilder<RegistrationCubit, RegistrationState>(
          bloc: cubit,
          buildWhen: (prev, next) => next is SubmitState,
          builder: (context, baseState) {
            final state = (baseState is SubmitState) ? baseState.buttonState : ButtonState.disable;
            return ProgressButton(state: state, text: "Submit", onClick: () => cubit.signIn());
          },
        ),

        TextButton(
            child: Text("Already have a user",style: Theme.of(context).textTheme.button?.copyWith(color: Theme.of(context).colorScheme.primary,decoration: TextDecoration.underline)),
            onPressed: () => context.push(LoginPage.routeName))
      ],
    ),
    );
  }
}
