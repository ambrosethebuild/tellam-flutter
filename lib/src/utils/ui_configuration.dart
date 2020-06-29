import 'package:flutter/material.dart';

class UIConfiguration {
  Color primaryColor;
  Color primaryDarkColor;
  Color accentColor;
  Color buttonColor;

  Color agentMessageBackgroundColor;
  Color userMessageBackgroundColor;

  UIConfiguration({
    this.primaryColor,
    this.primaryDarkColor,
    this.accentColor,
    this.buttonColor,
  }) {
    this.primaryColor ??= Colors.teal[500];
    this.primaryDarkColor ??= Colors.teal[700];
    this.accentColor ??= Colors.teal[400];
    this.buttonColor ??= Colors.teal[300];

    this.agentMessageBackgroundColor ??= Colors.teal[50];
    this.userMessageBackgroundColor ??= Colors.teal[100];
  }
}
