import 'package:flutter/material.dart';

enum DialogType {
  error(Icons.error_outline),
  success(Icons.verified_outlined),
  warning(Icons.warning);

  final IconData icon;
  const DialogType(this.icon);

}
class DialogState {
  final String title;
  final String subtitle;
  final DialogType type;
  final String? imageUrl;
  IconData get icon => type.icon;

  DialogState(this.title, this.subtitle, this.type,{this.imageUrl});
}

class BeforeLogOutState extends DialogState {
  BeforeLogOutState():super("Log out","are you sure?",DialogType.warning);
}

class FailedLoadUserState extends DialogState {
  FailedLoadUserState() : super("Error", "failed load user try to refresh", DialogType.error);
}

class WelcomeState extends DialogState {
  final String? name;
  WelcomeState(this.name, String? imageUrl):super("Success","Welcome $name",DialogType.success,imageUrl: imageUrl);
}

class OOopsSomethingWentWrong extends DialogState {
  OOopsSomethingWentWrong():super("Error","something went wrong",DialogType.error);
}

class SocialErrorState extends DialogState {
  SocialErrorState(String error) : super("Social auth failed", "what happened wrong : $error", DialogType.error);
}