import 'package:flutter/material.dart';
import 'package:tellam/tellam.dart';

class ChatAppBar extends PreferredSize {
  final Widget child;
  final double height;
  final Color color;

  ChatAppBar({
    @required this.child,
    this.height = kToolbarHeight,
    this.color,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: this.color ?? Tellam.uiConfiguration.primaryDarkColor,
      alignment: Alignment.center,
      child: child,
    );
  }
}
