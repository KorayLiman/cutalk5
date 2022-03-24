import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ctlk2/models/user.dart';
import 'package:ctlk2/pages/GeneralPage.dart';
import 'package:ctlk2/pages/PasswordResetPage.dart';
import 'package:ctlk2/viewmodels/usermodel.dart';
import 'package:ctlk2/widgets/PlatformSensitiveAlertDialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum FormType { register, login }

class _LoginPageState extends State<LoginPage> {
  FormType _formType = FormType.login;
  late String _buttonText, _bottomtextleft, _bottomtextright;
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? password;
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingController3 = TextEditingController();
  final TextEditingController _textEditingController4 = TextEditingController();
  final TextEditingController _textEditingController5 = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    _textEditingController3.dispose();
    _textEditingController4.dispose();
    _textEditingController5.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _usermodel = Provider.of<UserModel>(context);
    _buttonText = _formType == FormType.login ? "Giriş yap" : "Kayıt ol";
    _bottomtextleft =
        _formType == FormType.login ? "Hesabınız yok mu?" : "Hesabınız varsa";
    _bottomtextright =
        _formType == FormType.login ? "Kayıt olun" : "Giriş yapın";
    return Form(
      key: _formKey,
      child: Scaffold(
          body: _formType == FormType.login
              ? CreateFormLogin()
              : CreateFormSignUp()),
    );
  }

  void _switch() {
    setState(() {
      _textEditingController1.clear();
      _textEditingController2.clear();
      _textEditingController3.clear();
      _textEditingController4.clear();
      _textEditingController5.clear();
      _formType =
          _formType == FormType.login ? FormType.register : FormType.login;
    });

    if (name != null) {
      name = null;
    }
    if (email != null) {
      email = null;
    }
    if (password != null) {
      password = null;
    }
  }

  Widget CreateFormLogin() {
    final _usermodel = Provider.of<UserModel>(context);
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(57, 138, 229, 1),
            Color.fromRGBO(115, 174, 244, 1)
          ])),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Center(
                  child: Text(
                    "Giriş yapın",
                    style:
                        GoogleFonts.ubuntu(color: Colors.white, fontSize: 32),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0, left: 30),
                child: Text(
                  "Email",
                  style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 20),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                child: TextFormField(
                  onChanged: ((value) {
                    email = value;
                  }),
                  controller: _textEditingController1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (!EmailValidator.validate(value!)) {
                      return "Gerçersiz mail";
                    } else {}
                  },
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    fillColor: Colors.white.withOpacity(0.2),
                    filled: true,
                    hintText: "Email'inizi giriniz",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: Text(
                  "Şifreniz",
                  style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 20),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                child: TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  controller: _textEditingController2,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (input) {
                    if (input!.length < 6) {
                      return "Şifre 6 haneden büyük olmalı";
                    } else {}
                  },
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.white,
                    ),
                    fillColor: Colors.white.withOpacity(0.2),
                    filled: true,
                    hintText: "Şifrenizi giriniz",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              Platform.isIOS
                                  ? CupertinoPageRoute(
                                      builder: (context) => PasswordResetPage(),
                                    )
                                  : MaterialPageRoute(
                                      builder: (context) => PasswordResetPage(),
                                    ));
                        },
                        child: Text(
                          "Şifrenizi mi unuttunuz?",
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => _FormSubmit(_formType),
                    child: Text(
                      _buttonText,
                      style:
                          GoogleFonts.ubuntu(color: Colors.blue, fontSize: 18),
                    ),
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(300, 52)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)))),
                  ),
                ),
              ),
              const Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    "-veya-",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    "Şunlarla giriş yapın",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // const CircleAvatar(
                    //   radius: 24,
                    //   backgroundColor: Colors.white,
                    //   backgroundImage:
                    //       AssetImage("assets/images/facebook_64px.png"),
                    // ),
                    IconButton(
                        iconSize: 48,
                        onPressed: () {
                          _usermodel.signinwithGoogle();
                        },
                        icon: const CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              AssetImage("assets/images/google.png"),
                          backgroundColor: Colors.white,
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_bottomtextleft, style: TextStyle(color: Colors.white)),
                  TextButton(
                      onPressed: () => _switch(),
                      child: Text(
                        _bottomtextright,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget CreateFormSignUp() {
    final _usermodel = Provider.of<UserModel>(context);
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(57, 138, 229, 1),
            Color.fromRGBO(115, 174, 244, 1)
          ])),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Center(
                  child: Text(
                    "Giriş yapın",
                    style:
                        GoogleFonts.ubuntu(color: Colors.white, fontSize: 32),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0, left: 30),
                child: Text(
                  "Adınız",
                  style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 20),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    name = value;
                  },
                  validator: (value) {
                    if (value!.length < 3) {
                      return "İsim 3 karakterden küçük olamaz";
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  controller: _textEditingController3,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.supervised_user_circle,
                      color: Colors.white,
                    ),
                    fillColor: Colors.white.withOpacity(0.2),
                    filled: true,
                    hintText: "Adınızı giriniz",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: Text(
                  "Email",
                  style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 20),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                child: TextFormField(
                  controller: _textEditingController4,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (!EmailValidator.validate(value!)) {
                      return "Gerçersiz mail";
                    } else {}
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    fillColor: Colors.white.withOpacity(0.2),
                    filled: true,
                    hintText: "Email'inizi giriniz",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: Text(
                  "Şifreniz",
                  style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 20),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                child: TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  controller: _textEditingController5,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (input) {
                    if (input!.length < 6) {
                      return "Şifre 6 haneden büyük olmalı";
                    } else {}
                  },
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.white,
                    ),
                    fillColor: Colors.white.withOpacity(0.2),
                    filled: true,
                    hintText: "Şifrenizi giriniz",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Şifrenizi mi unuttunuz?",
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => _FormSubmit(_formType),
                    child: Text(
                      _buttonText,
                      style:
                          GoogleFonts.ubuntu(color: Colors.blue, fontSize: 18),
                    ),
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(300, 52)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)))),
                  ),
                ),
              ),
              const Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    "-veya-",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    "Şunlarla giriş yapın",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // const CircleAvatar(
                    //   radius: 24,
                    //   backgroundColor: Colors.white,
                    //   backgroundImage:
                    //       AssetImage("assets/images/facebook_64px.png"),
                    // ),
                    IconButton(
                        iconSize: 48,
                        onPressed: () {
                          _usermodel.signinwithGoogle();
                        },
                        icon: const CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              AssetImage("assets/images/google.png"),
                          backgroundColor: Colors.white,
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_bottomtextleft,
                      style: const TextStyle(color: Colors.white)),
                  TextButton(
                      onPressed: () => _switch(),
                      child: Text(
                        _bottomtextright,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  _FormSubmit(FormType formType) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (formType == FormType.login) {
        if (email == null ||
            !email!.contains("@") ||
            password == null ||
            password!.length < 6) {
          PlatformSensitiveAlertDialog(
            title: "Hata",
            content: "Bilgileriniz yanlış girildi",
            mainButtonText: "Tamam",
          ).show(context);
        } else {
          try {
            CuTalkUser? LoggedInUser =
                await _userModel.signinwithEmailAndPassword(email!, password!);
            Route route = Platform.isIOS
                ? CupertinoPageRoute(builder: ((context) => GeneralPage()))
                : MaterialPageRoute(
                    builder: (context) => GeneralPage(),
                  );
            Navigator.pushAndRemoveUntil(context, route, (route) => false);
          } catch (error) {
            PlatformSensitiveAlertDialog(
                    title: "Kullanıcı Bulunamadı",
                    content:
                        "Belirtilen mail ve şifre ile eşleşen kullanıcı bulunamadı",
                    mainButtonText: "Tamam")
                .show(context);
          }
        }
      } else {
        if (name == null ||
            name!.length < 3 ||
            email == null ||
            !email!.contains("@") ||
            password == null ||
            password!.length < 6) {
          PlatformSensitiveAlertDialog(
                  title: "Hata",
                  content: "Bilgileriniz yanlış girildi",
                  mainButtonText: "Tamam")
              .show(context);
        } else {
          try {
            CuTalkUser? RegisteredUser = await _userModel
                .createUserWithEmailandPassword(name!, email!, password!);
            Route route = Platform.isIOS
                ? CupertinoPageRoute(
                    builder: ((context) => const GeneralPage()))
                : MaterialPageRoute(
                    builder: (context) => const GeneralPage(),
                  );
            Navigator.pushAndRemoveUntil(context, route, (route) => false);
          } catch (error) {
            print(error);
            print(error);

            print(error);
            print(error);
            print(error);
            print(error);
            print(error);
            print(error);

            PlatformSensitiveAlertDialog(
                    title: "Hata",
                    content: "Mail kullanılıyor",
                    mainButtonText: "Tamam")
                .show(context);
          }
        }
      }
    } else
      PlatformSensitiveAlertDialog(
              title: "İnternet yok",
              content: "Lütfen internete bağlanın",
              mainButtonText: "Tamam")
          .show(context);
  }
}
