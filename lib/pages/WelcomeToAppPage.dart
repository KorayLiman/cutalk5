import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:ctlk2/constants/constants.dart';
import 'package:ctlk2/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_ui_widgets/buttons/gradient_elevated_button.dart';
import 'package:gradient_ui_widgets/buttons/gradient_floating_action_button.dart';
import 'package:gradient_ui_widgets/buttons/gradient_text_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation animation1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GradientFloatingActionButton.extended(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (route) => false);
          },
          label: const Text("Kayıt ol/Giriş yap"),
          icon: Icon(Icons.supervised_user_circle),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(240, 43, 17, 1),
            Color.fromRGBO(244, 171, 25, 1)
          ])),
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(88, 117, 251, 1),
              Color.fromRGBO(122, 150, 255, 1)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                      RotateAnimatedText("Hoşgeldin Cumhuriyet Üniversiteli,",
                          textStyle: GoogleFonts.ubuntu(
                              fontSize: 26,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      RotateAnimatedText("Hemen hesabını oluştur,",
                          textStyle: GoogleFonts.ubuntu(
                              fontSize: 26,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      RotateAnimatedText("Uygulamanın keyfini çıkar",
                          textStyle: GoogleFonts.ubuntu(
                              fontSize: 26,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center)
                    ]),
                  ),
                ),
              ),
              /*flex: 2,
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("assets/images/cu.png"),
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Talk",
                                style: GoogleFonts.merriweather(fontSize: 32))
                          ],
                        ),
                      ],
                    ),*/
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      GlassContainer(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text("Cü Talk Nedir ?",
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 26,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold)),
                            ),
                            AnimatedTextKit(
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(
                                  "Cü Talk Cumhuriyet Üniversite'li öğrencileri için yapılmış bir iletişim kanalıdır. Eşyalarınızı satabilir, ders notu isteyebilir, her türlü paylaşımlarınızı yapabilirsiniz.",
                                  textAlign: TextAlign.center,
                                  textStyle: GoogleFonts.ubuntu(
                                    fontSize: 20,
                                    color: Colors.white70,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage("assets/images/cu.png"),
                                    height: 50,
                                    width: 50,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Talk",
                                    style: GoogleFonts.ubuntu(
                                        fontSize: 32, color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        height: 300,
                        width: 400,
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.40),
                            Colors.white.withOpacity(0.10)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        borderGradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.60),
                            Colors.white.withOpacity(0.10),
                            Colors.lightBlueAccent.withOpacity(0.05),
                            Colors.lightBlueAccent.withOpacity(0.6)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 0.39, 0.40, 1.0],
                        ),
                        blur: 15.0,
                        borderWidth: 1.5,
                        elevation: 3.0,
                        isFrostedGlass: true,
                        shadowColor: Colors.black.withOpacity(0.20),
                        alignment: Alignment.center,
                        frostedOpacity: 0.12,
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(8.0),
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
