import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum FormType { register, login }

class _LoginPageState extends State<LoginPage> {
  FormType _formType = FormType.login;
  late String _buttonText, _bottomtextleft, _bottomtextright;

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.login ? "Giriş yap" : "Kayıt ol";
    _bottomtextleft =
        _formType == FormType.login ? "Hesabınız yok mu?" : "Hesabınız varsa";
    _bottomtextright =
        _formType == FormType.login ? "Kayıt olun" : "Giriş yapın";
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
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
                    style:
                        GoogleFonts.ubuntu(color: Colors.white, fontSize: 20),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
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
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                        color: Colors.white,
                      ),
                      fillColor: Colors.white.withOpacity(0.2),
                      filled: true,
                      hintText: "Şifrenizi giriniz",
                      hintStyle: TextStyle(color: Colors.white),
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
                      onPressed: () {},
                      child: Text(
                        _buttonText,
                        style: GoogleFonts.ubuntu(
                            color: Colors.blue, fontSize: 18),
                      ),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(300, 52)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      "-veya-",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
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
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage("assets/images/facebook_64px.png"),
                      ),
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage("assets/images/google.png"),
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_bottomtextleft,
                        style: TextStyle(color: Colors.white)),
                    TextButton(
                        onPressed: () => _switch(),
                        child: Text(
                          _bottomtextright,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _switch() {
    setState(() {
      _formType =
          _formType == FormType.login ? FormType.register : FormType.login;
    });
  }
}
