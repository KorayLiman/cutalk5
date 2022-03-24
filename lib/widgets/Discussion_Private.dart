import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:gradient_ui_widgets/buttons/gradient_floating_action_button.dart';
import 'package:gradient_ui_widgets/progress_indicator/gradient_progress_indicator.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DiscussionPrivate extends StatefulWidget {
  const DiscussionPrivate({Key? key}) : super(key: key);

  @override
  State<DiscussionPrivate> createState() => _DiscussionPrivateState();
}

class _DiscussionPrivateState extends State<DiscussionPrivate> {
  late bool isIos;
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
      backgroundColor: Colors.transparent,
      floatingActionButton: _usermodel.user!.IsFromUniversity
          ? GradientFloatingActionButton.extended(
              onPressed: () {
                if (FirebaseAuth.instance.currentUser!.emailVerified) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: ListTile(
                          title: TextFormField(
                            onFieldSubmitted: (value) {
                              if (value.length > 0) {
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
                                    IsPrivate: true);
                                _chatmodel.SaveChat(ch);
                                Navigator.pop(context);
                                ;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Sohbet içeriğinizi yazın"),
                            autofocus: true,
                          ),
                        ),
                      );
                    },
                  );
                  setState(() {});
                } else {
                  PlatformSensitiveAlertDialog(
                    title: "Email onayı",
                    content:
                        "Sohbet oluşturmak için mail adresinize gelen onay linkini tıklayınız",
                    mainButtonText: "Tamam",
                  ).show(context);
                }
              },
              label: const Text("Sohbet oluştur"),
              icon: const Icon(Icons.message),
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(240, 43, 17, 1),
                Color.fromRGBO(244, 171, 25, 1)
              ]))
          : null,
      body: Padding(
        padding: const EdgeInsets.only(top: 140.0),
        child: Container(
          height: MediaQuery.of(context).size.height - 140,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(50))),
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
                          if (CurrentChat.OwnerId == _usermodel.user!.UserID ||
                              _usermodel.user!.Email ==
                                  "2020123170@cumhuriyet.edu.tr") {
                            PlatformSensitiveDeleteButton(
                              title: "Sil",
                              callback: () {
                                FirebaseFirestore.instance
                                    .collection("chats")
                                    .doc(CurrentChat.ChatID)
                                    .delete();
                                setState(() {});
                              },
                              content: "Sohbeti silmek istiyor musunuz?",
                              mainButtonText: "Evet",
                              secondaryButtonText: "Hayır",
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
                          child: Column(
                            children: [
                              const Icon(Icons.message),
                              Text(CurrentChat.CommentCount.toString())
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
            future: GetChats(),
          ),
        ),
      ),
    );
  }

  Future<List<Chat>> GetChats() async {
    final _chatmodel = Provider.of<ChatModel>(context, listen: false);
    return await _chatmodel.GetAllChats(true);
  }

  Future<void> OnRefresh() async {
    final _usermodel = Provider.of<UserModel>(context, listen: false);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }
}
