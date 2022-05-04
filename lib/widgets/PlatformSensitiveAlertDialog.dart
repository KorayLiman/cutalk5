import 'dart:io';

import 'package:ctlk2/widgets/PlatformSensitiveWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformSensitiveAlertDialog extends PlatformSensitiveWidget {
  final String title;
  final String content;
  final String mainButtonText;
  

  PlatformSensitiveAlertDialog(
      {required this.title,
      required this.content,
   
      required this.mainButtonText});

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
        actions: _SetDialogButtons(context));
  }

  List<Widget> _SetDialogButtons(BuildContext context) {
    final AllButtons = <Widget>[];
    if (Platform.isIOS) {
      AllButtons.add(CupertinoDialogAction(
        child: Text(mainButtonText),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ));
    } else {
      AllButtons.add(TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(mainButtonText)));
    }
    return AllButtons;
  }
}
