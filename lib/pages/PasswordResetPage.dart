import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordResetPage extends StatelessWidget {
  PasswordResetPage({Key? key}) : super(key: key);
  TextEditingController _textEditingController = TextEditingController();
  String? email;
  final snackBar = const SnackBar(
  content:  Text('Mailinize link gönderildi'),
 
);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(57, 138, 229, 1),
              Color.fromRGBO(115, 174, 244, 1)
            ])),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text("Şifrenizi sıfırlayın",
                      style: GoogleFonts.ubuntu(
                          color: Colors.white, fontSize: 27))),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                child: TextFormField(
                  onChanged: ((value) {
                    email = value;
                  }),
                  controller: _textEditingController,
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
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (email != null) {
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email!.trim()).then((value) => ScaffoldMessenger.of(context).showSnackBar(snackBar));
                            FocusManager.instance.primaryFocus?.unfocus();
                        _textEditingController.clear();
                      }
                    },
                    child: Text(
                      "Mailime sıfırlama linki gönder",
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
            ],
          )
        ],
      ),
    );
  }
}
