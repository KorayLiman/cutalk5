import 'dart:io';

import 'package:ctlk2/widgets/PlatformSensitiveWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformSensitiveDeleteButton extends PlatformSensitiveWidget {
  final String title;
  final String content;
  final String mainButtonText;
  final String secondaryButtonText;
  final MaterialColor? mainButtonColor;
  final MaterialColor? secondaryButtonColor;

  final VoidCallback callback;

  PlatformSensitiveDeleteButton(
      {required this.title,
      required this.callback,
      this.mainButtonColor,
      this.secondaryButtonColor,
      required this.content,
      required this.mainButtonText,
      required this.secondaryButtonText});

  Future<void> show(BuildContext context) async {
    Platform.isIOS
        ? await showCupertinoDialog(
            context: context, builder: (context) => this)
        : await showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _SetDialogButtons(context),
    );
  }

  @override
  Widget buildIosWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _SetDialogButtons(context),
    );
  }

  List<Widget> _SetDialogButtons(BuildContext context) {
    final AllButtons = <Widget>[];
    if (Platform.isIOS) {
      AllButtons.add(CupertinoDialogAction(
          child: Text(secondaryButtonText,
              style: TextStyle(color: secondaryButtonColor ?? Colors.blue)),
          onPressed: () {
             Navigator.pop(context);
          }));
      AllButtons.add(CupertinoDialogAction(
        child: Text(
          mainButtonText,
          style: TextStyle(color: mainButtonColor ?? Colors.blue),
        ),
        onPressed: () {
          callback();
        },
      ));
    } else {
      AllButtons.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(secondaryButtonText,
              style: TextStyle(color: secondaryButtonColor ?? Colors.blue))));
      AllButtons.add(TextButton(
          onPressed: () {
            callback();
          },
          child: Text(mainButtonText,
              style: TextStyle(color: mainButtonColor ?? Colors.blue))));
    }
    return AllButtons;
  }
}
