import 'package:ctlk2/pages/GeneralPage.dart';
import 'package:ctlk2/pages/LoginPage.dart';
import 'package:ctlk2/pages/WelcomeToAppPage.dart';
import 'package:ctlk2/viewmodels/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _usermodel = Provider.of<UserModel>(context);
    if (_usermodel.viewstate == ViewState.idle) {
      if (_usermodel.user == null) {
        return const LoginPage();
      } else {
        return const GeneralPage();
      }
    } else {
      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(88, 117, 251, 1),
            Color.fromRGBO(122, 150, 255, 1)
          ])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
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
        ),
      );
    }
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
