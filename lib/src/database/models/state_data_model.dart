import 'package:flutter/material.dart';

class StateDataModel {
  IconData iconData;

  Color iconColor;

  String assetName;

  double assetWidth;

  double assetHeight;

  String title;

  String description;

  bool showActionButton;

  Function actionFunction;

  String actionButtonTitle;

  StateDataModel({
    this.iconData = Icons.error,
    this.iconColor = Colors.red,
    this.assetName = "",
    this.assetWidth = 0,
    this.assetHeight = 0,
    this.title = "An error occurred",
    this.description = "There was an error processing your request. Please try again",
    this.actionButtonTitle = "Re-try",
    this.showActionButton = false,
    this.actionFunction,
  });
}
