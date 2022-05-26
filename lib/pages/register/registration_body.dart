import 'package:firebase_auth_tut/pages/register/bloc/registration_cubit.dart';
import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:firebase_auth_tut/widgets/app_dialog.dart';
import 'package:firebase_auth_tut/widgets/textfield/edit_text.dart';
import 'package:firebase_auth_tut/widgets/textfield/password_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      listener: (context, state) {
        print("show state: $state");
        switch(state.runtimeType) {
          case DialogRegisterState:
            final dialogState = (state as DialogRegisterState).state;
            AppDialog.displayDialog(context, dialogState);
            break;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

          SizedBox(height: SizeConfig.spacingMediumVertical),

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
              return ProgressButton(state: ButtonState.enable, text: "Submit", onClick: () => cubit.signIn());
            },
          )
        ],
      ),
    );
  }
}
