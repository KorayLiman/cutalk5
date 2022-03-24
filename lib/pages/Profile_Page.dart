import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ctlk2/viewmodels/chatmodel.dart';
import 'package:ctlk2/viewmodels/usermodel.dart';
import 'package:ctlk2/widgets/PlatformSensitiveAlertDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_ui_widgets/buttons/gradient_floating_action_button.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  String? name;
  String? password;
  File? image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final _usermodel = Provider.of<UserModel>(context);
    final _chatmodel = Provider.of<ChatModel>(context);
    return Scaffold(
      floatingActionButton: GradientFloatingActionButton.extended(
          onPressed: () {
            _usermodel.signOut();
          },
          label: const Text("Çıkış"),
          icon: const Icon(Icons.logout),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(240, 43, 17, 1),
            Color.fromRGBO(244, 171, 25, 1)
          ])),
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(57, 138, 229, 1),
          Color.fromRGBO(115, 174, 244, 1)
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.white.withOpacity(1),
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 120,
                          child: Column(
                            children: [
                              TextButton.icon(
                                  onPressed: () {
                                    _PictureFromCamera();
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.camera_alt),
                                  label: const Text("Kameradan çek")),
                              TextButton.icon(
                                  onPressed: () {
                                    _PictureFromGallery();
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.browse_gallery),
                                  label: const Text("Galeriden seç"))
                            ],
                          ),
                        );
                      });
                },
                //
                //
                //Profil Fotosu anında güncellenmiyor
                //
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.transparent,
                  backgroundImage: image == null
                      ? NetworkImage(_usermodel.user!.ProfileURL!)
                      : FileImage(image!) as ImageProvider,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, right: 4.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.camera_alt),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80.0, left: 30),
              child: Text(
                "Kullanıcı adınız",
                style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
              child: TextFormField(
                initialValue: _usermodel.user!.UserName,
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
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.supervised_user_circle,
                    color: Colors.white,
                  ),
                  fillColor: Colors.white.withOpacity(0.2),
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 30),
              child: Text(
                "Şifreniz",
                style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
              child: TextFormField(
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value!.length < 6) {
                    return "Şifre 6 karakterden küçük olamaz";
                  }
                },
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Yeni şifreniz",
                  prefixIcon: const Icon(
                    Icons.supervised_user_circle,
                    color: Colors.white,
                  ),
                  fillColor: Colors.white.withOpacity(0.2),
                  filled: true,
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
                  onPressed: () => _Submit(),
                  child: Text(
                    "Değişiklikleri kaydet",
                    style: GoogleFonts.ubuntu(color: Colors.blue, fontSize: 18),
                  ),
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(300, 52)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _Submit() async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (name == null) {
        name = _userModel.user!.UserName;
      }
      if (name == null || name!.length < 3) {
        PlatformSensitiveAlertDialog(
          title: "Hata",
          content: "Bilgileriniz yanlış girildi",
          mainButtonText: "Tamam",
        ).show(context);
      } else {
        try {
          if (password != null && password!.length < 6) {
            await FirebaseAuth.instance.currentUser!.updatePassword(password!);
          }

          if (name != _userModel.user!.UserName) {
            _userModel.updateUserName(_userModel.user!.UserID, name!);
          }
          ;
          setState(() {});
          PlatformSensitiveAlertDialog(
                  title: "Başarılı",
                  content: "Bilgileriniz başarıyla güncellendi",
                  mainButtonText: "Tamam")
              .show(context);
        } catch (error) {
          PlatformSensitiveAlertDialog(
                  title: "Hata",
                  content: "Bir hata oluştu",
                  mainButtonText: "Tamam")
              .show(context);
        }
      }
    }
  }

  Future<void> _PictureFromCamera() async {
    final _usermodel = Provider.of<UserModel>(context, listen: false);
    
      final XFile? img = await _picker.pickImage(source: ImageSource.camera);

      var url = await _usermodel.uploadFile(
          _usermodel.user!.UserID, "Profile_Picture", image);
      setState(() {});
    
  }

  Future<void> _PictureFromGallery() async {
    final _usermodel = Provider.of<UserModel>(context, listen: false);
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    image = File(img!.path);

    var url = await _usermodel.uploadFile(
        _usermodel.user!.UserID, "Profile_Picture", image);
    setState(() {});
  }
}
