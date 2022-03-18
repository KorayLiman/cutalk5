import 'package:ctlk2/pages/WelcomeToAppPage.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: SetPrefs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == false) {
              return WelcomePage();
            } else {
              return const Scaffold(
                body: Center(
                  child: Text("hello"),
                ),
              );
            }
          } else {
            return Scaffold(backgroundColor: Colors.purple,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: LinearProgressIndicator(
                          color: Color.fromRGBO(131, 0, 254, 1),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: LinearProgressIndicator(
                          color: Color.fromRGBO(219, 0, 254, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        });
  }

  Future<bool> SetPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("WelcomeCounter") == null) {
      prefs.setInt("WelcomeCounter", 0);
      return true;
    } else {
      await prefs.setInt(
          "WelcomeCounter", (prefs.getInt("WelcomeCounter"))! + 1);
      return false;
    }
  }
}
