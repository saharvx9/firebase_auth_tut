import 'package:firebase_auth_tut/pages/home/home_page.dart';
import 'package:firebase_auth_tut/pages/login/login_page.dart';
import 'package:firebase_auth_tut/pages/register/bloc/registration_cubit.dart';
import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:firebase_auth_tut/widgets/app_dialog.dart';
import 'package:firebase_auth_tut/widgets/pickimagedisplay/pick_display_image.dart';
import 'package:firebase_auth_tut/widgets/socialauth/social_auth.dart';
import 'package:firebase_auth_tut/widgets/textfield/edit_text.dart';
import 'package:firebase_auth_tut/widgets/textfield/password_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/button/progress_button.dart';
import '../../widgets/gender_drop_down.dart';
import '../../widgets/textfield/date_picker_from_field.dart';


class RegistrationBody extends StatelessWidget {
  final RegistrationCubit cubit;
  const RegistrationBody({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationCubit, RegistrationState>(
      bloc: cubit,
      listenWhen: (prev,current)=> current is DialogRegisterState,
      listener: (ctx, state) {
        switch(state.runtimeType) {
          case DialogRegisterState:
            final dialogRegisterState = state as DialogRegisterState;
            final dialogState = dialogRegisterState.state;
            AppDialog.displayDialog(context, dialogState,onClick: (){
              if(dialogState.type != DialogType.success && dialogRegisterState.id != null) return;
              try{
                context.goNamed(HomePage.routeName, params: {"id": "${dialogRegisterState.id}"});
              }catch(e,s){
                print("show error: $e\n stackTrace: $s");
              }
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
          //Email edit text
          BlocSelector<RegistrationCubit, RegistrationState, EmailInputState?>(
            bloc: cubit,
            selector: (state) => (state is EmailInputState) ? state : null,
            builder: (context, state) {
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
          BlocSelector<RegistrationCubit, RegistrationState,
              UserNameInputState?>(
            bloc: cubit,
            selector: (state) => (state is UserNameInputState) ? state : null,
            builder: (context, state) {
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
          BlocSelector<RegistrationCubit, RegistrationState,
              PasswordInputState?>(
            bloc: cubit,
            selector: (state) => (state is PasswordInputState) ? state : null,
            builder: (context, state) {
              return PasswordEditText(
                  hint: "password",
                  initialValue: state?.input,
                  error: state?.error,
                  onTextChange: (input) => cubit.validField(type: RegistrationFieldType.password, input: input));
            },
          ),

          SizedBox(height: SizeConfig.spacingMediumVertical),
          BlocSelector<RegistrationCubit, RegistrationState,
              ConfirmPasswordInputState?>(
            bloc: cubit,
            selector: (state) =>
            (state is ConfirmPasswordInputState) ? state : null,
            builder: (context, state) {
              return PasswordEditText(
                  hint: "confirm password",
                  error: state?.error,
                  initialValue: state?.input,
                  onTextChange: (input) => cubit.validField(type: RegistrationFieldType.confirmPassword, input: input));
            },
          ),

          SizedBox(height: SizeConfig.spacingMediumVertical),

          BlocSelector<RegistrationCubit, RegistrationState, GenderState?>(
            bloc: cubit,
            selector: (state) => (state is GenderState) ? state : null,
            builder: (context, state) {
              return GenderDropDown(
                  initialValue: state?.input,
                  onSelect: (value) => cubit.validField(type: RegistrationFieldType.gender, input: value));
            },
          ),

          SizedBox(height: SizeConfig.spacingNormalVertical),

          BlocSelector<RegistrationCubit, RegistrationState, DateInputState?>(
            bloc: cubit,
            selector: (state) => (state is DateInputState) ? state : null,
            builder: (context, state) {
              return DatePickerFromField(
                  hint: "Birthday",
                  initialValue: state?.input,
                  onDatePick: (date) => cubit.validField(type: RegistrationFieldType.date, input: date));
            },
          ),

          SizedBox(height: SizeConfig.spacingExtraVertical),

          BlocSelector<RegistrationCubit, RegistrationState, ButtonState>(
            bloc: cubit,
            selector: (state) => (state is SubmitState)
                ? state.buttonState
                : ButtonState.disable,
            builder: (context, state) {
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
