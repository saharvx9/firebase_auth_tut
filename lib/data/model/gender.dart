import 'package:flutter/material.dart';

enum Gender {
  female(Icons.female),
  male(Icons.male),
  unknown(Icons.face);

  final IconData icon;

  const Gender(this.icon);
}
