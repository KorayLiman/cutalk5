import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctlk2/pages/Profile_Page.dart';
import 'package:ctlk2/viewmodels/chatmodel.dart';
import 'package:ctlk2/viewmodels/usermodel.dart';
import 'package:ctlk2/widgets/Discussion_General.dart';
import 'package:ctlk2/widgets/Discussion_Private.dart';
import 'package:ctlk2/widgets/PlatformSensitiveAlertDialog.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? Subject, Content;
  int CurrentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      _HandleTabSelection();
    });
  }

  void _HandleTabSelection() {
    setState(() {});
  }

  bool _isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser!.emailVerified == false) {}
    final _usermodel = Provider.of<UserModel>(context);
    final _chatmodel = Provider.of<ChatModel>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        endDrawer: Drawer(
            child: Column(
          children: [
            UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromRGBO(88, 117, 251, 1),
                  Color.fromRGBO(122, 150, 255, 1)
                ])),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(_usermodel.user!.ProfileURL!),
                ),
                accountName: Text(_usermodel.user!.UserName!),
                accountEmail: Text(_usermodel.user!.Email)),
            Platform.isIOS
                ? CupertinoFormRow(
                    child: CupertinoSwitch(
                        value: _isDarkModeEnabled,
                        onChanged: (value) {
                          setState(() {
                            _isDarkModeEnabled = value;
                          });
                        }),
                    prefix: const Text("Koyu mod"),
                  )
                : SwitchListTile(
                    value: _isDarkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _isDarkModeEnabled = value;
                      });
                      print(value);
                    },
                    title: const Text("Koyu mod (Yakında)"),
                  ),
            const AboutListTile(
              child: Text("Hakkında ve uyarılar"),
              applicationName: "Cü Talk",
              applicationVersion: "v1.0",
              aboutBoxChildren: [
                Text("1- Küfür ve hakaret kesinlikle yasaktır."),
                SizedBox(
                  height: 4,
                ),
                Text(
                    "2- Ahlaki kurallara aykırı paylaşımlar yasaktır ve bu kişilerin hesapları engellenir."),
                SizedBox(
                  height: 4,
                ),
                Text(
                    "3- Uygulamanın amacı öğrencilerin öğrencilik hayatını kolaylaştırmak ve aramızdaki iletişimi kolaylaştırmaktır"),
                Text("Icons from https://icons8.com")
              ],
            ),
            ListTile(
              trailing: Icon(Icons.contact_page),
              title: const Text("Hata ve görüş bildir"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 80),
                        child: Material(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Hata ve görüş bildirim formu",
                                  style: GoogleFonts.ubuntu(
                                      color: Colors.black, fontSize: 21),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextFormField(
                                    autofocus: true,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.length < 1) {
                                        return "Konu 1 harften büyük olmalı";
                                      }
                                    },
                                    onChanged: (value) {
                                      Subject = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Konu",
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextFormField(
                                    autofocus: true,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.length < 1) {
                                        return "İçerik 1 harften büyük olmalı";
                                      }
                                    },
                                    onChanged: (value) {
                                      Content = value;
                                    },
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                        hintText: "İçerik",
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      if (Subject != null && Content != null) {
                                        final Email email = Email(
                                            subject: Subject!,
                                            body: Content!,
                                            recipients: [
                                              "koraylimancre@gmail.com"
                                            ]);
                                        try {
                                          await FlutterEmailSender.send(email);
                                        } catch (error) {
                                          print(error);
                                        }

                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        PlatformSensitiveAlertDialog(
                                          title: "Başarılı",
                                          content: "Mail gönderildi",
                                          mainButtonText: "Tamam",
                                        ).show(context);
                                      }
                                    },
                                    child: const Text("Gönder"))
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Made by Koray Liman",
                    style: GoogleFonts.ubuntu(),
                  )
                ],
              ),
            ))
          ],
        )),
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            Container(
              height: 260,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(88, 117, 251, 1),
                Color.fromRGBO(122, 150, 255, 1)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 46),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          NetworkImage(_usermodel.user!.ProfileURL!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _usermodel.user!.UserName!,
                              style: GoogleFonts.ubuntu(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _usermodel.user!.Email,
                              style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // IconButton(
                          //     onPressed: () {},
                          //     icon: Icon(
                          //       Icons.search,
                          //       color: Colors.white,
                          //       size: 28,
                          //     )),
                        ],
                      ),
                    )
                  ],
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
            TabBarView(
              controller: _tabController,
              children: [
                DiscussionGeneral(),
                DiscussionPrivate(),
                ProfilePage()
              ],
            )
          ],
        ),
        bottomNavigationBar: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.blue,
            controller: _tabController,
            tabs: [
              Tab(
                child: const Text(
                  "Genel",
                ),
                iconMargin: EdgeInsets.all(0),
                icon: Icon(Icons.chat_bubble,
                    color: _tabController.index == 0
                        ? Colors.blue.shade900
                        : Colors.grey),
              ),
              Tab(
                  iconMargin: const EdgeInsets.all(0),
                  child: const Text("Cü Özel"),
                  icon: Icon(Icons.chat,
                      color: _tabController.index == 1
                          ? Colors.blue.shade900
                          : Colors.grey)),
              Tab(
                child: const Text(
                  "Profil",
                ),
                iconMargin: const EdgeInsets.all(0),
                icon: Icon(Icons.supervised_user_circle,
                    color: _tabController.index == 2
                        ? Colors.blue.shade900
                        : Colors.grey),
              ),
            ]));
  }

  void CreateChat() {}
}
