import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctlk2/SwearBlocker.dart';
import 'package:ctlk2/models/Chat.dart';
import 'package:ctlk2/pages/DetailsPage.dart';
import 'package:ctlk2/viewmodels/chatmodel.dart';
import 'package:ctlk2/viewmodels/usermodel.dart';
import 'package:ctlk2/widgets/PlatformSensitiveAlertDialog.dart';
import 'package:ctlk2/widgets/PlatformSensitiveDeleteButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DiscussionGeneral extends StatefulWidget {
  DiscussionGeneral({Key? key}) : super(key: key);

  @override
  State<DiscussionGeneral> createState() => _DiscussionGeneralState();
}

class _DiscussionGeneralState extends State<DiscussionGeneral> {
  late bool isIos;
  final TextEditingController _textEditingController = TextEditingController();
  String DropdownValue = "En Yeni";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isIos = Platform.isIOS ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final _chatmodel = Provider.of<ChatModel>(context);
    final _usermodel = Provider.of<UserModel>(context);
    return Scaffold(
      floatingActionButton: GradientFloatingActionButton.extended(
          onPressed: () {
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              print(_usermodel.user!.IsBlocked);
              if (_usermodel.user!.IsBlocked == false) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ListTile(
                        title: TextFormField(
                          controller: _textEditingController,
                          onFieldSubmitted: (value) {
                            if (value.length > 0) {
                              bool ContainsSwear = false;
                              SwearBlockerClass.SwearBlocker.forEach((element) {
                                if (element.length > 3) {
                                  if (value.toLowerCase().contains(element)) {
                                    ContainsSwear = true;
                                  }
                                }
                              });
                              if (ContainsSwear == false) {
                                _textEditingController.clear();
                                Chat ch = Chat(
                                    Content: value,
                                    ChatID:
                                        _usermodel.user!.UserName.toString() +
                                            Uuid().v4().toString(),
                                    OwnerId: _usermodel.user!.UserID,
                                    OwnerProfileUrl:
                                        _usermodel.user!.ProfileURL!,
                                    OwnerName: _usermodel.user!.UserName!,
                                    OwnerEmail: _usermodel.user!.Email,
                                    IsPrivate: false);
                                _chatmodel.SaveChat(ch);
                                Navigator.pop(context);
                              } else {
                                FocusManager.instance.primaryFocus?.unfocus();
                                _textEditingController.clear();
                                setState(() {});
                                PlatformSensitiveAlertDialog(
                                  title: "K??f??rl?? i??erik",
                                  content: "K??f??r veya hakaret yasakt??r",
                                  mainButtonText: "Anlad??m",
                                ).show(context);
                              }
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Sohbet i??eri??inizi yaz??n"),
                          autofocus: true,
                        ),
                      ),
                    );
                  },
                );
                setState(() {});
              } else {
                PlatformSensitiveAlertDialog(
                  title: "Blokland??n??z",
                  content:
                      "Bir Kullan??c?? taraf??ndan k??t??ye kullan??m sebebiyle blokland??n??z. Gereksiz yere blokland??????n??z?? d??????n??yorsan??z uygulama i??erisindeki Hata ve g??r???? bildir k??sm??ndan ula??abilirsiniz",
                  mainButtonText: "Tamam",
                ).show(context);
              }
            } else {
              PlatformSensitiveAlertDialog(
                title: "Email onay??",
                content:
                    "Sohbet olu??turmak i??in mail adresinize gelen onay linkini t??klay??n??z. Daha sonra ????k???? yap??p tekrar giriniz. D??KKAT EMAIL ONAYI SPAM KUTUSUNA G??DEB??L??R L??TFEN SPAM KUTUSUNU KONTROL ED??N??Z.",
                mainButtonText: "Tamam",
              ).show(context);
            }
          },
          label: const Text("Sohbet olu??tur"),
          icon: const Icon(Icons.message),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(240, 43, 17, 1),
            Color.fromRGBO(244, 171, 25, 1)
          ])),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 140.0),
        child: Container(
          height: MediaQuery.of(context).size.height - 140,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: DropdownButton<String>(
                    items: [
                      DropdownMenuItem(
                        child: const Text("En Yeni"),
                        value: "En Yeni",
                      ),
                      DropdownMenuItem(
                        child: const Text("En Pop??ler"),
                        value: "En Pop??ler",
                      ),
                      DropdownMenuItem(
                        child: const Text("En ??ok Yorum"),
                        value: "En ??ok Yorum",
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        DropdownValue = value!;
                      });
                    },
                    value: DropdownValue,
                    onTap: () {},
                  ),
                ),
              )),
              Expanded(
                flex: 20,
                child: FutureBuilder<List<Chat>>(
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: GradientCircularProgressIndicator(
                            valueGradient: LinearGradient(colors: [
                          Color.fromRGBO(240, 43, 17, 1),
                          Color.fromRGBO(244, 171, 25, 1)
                        ])),
                      );
                    } else {
                      var allChats = snapshot.data!;
                      return RefreshIndicator(
                        onRefresh: () {
                          return OnRefresh();
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemExtent: 80,
                          itemBuilder: (context, index) {
                            var CurrentChat = allChats[index];
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    isIos
                                        ? CupertinoPageRoute(
                                            builder: (context) => DetailsPage(
                                              chat: CurrentChat,
                                            ),
                                          )
                                        : MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                              chat: CurrentChat,
                                            ),
                                          ));
                              },
                              onLongPress: () {
                                if (CurrentChat.OwnerId ==
                                        _usermodel.user!.UserID ||
                                    _usermodel.user!.Email ==
                                        "2020123170@cumhuriyet.edu.tr") {
                                  PlatformSensitiveDeleteButton(
                                    title: "Sil",
                                    callback: () {
                                      Navigator.pop(context);
                                      FirebaseFirestore.instance
                                          .collection("chats")
                                          .doc(CurrentChat.ChatID)
                                          .delete();
                                      
                                      setState(() {});
                                    },
                                    content: "Sohbeti silmek istiyor musunuz?",
                                    mainButtonText: "Evet",
                                    secondaryButtonText: "Hay??r",
                                  ).show(context);
                                }
                              },
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    NetworkImage(CurrentChat.OwnerProfileUrl),
                              ),
                              title: Text(
                                CurrentChat.OwnerName,
                                maxLines: 1,
                                style: GoogleFonts.ubuntu(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: CurrentChat.OwnerEmail ==
                                          "2020123170@cumhuriyet.edu.tr"
                                      ? Colors.orange
                                      : Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                CurrentChat.Content,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.ubuntu(
                                    color: CurrentChat.OwnerEmail ==
                                            "2020123170@cumhuriyet.edu.tr"
                                        ? Colors.orange
                                        : Colors.black),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.favorite,
                                            color: Colors.pink,
                                          ),
                                          Text(
                                              CurrentChat.LikeCount.toString()),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.message,
                                          color: CurrentChat.CommentCount! > 0
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        Text(CurrentChat.CommentCount
                                            .toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.length,
                        ),
                      );
                    }
                  },
                  future: GetChats(DropdownValue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Chat>> GetChats(String DropdownValue) async {
    final _chatmodel = Provider.of<ChatModel>(context, listen: false);
    switch (DropdownValue) {
      case "En Yeni":
        return await _chatmodel.GetAllChats(false);
      case "En Pop??ler":
        return await _chatmodel.GetMostPopularChats(false);
      case "En ??ok Yorum":
        return await _chatmodel.GetMostCommentedChats(false);
      default:
        return [];
    }
  }

  Future<void> OnRefresh() async {
    final _usermodel = Provider.of<UserModel>(context, listen: false);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }
}
