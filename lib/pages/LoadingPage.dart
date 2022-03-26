import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200.withOpacity(0.6),
      body: Center(
        child: GradientCircularProgressIndicator(
            valueGradient: LinearGradient(colors: [
          Color.fromRGBO(240, 43, 17, 1),
          Color.fromRGBO(244, 171, 25, 1)
        ])),
      ),
    );
  }
}
